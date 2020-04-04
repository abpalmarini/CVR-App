import 'package:flutter/material.dart';
import 'package:cvr/constants.dart';

class IconAndText extends StatelessWidget {
  final String text;
  final IconData icon;

  IconAndText(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
          size: 25,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            text,
            style: kInfoTextStylePop,
          ),
        ),
      ],
    );
  }
}
