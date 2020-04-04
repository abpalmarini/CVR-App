import 'package:flutter/material.dart';

class GroupTag extends StatelessWidget {
  final String title;

  GroupTag(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Nunito Bold',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                //Icons.expand_more,
                size: 28,
                color: Colors.white60,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GroupTagExpanded extends StatelessWidget {
  final String title;

  GroupTagExpanded(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Nunito Bold',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_drop_up,
                //Icons.expand_less,
                size: 28,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
