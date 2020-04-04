import 'package:cvr/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DrawerMainCategory extends StatelessWidget {
  final String title;
  final IconData icon;

  DrawerMainCategory(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kDrawerHeaderPadding,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white60,
            size: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text(title, style: kDrawerHeader),
        ],
      ),
    );
  }
}

class DrawerSubCategory extends StatelessWidget {
  final String title;

  DrawerSubCategory(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kDrawerHeaderPadding,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
          ),
          Expanded(
            child:
                Text(title, overflow: TextOverflow.clip, style: kDrawerHeader),
          ),
        ],
      ),
    );
  }
}

class DrawerMainCategorySelected extends StatelessWidget {
  final String title;
  final IconData icon;

  DrawerMainCategorySelected(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kDrawerHeaderPadding,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text(title, style: kDrawerSelectedHeader),
        ],
      ),
    );
  }
}

class DrawerSubCategorySelected extends StatelessWidget {
  final String title;

  DrawerSubCategorySelected(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kDrawerHeaderPadding,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
          ),
          Expanded(
            child: Text(title,
                overflow: TextOverflow.clip, style: kDrawerSelectedHeader),
          ),
        ],
      ),
    );
  }
}
