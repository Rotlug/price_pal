import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:price_pal/components/button.dart';
import 'package:price_pal/components/container.dart';
import 'package:price_pal/components/screen_base.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      child: MarginContainer(
        child: DecoratedContainer(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: LandingProgressBar(pageController: _pageViewController, numPages: 3,),
            ),
            Expanded(
              child: PageView(
                controller: _pageViewController,
                children: const [
                  ExplanationPage(
                    title: "Scan & Compare",
                    description:
                        "Scan product with your phone to view real-time price comparisons across products.",
                    imageAsset: "assets/images/landing1.png",
                  ),
                  ExplanationPage(
                    title: "Track Savings",
                    description:
                        "Track your savings and ensure you get the best value as you shop.",
                    imageAsset: "assets/images/landing2.png",
                  ),
                  ExplanationPage(
                    title: "Save Big",
                    description:
                        "Select the cheapest options and save on every purchase directly in the app.",
                    imageAsset: "assets/images/landing3.png",
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DecoratedButtonTest(text: "Sign Up", suggestedAction: true, onPressed: () {},),
                  DecoratedButtonTest(text: "Sign In", suggestedAction: false, onPressed: () {},),
                ],
              ),
            ),
            const SizedBox(height: 10,)
          ],
        )),
      ),
    );
  }
}

class ExplanationPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;

  const ExplanationPage(
      {super.key,
      required this.title,
      required this.description,
      required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Opacity(
              opacity: 0.5,
              child: Text(description,
                  style: const TextStyle(fontFamily: "Inter"),
                  textAlign: TextAlign.center)),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.contain,
            ),
          ))
        ],
      ),
    );
  }
}

class LandingProgressBar extends StatefulWidget {
  final PageController pageController;
  final int numPages;
  const LandingProgressBar({super.key, required, required this.pageController, required this.numPages});

  @override
  State<LandingProgressBar> createState() => _LandingProgressBarState();
}

class _LandingProgressBarState extends State<LandingProgressBar> {
  late final int numPages;
  late double pageNum = 1 / numPages;
  late final List<Container> containers;

  @override
  void initState() {
    super.initState();
    numPages = widget.numPages;
    containers = createContainers();
  }

  @override
  Widget build(BuildContext context) {
    widget.pageController.addListener(
      () {
        setState(() {
          pageNum = widget.pageController.page! / numPages + (1 / numPages);
        });
      },
    );

    return Stack(
      children: [
        LinearProgressIndicator(
          borderRadius: BorderRadius.circular(50),
          value: pageNum,
          color: Theme.of(context).colorScheme.primaryContainer,
          backgroundColor: Colors.transparent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: containers,
        )
      ],
    );
  }

  List<Container> createContainers() {
    List<Container> result = [];
    for (int i = 0; i <= numPages; i++) {
      bool isVisible = i != 0 && i != numPages;

      result.add(Container(
        width: 2,
        height: 5,
        color: isVisible ? const Color.fromRGBO(27, 27, 27, 1) : Colors.transparent,
      ));
    }

    log("Created Containers!");
    return result;
  }
}
