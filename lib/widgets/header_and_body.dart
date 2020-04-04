import 'package:flutter/material.dart';
import 'package:cvr/constants.dart';

class HeaderAndBody extends StatelessWidget {
  final String header;
  final String body;
  final IconData icon;

  HeaderAndBody(
    this.header,
    this.icon,
    this.body,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          header,
          style: kHeaderStylePop,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                body,
                style: kInfoTextStylePop,
              ),
            ),
          ],
        )
      ],
    );
  }
}
