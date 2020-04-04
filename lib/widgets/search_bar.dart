import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String category;
  final Function onChanged;
  SearchBar({this.category, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20, right: 10),
            child: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).primaryColor,
          hintText: 'Search $category...',
          hintStyle: TextStyle(
            color: Colors.white60,
            fontFamily: 'IBMsemibold',
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(200),
            ),
            borderSide: BorderSide.none,
          ),
        ),
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontFamily: 'IBMsemibold'),
        onChanged: onChanged,
      ),
    );
  }
}
