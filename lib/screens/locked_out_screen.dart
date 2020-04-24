import 'package:flutter/material.dart';

class LockedOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'No remaining attempts left! Please contact CVR administration to unlock.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'IBMsemibold',
            ),
          ),
        ),
      ),
    );
  }
}
