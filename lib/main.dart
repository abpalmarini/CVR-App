import 'package:cvr/screens/loading_screen.dart';
import 'package:cvr/utilities/transfer_data.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CVR',
      theme: ThemeData(
        primaryColor: Color(0xFF003865),
        accentColor: Color(0xFF70BBE4),
      ),
      home: LoadingScreen(),
    );
  }
}

//TODO get notifications to go off 15 mins before event (https://pub.dev/packages/flutter_local_notifications#-readme-tab-)

//TODO figure out how to add an excel sheet that is well formatted easily to the firebase and document how to do it
//TODO look to upload to app store, after getting accepted by play store create internal sharking link

//TODO update security rules and then upload to github
