import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:price_pal/providers/storage_provider.dart';
import 'package:provider/provider.dart';

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

    return contentString;
  }

  return null;
}

Future<String?> sendToChatGPT(BuildContext context, File image) async {
  String? apiKey = await Provider.of<StorageProvider>(context).storage.read(key: "apiKey");
  String? result = await analyse(apiKey!, image);

  return result;
}