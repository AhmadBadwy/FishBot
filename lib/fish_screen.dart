import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'custom_container.dart';

class FishScreen extends StatelessWidget {
  const FishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomContainer(
          child: ListTile(
            leading: Text('Feed'),
            trailing: Icon(FontAwesomeIcons.fish),
          ),
        ),
        SizedBox(height: 12.0),
        CustomContainer(
          child: ListTile(
            leading: Text('Timer'),
            trailing: Text('00:15'),
          ),
        ),
        SizedBox(height: 12.0),
        CustomContainer(child: ListTile())
      ],
    );
  }
}
