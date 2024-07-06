import 'package:flutter/material.dart';

import '../../../data/model/test.dart';

class TestDetailScreen extends StatefulWidget {
  final Test test;
  const TestDetailScreen({super.key, required this.test});

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
