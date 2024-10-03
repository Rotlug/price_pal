// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:price_pal/components/camera_view.dart';
import 'package:price_pal/components/split_page.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return const SplitPage(
      child1: Center(child: Text("data"),),
    );
  }
}
