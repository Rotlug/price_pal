import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:price_pal/components/button.dart';
import 'package:price_pal/components/camera_view.dart';
import 'package:price_pal/components/container.dart';
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
  late String inputString;

  @override
  Widget build(BuildContext context) {
    return SplitPage(
      child1: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: const CameraView(),
      ),
      child2: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            InputTextField(
              onChanged: (value) {
                setState(() {
                  inputString = value;
                });
              },
            ),
            const Spacer(),
            DecoratedButton(
              text: "Get Started",
              suggestedAction: true,
              onPressed: () {
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
    return DecoratedContainer(
      radius: 8,
      child: Container(
        color: const Color(0xff272727),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Insert your api key",
              ),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
