import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cvr/widgets/event_widgets.dart';
import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import 'package:cvr/constants.dart';
import 'package:cvr/widgets/search_bar.dart';

class SeminarScreen extends StatefulWidget {
  @override
  _SeminarScreenState createState() => _SeminarScreenState();
}

class _SeminarScreenState extends State<SeminarScreen> {
  final _firestore = Firestore.instance;
  String search = '';
  List<int> selectedEvents = [];

  bool containsSearch(var seminars, String search, int index) {
    if (search.isEmpty) {
      return true;
    } else if (seminars[index]
        .data['speaker']
        .toLowerCase()
        .contains(search.toLowerCase())) {
      return true;
    } else if (seminars[index]
        .data['title']
        .toLowerCase()
        .contains(search.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  Widget getWidget(var seminars, int index) {
    DateTime nowTime = DateTime.now();
    DateTime eventTime = seminars[index].data['time'].toDate();
    Duration difference = eventTime.difference(nowTime);

    if (selectedEvents.contains(index) &&
        difference.inMinutes > 0 &&
        difference.inMinutes <= 15 &&
        containsSearch(seminars, search, index)) {
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
          speaker: seminars[index].data['speaker'] ?? '',
          title: seminars[index].data['title'] ?? '',
          building: seminars[index].data['building'] ?? '',
          room: seminars[index].data['room'] ?? '',
          dateTime: seminars[index].data['time'].toDate() ?? '',
          videoURl: seminars[index].data['url'] ?? '',
        ),
      );
    } else if (selectedEvents.contains(index) &&
        difference.inMinutes > 0 &&
        containsSearch(seminars, search, index)) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedEvents.contains(index)
                ? selectedEvents.remove(index)
                : selectedEvents.add(index);
          });
        },
        child: EventWidgetExpanded(
          speaker: seminars[index].data['speaker'] ?? '',
          title: seminars[index].data['title'] ?? '',
          building: seminars[index].data['building'] ?? '',
          room: seminars[index].data['room'] ?? '',
          dateTime: seminars[index].data['time'].toDate() ?? '',
          videoURl: seminars[index].data['url'] ?? '',
        ),
      );
    } else if (selectedEvents.contains(index) &&
        difference.inMinutes >= -60 &&
        difference.inMinutes <= 0 &&
        containsSearch(seminars, search, index)) {
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
          speaker: seminars[index].data['speaker'] ?? '',
          title: seminars[index].data['title'] ?? '',
          building: seminars[index].data['building'] ?? '',
          room: seminars[index].data['room'] ?? '',
          dateTime: seminars[index].data['time'].toDate() ?? '',
          videoURl: seminars[index].data['url'] ?? '',
        ),
      );
    } else if (difference.inMinutes > 0 &&
        difference.inMinutes <= 15 &&
        containsSearch(seminars, search, index)) {
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
          speaker: seminars[index].data['speaker'] ?? '',
          title: seminars[index].data['title'] ?? '',
        ),
      );
    } else if (difference.inMinutes > 0 &&
        containsSearch(seminars, search, index)) {
      return GestureDetector(
        onTap: () {
          setState(() {
            selectedEvents.contains(index)
                ? selectedEvents.remove(index)
                : selectedEvents.add(index);
          });
        },
        child: EventWidget(
          speaker: seminars[index].data['speaker'] ?? '',
          title: seminars[index].data['title'] ?? '',
        ),
      );
    } else if (difference.inMinutes >= -60 &&
        difference.inMinutes <= 0 &&
        containsSearch(seminars, search, index)) {
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
          speaker: seminars[index].data['speaker'] ?? '',
          title: seminars[index].data['title'] ?? '',
        ),
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("seminars").orderBy('time').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final seminars = snapshot.data.documents;

          return Stack(children: <Widget>[
            ListView.builder(
              padding: kListViewBuilderPadding,
              itemCount: seminars.length,
              itemBuilder: (context, index) {
                return getWidget(seminars, index);
              },
            ),
            SearchBar(
              category: 'Seminars',
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
