import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cvr/screens/loading_screen.dart';
import 'screens/verification_screen.dart';
import 'screens/locked_out_screen.dart';
import 'package:cvr/utilities/transfer_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences storage = await SharedPreferences.getInstance();
  runApp(MyApp(storage));
}

class MyApp extends StatelessWidget {
  final SharedPreferences storage;

  MyApp(this.storage);

  Widget getScreen() {
    if ((storage.getBool('verified')) ?? false) {
      return LoadingScreen();
    } else if (storage.getInt('attempts') == null) {
      storage.setInt('attempts', 5);
      return VerificationScreen(storage);
    } else if (storage.getInt('attempts') > 0) {
      return VerificationScreen(storage);
    } else {
      return LockedOutScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CVR',
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
      theme: ThemeData(
        primaryColor: Color(0xFF003865),
        accentColor: Color(0xFF70BBE4),
      ),
      home: getScreen(),
    );
  }
}
