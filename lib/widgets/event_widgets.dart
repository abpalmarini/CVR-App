import 'package:flutter/material.dart';
import 'package:cvr/constants.dart';
import 'icon_and_text.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class EventWidgetExpanded extends StatelessWidget {
  final String speaker;
  final String title;
  final String room;
  final String building;
  final DateTime dateTime;
  final String videoURl;

  EventWidgetExpanded(
      {this.speaker,
      this.title,
      this.room,
      this.building,
      this.dateTime,
      this.videoURl});

  String getDate() {
    DateFormat dateFormat = DateFormat.MMMMEEEEd();
    return dateFormat.format(dateTime);
  }

  String getTime() {
    DateFormat dateFormat = DateFormat.jm();
    return dateFormat.format(dateTime);
  }

  Widget checkForSpeaker() {
    if (speaker == '') {
      return SizedBox();
    } else {
      return Column(
        children: <Widget>[
          SizedBox(height: 10),
          IconAndText(Icons.person, speaker),
        ],
      );
    }
  }

  Widget checkForVideoChat() {
    if (videoURl == '') {
      return Column(
        children: <Widget>[
          SizedBox(height: 10),
          IconAndText(Icons.location_city, building),
          SizedBox(height: 10),
          IconAndText(Icons.room, room),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              _launchInBrowser(videoURl);
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.video_call,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    videoURl,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'IBMsemibold',
                      fontSize: 17,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  Future<void> _launchInBrowser(String url) async {
    url = url.trim();
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title == '' ? speaker : title,
                      style: kHeaderStyle,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_up,
                    size: 28,
                  )
                ],
              ),
              checkForSpeaker(),
              checkForVideoChat(),
              SizedBox(height: 10),
              IconAndText(Icons.calendar_today, getDate()),
              SizedBox(height: 10),
              IconAndText(Icons.access_time, getTime()),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class EventWidget extends StatelessWidget {
  final String title;
  final String speaker;

  EventWidget({this.title, this.speaker});

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
              Expanded(
                child: Text(
                  title == '' ? speaker : title,
                  overflow: TextOverflow.ellipsis,
                  style: kHeaderStyle,
                ),
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

class LiveEventWidgetExpanded extends StatefulWidget {
  final String speaker;
  final String title;
  final String room;
  final String building;
  final DateTime dateTime;
  final String videoURl;
  final Color color;

  LiveEventWidgetExpanded(this.color,
      {this.speaker,
      this.title,
      this.room,
      this.building,
      this.dateTime,
      this.videoURl});

  @override
  _LiveEventWidgetExpandedState createState() =>
      _LiveEventWidgetExpandedState();
}

class _LiveEventWidgetExpandedState extends State<LiveEventWidgetExpanded>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
      lowerBound: 0.3,
      upperBound: 0.9,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.forward();

    controller.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String getDate() {
    DateFormat dateFormat = DateFormat.MMMMEEEEd();
    return dateFormat.format(widget.dateTime);
  }

  String getTime() {
    DateFormat dateFormat = DateFormat.jm();
    return dateFormat.format(widget.dateTime);
  }

  Widget checkForSpeaker() {
    if (widget.speaker == '') {
      return SizedBox();
    } else {
      return Column(
        children: <Widget>[
          SizedBox(height: 10),
          IconAndText(Icons.person, widget.speaker),
        ],
      );
    }
  }

  Widget checkForVideoChat() {
    if (widget.videoURl == '') {
      return Column(
        children: <Widget>[
          SizedBox(height: 10),
          IconAndText(Icons.location_city, widget.building),
          SizedBox(height: 10),
          IconAndText(Icons.room, widget.room),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              _launchInBrowser(widget.videoURl);
            },
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.video_call,
                  color: Colors.white,
                  size: 25,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.videoURl,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'IBMsemibold',
                      fontSize: 17,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  Future<void> _launchInBrowser(String url) async {
    url = url.trim();
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          border: Border.all(
              color: widget.color.withOpacity(animation.value), width: 2.0),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.title == '' ? widget.speaker : widget.title,
                      style: kHeaderStyle,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_up,
                    size: 28,
                  )
                ],
              ),
              checkForSpeaker(),
              checkForVideoChat(),
              SizedBox(height: 10),
              IconAndText(Icons.calendar_today, getDate()),
              SizedBox(height: 10),
              IconAndText(Icons.access_time, getTime()),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class LiveEventWidget extends StatefulWidget {
  final String title;
  final String speaker;
  final Color color;

  LiveEventWidget(this.color, {this.title, this.speaker});

  @override
  _LiveEventWidgetState createState() => _LiveEventWidgetState();
}

class _LiveEventWidgetState extends State<LiveEventWidget>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
      lowerBound: 0.3,
      upperBound: 0.9,
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.forward();

    controller.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    });

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.5),
      child: Container(
        decoration: BoxDecoration(
          color: widget.color.withOpacity(animation.value),
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.title == '' ? widget.speaker : widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: kHeaderStyle,
                ),
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
