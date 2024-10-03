import 'package:flutter/material.dart';
import 'package:price_pal/components/screen_base.dart';

class NoPermissionsPage extends StatelessWidget {
  const NoPermissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerPage(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "i will be under your bed",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 10,),
              Text(
                "enable the camera",
                style: Theme.of(context).textTheme.displayMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}
