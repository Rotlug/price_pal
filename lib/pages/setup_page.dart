import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_pal/components/button.dart';
import 'package:price_pal/components/camera_view.dart';
import 'package:price_pal/components/split_page.dart';
import 'package:price_pal/pages/camera_page.dart';
import 'package:price_pal/providers/storage_provider.dart';
import 'package:provider/provider.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  String inputString = "";

  @override
  Widget build(BuildContext context) {
    bool isReady =
        inputString.toLowerCase().startsWith("sk-") && inputString.length > 30;

    return SplitPage(
      minSize: 250,
      child1: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: const CameraView(),
      ),
      child2: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: Text(
                "Your OpenAI Api Key",
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Text(
              "Whats your open api key?",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: InputTextField(
                onChanged: (value) {
                  setState(() {
                    inputString = value;
                  });
                },
              ),
            ),
            Text(
              "Your API key is stored & encrypted on-device.",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: const Color.fromRGBO(255, 255, 255, 0.2),
                  fontSize: 14),
            ),
            const Spacer(),
            DecoratedButton(
              text: isReady
                  ? "Let's Start Saving Money!"
                  : "Insert API Key to continue",
              suggestedAction: isReady,
              onPressed: !isReady
                  ? null
                  : () {
                      Provider.of<StorageProvider>(context, listen: false)
                          .storage
                          .write(key: "apiKey", value: inputString)
                          .then(
                        (value) {
                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const CameraPage(),
                              ),
                            );
                          }
                        },
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class InputTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const InputTextField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: const Color(0xff272727),
                hintText: "Insert your api key",
                hintStyle: Theme.of(context).textTheme.displayMedium),
            onChanged: onChanged,
          ),
          const ButtonInnerShadows()
        ],
      ),
    );
  }
}
