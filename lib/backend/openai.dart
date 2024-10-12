import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

const prompt = """
Analyze the provided image of a supermarket shelf. Identify the products and their prices, and determine the cheapest product. Provide only the name of the cheapest product and its price in the format below.

Output Format:

Cheapest Product: Product Name
Price: Price
""";

String fileToBase64(File imageFile) {
  List<int> imageBytes = imageFile.readAsBytesSync();
  return base64Encode(imageBytes);
}

Future<String?> analyse(String openAiKey, File imageFile) async {
  String fileBase64 = fileToBase64(imageFile);

  Response response = await post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openAiKey', // Replace with your actual API Key
    },
    body: json.encode({
      'model': 'gpt-4o',
      // Specify the model, replace with the actual model you want to use
      'messages': [
        {
          'role': 'user',
          "content": [
            {
              "type": "text",
              // "text": "What fish can you detect in thailand and sharks?"

              "text": prompt
            },
            {
              "type": "image_url",
              "image_url": {"url": 'data:image/jpeg;base64,$fileBase64'}
            }
          ]
        }
      ],
      'max_tokens': 1000
      // Increase this value as needed
    }),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    var contentString = data['choices']?.first['message']['content'] ?? '';

    int jsonStartIndex = contentString.indexOf('{');
    int jsonEndIndex = contentString.lastIndexOf('}');

    if (jsonStartIndex != -1 && jsonEndIndex != -1) {
      var jsonString =
          contentString.substring(jsonStartIndex, jsonEndIndex + 1);
      var contentData = json.decode(jsonString);

      // Process the extracted JSON data
      return contentData.toString();
    }
  }
  return null;
}

