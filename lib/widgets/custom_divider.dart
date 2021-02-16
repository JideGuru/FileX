import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 1,
            color: Theme.of(context).dividerColor,
            width: size.width - 70,
          ),
        ),
      ],
    );
  }
}