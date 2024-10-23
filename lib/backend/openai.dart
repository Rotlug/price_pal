import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:price_pal/providers/storage_provider.dart';
import 'package:provider/provider.dart';

const prompt = """
Analyze the provided image of a supermarket shelf. Identify the products and their prices, and determine the cheapest product. If no products are found, output "No Products". Provide only the name of the cheapest product and its price in the format below.

Output Format:

Cheapest Product: Product Name
Price: Price

If no products are found:
No found products
""";

Future<String?> analyse(String openAiKey, Uint8List imageFile) async {
  String fileBase64 = base64Encode(imageFile);

  Response response = await post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openAiKey',
    },
    body: json.encode({
      'model': 'gpt-4o',
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
    }),
  );

  if (response.statusCode != 200) return null;

  Map<dynamic, dynamic> data = json.decode(response.body);
  String? contentString = data['choices'].first['message']['content'];

  return contentString;
}

Future<String?> sendToChatGPT(BuildContext context, Uint8List image) async {
  if (!context.mounted) return null;

  String? apiKey = await Provider.of<StorageProvider>(context, listen: false).storage.read(key: "apiKey");
  String? result = await analyse(apiKey!, image);

  log("RESULT $result");
  return result;
}