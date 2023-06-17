import 'package:FISHBOT/constant.dart';
import 'package:flutter/material.dart';

class Turbpage extends StatelessWidget {
  const Turbpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Turbidity value'),
      ),
      body: const Center(
        child: Text(
          'The data will be shown here',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
