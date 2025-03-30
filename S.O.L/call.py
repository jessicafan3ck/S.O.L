from flask import Flask, request, jsonify
from flask_cors import CORS
from twilio.twiml.voice_response import VoiceResponse, Gather, Dial
from twilio.rest import Client
import requests
import json
import os
from dotenv import load_dotenv
import google.generativeai as genai
import urllib.parse

load_dotenv()


def gemini_translate_text(original_text, target_language):
    model = genai.GenerativeModel('gemini-1.5-flash-8b')
    prompt = f"Translate the following text to {target_language}: {original_text}"
    response = model.generate_content(prompt)
    return response.text

app = Flask(__name__)
app.secret_key = os.environ.get('FLASK_SECRET_KEY', 'your-secret-key-here')
CORS(app)

# Twilio credentials (not used in mock mode)
account_sid = os.environ.get('TWILIO_ACCOUNT_SID', '')
auth_token = os.environ.get('TWILIO_AUTH_TOKEN', '')
client = Client(account_sid, auth_token)
twilio_number = os.environ.get('TWILIO_PHONE_NUMBER', '+18336817468')

# Gemini API key
GEMINI_API_KEY = ""

genai.configure(api_key=GEMINI_API_KEY)

active_calls = {}

def get_ngrok_url():
    try:
        response = requests.get('http://localhost:4040/api/tunnels')
        tunnels = json.loads(response.text)['tunnels']
        for tunnel in tunnels:
            if tunnel['proto'] == 'https':
                return tunnel['public_url']
        return None
    except Exception as e:
        print(f"Error fetching Ngrok URL: {e}")
        return None

@app.route("/", methods=['GET'])
def index():
    ngrok_url = get_ngrok_url() or "Ngrok not detected"
    return f"Twilio Voice Application is running! Current Ngrok URL: {ngrok_url}"

@app.route("/voice", methods=['GET', 'POST'])
def voice():
    response = VoiceResponse()
    target = request.args.get('target', '').strip()
    
    gather_action_url = '/process_speech'
    if target:
        gather_action_url += f"?target={target}"
    
    gather = Gather(input='speech', action=gather_action_url, timeout=5, speech_timeout=1, language='en-US')
    gather.say('Hello! Please say your message after the beep.')
    response.append(gather)
    
    redirect_url = '/voice'
    if target:
        redirect_url += f"?target={target}"
    response.redirect(redirect_url)
    return str(response)

@app.route("/process_speech", methods=['GET', 'POST'])
def process_speech():
    try:
        speech_result = request.values.get('SpeechResult', '').strip()
        call_sid = request.values.get('CallSid', '')
        print(f"Call {call_sid}: Transcribed speech: {speech_result}")
        
        target = request.args.get('target', '').strip()
        
        if not speech_result:
            response = VoiceResponse()
            response.say("I did not catch that. Please try again.")
            redirect_url = '/voice'
            if target:
                redirect_url += f"?target={target}"
            response.redirect(redirect_url)
            return str(response)
        
        translation = gemini_translate_text(speech_result, "fr-FR")
        print(f"Call {call_sid}: Translation: {translation}")
        
        if target:
            base_url = get_ngrok_url() or os.environ.get('BASE_URL', 'http://localhost:5001')
            import urllib.parse
            encoded_translation = urllib.parse.quote(translation)
            deliver_url = f"{base_url}/deliver_translation?text={encoded_translation}"
            try:
                outbound_call = client.calls.create(
                    url=deliver_url,
                    to=target,
                    from_=twilio_number,
                    record=True
                )
                print(f"Initiated outbound translation call, SID: {outbound_call.sid}")
            except Exception as outbound_error:
                print("Error initiating outbound translation call:", outbound_error)
        
        response = VoiceResponse()
        response.say(f"Here is the translated message", voice='man', language='en')
        response.say(f"{translation}", voice='man', language='fr-FR')
        response.say("Your message has been forwarded.")
        return str(response)
    except Exception as e:
        print("Error in /process_speech:", e)
        return "Application error", 500

@app.route("/deliver_translation", methods=['GET', 'POST'])
def deliver_translation():
    translation_text = request.args.get('text', '')
    response = VoiceResponse()
    if translation_text:
        response.say(f"Here is the translated message", voice='man', language='en')
        response.say(f"{translation_text}", voice='man', language='fr-FR')
    else:
        response.say("No translation is available.")
    return str(response)

@app.route("/initiate_call/<phone_number>", methods=['GET'])
def initiate_call(phone_number):
    formatted_number = '+' + phone_number if not phone_number.startswith('+') else phone_number
    target = request.args.get('target', '').strip()
    base_url = get_ngrok_url() or os.environ.get('BASE_URL', 'http://localhost:5001')
    webhook_url = f"{base_url}/voice?target=+{target}"
    try:
        call = client.calls.create(
            url=webhook_url,
            to=formatted_number,
            from_=twilio_number,
            record=True
        )
        return jsonify({"status": "success", "message": f"Call initiated to {formatted_number}", "call_sid": call.sid})
    except Exception as e:
        return jsonify({"status": "error", "message": f"Error making call: {str(e)}"})

if __name__ == "__main__":
    ngrok_url = get_ngrok_url()
    if ngrok_url:
        print(f"\n✅ Ngrok is running! Public URL: {ngrok_url}")
    else:
        print("\n⚠️ Ngrok not detected. Start Ngrok with: ngrok http 5001")
    app.run(host='0.0.0.0', port=5001, debug=True)
