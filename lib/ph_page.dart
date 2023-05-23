import 'package:FISHBOT/constant.dart';
import 'package:flutter/material.dart';

class Phpage extends StatelessWidget {
  const Phpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('PH value'),
      ),
      body: Center(
        child: Text(
          'The data will be shown here',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
