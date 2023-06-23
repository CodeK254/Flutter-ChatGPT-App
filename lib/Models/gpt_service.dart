import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> generateResponse(String text) async {
  String openAiKey = "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";
  final response = await http.post(
    Uri.parse("https://api.openai.com/v1/chat/completions"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $openAiKey",
    },
    body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
            {
                "role": "user",
                "content": text,
            }
        ],
        "max_tokens": 1024,
        "temperature": 0.7
    }),
  );

  if(response.statusCode == 200){
    print(response.body.toString());
    final generatedResponse = jsonDecode(response.body);
    String data = generatedResponse["choices"][0]["message"]["content"];
    return data.toString();
  } else {
    
  }

  return "Sorry!!! No response was generated.";
}