import 'package:flutter/material.dart';
import 'package:cvr/constants.dart';
import 'header_and_body.dart';
import 'circle_widget_button.dart';
import 'package:url_launcher/url_launcher.dart';

class EquipmentWidget extends StatelessWidget {
  final String nameOfEquipment;
  final String building;
  final String room;
  final String application;
  final String curator;
  final String extensionNumber;
  final String curator2;
  final String extensionNumber2;
  final String booking;
  final String charges;
  EquipmentWidget({
    this.nameOfEquipment,
    this.building,
    this.room,
    this.application,
    this.curator,
    this.extensionNumber,
    this.curator2,
    this.extensionNumber2,
    this.booking,
    this.charges,
  });

  void callCurator() async {
    String telUrl = 'tel:0141330$extensionNumber';
    if (await canLaunch(telUrl)) {
      await launch(telUrl);
    } else {
      throw 'Could not launch $telUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: 2.0, color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                content: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              nameOfEquipment,
                              style: TextStyle(
                                fontFamily: 'IBMbold',
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            HeaderAndBody(
                                'Application', Icons.build, application),
                            SizedBox(height: 20),
                            HeaderAndBody(
                                'Building', Icons.location_city, building),
                            SizedBox(height: 20),
                            HeaderAndBody('Room', Icons.room, room),
                            SizedBox(height: 20),
                            //pan_tool record_voice_over
                            HeaderAndBody('Requires Booking?',
                                Icons.record_voice_over, booking),
                            SizedBox(height: 20),
                            //report_problem
                            HeaderAndBody('Associated Charges?',
                                Icons.report_problem, charges),
                            SizedBox(height: 20),
                            HeaderAndBody('Curator / Extension', Icons.person,
                                '$curator / $extensionNumber'),
                            curator2 == ''
                                ? Text('')
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '$curator2 / $extensionNumber2',
                                          style: kInfoTextStylePop,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleWidgetButton(
                          icon: Icons.phone,
                          onPressed: () {
                            callCurator();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(nameOfEquipment,
                          overflow: TextOverflow.ellipsis, style: kHeaderStyle),
                      Text(
                        '$building ⬩ $room',
                        overflow: TextOverflow.ellipsis,
                        style: kInfoTextStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.more_vert,
                  size: 28,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
