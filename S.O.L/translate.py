import google.generativeai as genai

genai.configure(api_key="")

def gemini_translate_text(original_text, target_language):

    model = genai.GenerativeModel('gemini-1.5-flash-8b')
    prompt = f"Translate the following text to {target_language}: {original_text}"

    response = model.generate_content(prompt)
    return response.text