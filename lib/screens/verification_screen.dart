import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'loading_screen.dart';
import 'locked_out_screen.dart';

class VerificationScreen extends StatefulWidget {
  final SharedPreferences storage;

  VerificationScreen(this.storage);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final Firestore _firestore = Firestore.instance;
  String input;
  String code;
  bool error = false;

  void getCode() async {
    var doc = await _firestore.collection('verification').getDocuments();
    code = doc.documents[0].data['code'];
  }

  void verify() {
    if (input == code) {
      widget.storage.setBool('verified', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()),
      );
    } else {
      setState(() {
        error = true;
        int attempts = widget.storage.getInt('attempts');
        attempts--;
        widget.storage.setInt('attempts', attempts);
        if (attempts == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LockedOutScreen()),
          );
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'For security reasons, please enter the alphanumeric verification code provided to all staff & students of the CVR.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'IBMsemibold',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                textAlign: TextAlign.center,
                //keyboardType: TextInputType.numberWithOptions(),
                cursorColor: Colors.white,
                style: TextStyle(
                  fontFamily: 'IBMsemibold',
                  fontSize: 22,
                ),
                onChanged: (value) {
                  input = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(color: Colors.black, width: 3),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  errorText: error
                      ? 'Incorrect code. ${widget.storage.getInt('attempts')} attempts remaining.'
                      : null,
                  errorStyle: TextStyle(fontSize: 17),
                  filled: true,
                  fillColor: Theme.of(context).accentColor,
                  hintText: 'Enter verification code...',
                  hintStyle: TextStyle(
                    fontFamily: 'IBMsemibold',
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            MaterialButton(
              child: Text(
                'VERIFY',
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'IBMsemibold',
                  fontSize: 17,
                ),
              ),
              elevation: 13,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: StadiumBorder(),
              color: Colors.white,
              onPressed: verify,
            ),
          ],
        ),
      ),
    );
  }
}
