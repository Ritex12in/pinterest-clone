import 'package:flutter/material.dart';

class PinDetailPage extends StatelessWidget {
  final String pinId;

  const PinDetailPage({super.key, required this.pinId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pin $pinId")),
      body: const Center(child: Text("Pin Detail")),
    );
  }
}
