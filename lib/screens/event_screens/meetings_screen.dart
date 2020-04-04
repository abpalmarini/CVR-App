import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvr/widgets/event_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import 'package:cvr/constants.dart';
import 'package:cvr/widgets/search_bar.dart';

class MeetingsScreen extends StatefulWidget {
  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  final _firestore = Firestore.instance;
  String search = '';
  List<int> selectedEvents = [];

  bool containsSearch(var meetings, String search, int index) {
    if (search.isEmpty) {
      return true;
    } else if (meetings[index]
        .data['title']
        .toLowerCase()
        .contains(search.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  Widget getWidget(var meetings, int index) {
    DateTime nowTime = DateTime.now();
    DateTime eventTime = meetings[index].data['time'].toDate();
    Duration difference = eventTime.difference(nowTime);

    if (selectedEvents.contains(index) &&
        difference.inMinutes > 0 &&
        difference.inMinutes <= 15 &&
        containsSearch(meetings, search, index)) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedEvents.contains(index)
                ? selectedEvents.remove(index)
                : selectedEvents.add(index);
          });
        },
        child: LiveEventWidgetExpanded(
          Color(0xFFF7ED6A),
          speaker: meetings[index].data['speaker'] ?? '',
          title: meetings[index].data['title'] ?? '',
          building: meetings[index].data['building'] ?? '',
          room: meetings[index].data['room'] ?? '',
          dateTime: meetings[index].data['time'].toDate() ?? '',
          videoURl: meetings[index].data['url'] ?? '',
        ),
      );
    } else if (selectedEvents.contains(index) &&
        difference.inMinutes > 0 &&
        containsSearch(meetings, search, index)) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedEvents.contains(index)
                ? selectedEvents.remove(index)
                : selectedEvents.add(index);
          });
        },
        child: EventWidgetExpanded(
          speaker: meetings[index].data['speaker'] ?? '',
          title: meetings[index].data['title'] ?? '',
          building: meetings[index].data['building'] ?? '',
          room: meetings[index].data['room'] ?? '',
          dateTime: meetings[index].data['time'].toDate() ?? '',
          videoURl: meetings[index].data['url'] ?? '',
        ),
      );
    } else if (selectedEvents.contains(index) &&
        difference.inMinutes >= -60 &&
        difference.inMinutes <= 0 &&
        containsSearch(meetings, search, index)) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedEvents.contains(index)
                ? selectedEvents.remove(index)
                : selectedEvents.add(index);
          });
        },
        child: LiveEventWidgetExpanded(
          Color(0xFFFF726F),
          speaker: meetings[index].data['speaker'] ?? '',
          title: meetings[index].data['title'] ?? '',
          building: meetings[index].data['building'] ?? '',
          room: meetings[index].data['room'] ?? '',
          dateTime: meetings[index].data['time'].toDate() ?? '',
          videoURl: meetings[index].data['url'] ?? '',
        ),
      );
    } else if (difference.inMinutes > 0 &&
        difference.inMinutes <= 15 &&
        containsSearch(meetings, search, index)) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedEvents.contains(index)
                ? selectedEvents.remove(index)
                : selectedEvents.add(index);
          });
        },
        child: LiveEventWidget(
          Color(0xFFF7ED6A),
          speaker: meetings[index].data['speaker'] ?? '',
          title: meetings[index].data['title'] ?? '',
        ),
      );
    } else if (difference.inMinutes > 0 &&
        containsSearch(meetings, search, index)) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedEvents.contains(index)
                ? selectedEvents.remove(index)
                : selectedEvents.add(index);
          });
        },
        child: EventWidget(
          speaker: meetings[index].data['speaker'] ?? '',
          title: meetings[index].data['title'] ?? '',
        ),
      );
    } else if (difference.inMinutes >= -60 &&
        difference.inMinutes <= 0 &&
        containsSearch(meetings, search, index)) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedEvents.contains(index)
                ? selectedEvents.remove(index)
                : selectedEvents.add(index);
          });
        },
        child: LiveEventWidget(
          Color(0xFFFF726F),
          speaker: meetings[index].data['speaker'] ?? '',
          title: meetings[index].data['title'] ?? '',
        ),
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("meetings").orderBy('time').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final meetings = snapshot.data.documents;

          return Stack(children: <Widget>[
            ListView.builder(
              padding: kListViewBuilderPadding,
              itemCount: meetings.length,
              itemBuilder: (context, index) {
                return getWidget(meetings, index);
              },
            ),
            SearchBar(
              category: 'Meetings',
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ]);
        },
      ),
    );
  }
}
