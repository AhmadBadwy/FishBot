import 'package:FISHBOT/constant.dart';
import 'package:flutter/material.dart';

class Waterlevelpage extends StatelessWidget {
  const Waterlevelpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Waterlevel value'),
      ),
      body: const Center(
        child: Text(
          'The data will be shown here xD',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}
