import 'package:flutter/material.dart';

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('values'),
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
