import 'package:flutter/material.dart';

class CircleWidgetButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  CircleWidgetButton({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: BoxConstraints.tightFor(
        width: 40,
        height: 40,
      ),
      elevation: 6,
      shape: CircleBorder(),
      fillColor: Theme.of(context).primaryColor,
      child: Icon(
        icon,
        color: Theme.of(context).accentColor,
      ),
      onPressed: onPressed,
    );
  }
}
