import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constant.dart';

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

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 30,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(offset: Offset(0, 15), blurRadius: 15, color: kTextColor),
          ],
          color: kBackgroundColor,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: child);
  }
}
