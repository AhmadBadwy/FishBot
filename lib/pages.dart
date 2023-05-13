import 'package:flutter/material.dart';
import 'home_screen.dart';

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('values'),
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
