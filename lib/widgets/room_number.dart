import 'package:flutter/material.dart';

class RoomNumber extends StatelessWidget {
  final String roomNumber;

  RoomNumber(this.roomNumber);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          child: Text(
            roomNumber,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }
}
