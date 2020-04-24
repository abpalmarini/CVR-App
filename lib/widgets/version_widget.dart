import 'package:flutter/material.dart';
import 'package:cvr/constants.dart';
import 'package:cvr/screens/home_screen.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';

class VersionWidget extends StatelessWidget {
  DateTime date;

  VersionWidget() {
    List changes =
        categories.documents[kDocumentIndex['version_control']].data['changes'];
    date = changes[changes.length - 1]['date'].toDate();
  }

  String getDate() {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text(
        'Updated - ${getDate()}',
        style: TextStyle(
          color: Colors.white60,
          fontSize: 14,
          fontFamily: 'IBMsemibold',
        ),
      ),
    );
  }
}
