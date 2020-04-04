import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 80, right: 80),
          child: Image.asset('images/cvr_logo_virus.png'),
        ),
      ),
    );
  }
}
