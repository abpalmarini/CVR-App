import 'package:cvr/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Firestore _firestore = Firestore.instance;

  void getMyDocuments() async {
    var categories = await _firestore.collection('categories').getDocuments();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          categoriesTemp: categories,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getMyDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SpinKitWave(
          size: 100,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
