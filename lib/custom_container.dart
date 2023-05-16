import 'package:flutter/material.dart';

import 'constant.dart';

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
