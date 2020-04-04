import 'package:flutter/material.dart';
import 'package:cvr/constants.dart';
import 'circle_widget_button.dart';
import 'icon_and_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWidget extends StatelessWidget {
  final String surname;
  final String firstname;

  ContactWidget({
    this.surname,
    this.firstname,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '$surname, $firstname',
                style: kHeaderStyle,
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 28,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContactWidgetExtended extends StatelessWidget {
  final String surname;
  final String firstname;
  final String building;
  final String room;
  final String email;
  final String telephone;

  ContactWidgetExtended({
    this.surname,
    this.firstname,
    this.building,
    this.room,
    this.email,
    this.telephone,
  });

  void callContact() async {
    String singleTelephoneNumber = telephone;
    if (telephone.contains('/')) {
      singleTelephoneNumber = singleTelephoneNumber.substring(0, 4);
    }

    String telUrl = 'tel:0141330$singleTelephoneNumber';
    if (await canLaunch(telUrl)) {
      await launch(telUrl);
    } else {
      throw 'Could not launch $telUrl';
    }
  }

  void emailContact() async {
    String emailUrl = 'mailto:$email';
    if (await canLaunch(emailUrl)) {
      await launch(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '$surname, $firstname',
                    style: kHeaderStyle,
                  ),
                  Icon(
                    Icons.arrow_drop_up,
                    size: 28,
                  )
                ],
              ),
              SizedBox(height: 10),
              IconAndText(Icons.location_city, building),
              SizedBox(height: 10),
              IconAndText(Icons.room, room),
              SizedBox(height: 10),
              IconAndText(Icons.email, email),
              SizedBox(height: 10),
              IconAndText(Icons.phone, telephone),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CircleWidgetButton(
                    icon: Icons.email,
                    onPressed: () {
                      emailContact();
                    },
                  ),
                  CircleWidgetButton(
                    icon: Icons.phone,
                    onPressed: () {
                      callContact();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
