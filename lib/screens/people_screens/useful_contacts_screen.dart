import 'package:cvr/constants.dart';
import 'package:cvr/widgets/group_tag.dart';
import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import 'package:cvr/screens/home_screen.dart';
import 'package:cvr/widgets/contact_widgets.dart';
import 'package:cvr/widgets/search_bar.dart';
import 'package:flutter/rendering.dart';
import 'dart:collection';

class UsefulContactsScreen extends StatefulWidget {
  @override
  _UsefulContactsScreenState createState() => _UsefulContactsScreenState();
}

class _UsefulContactsScreenState extends State<UsefulContactsScreen> {
  var keyContacts;
  var people;
  List<String> roles = [];
  List<int> indexOfNewRole = [];
  int selectedIndex;
  int selectedGroupIndex;
  String activeRole;
  String search = '';

  void getRoles() {
    for (int i = 0; i < keyContacts.length; i++) {
      if (!roles.contains(keyContacts[i]['role'])) {
        roles.add(keyContacts[i]['role']);
        indexOfNewRole.add(i);
      }
    }
  }

//When you tap a group then the selected group index becomes that index and the
//and the active role is set to that role. That way the function returns a
//header and contact if its the active index, just a header if its not and just a
//contact if its the active contact but not the first of a new role!
  Widget getWidget(int index) {
    if (indexOfNewRole.contains(index) &&
        selectedGroupIndex == index &&
        containsSearch(search, index)) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                if (selectedGroupIndex == index) {
                  selectedGroupIndex = null;
                  activeRole = null;
                } else {
                  selectedGroupIndex = index;
                  activeRole = keyContacts[index]['role'];
                }
              });
            },
            child: GroupTagExpanded(
              keyContacts[index]['role'],
            ),
          ),
          getPeopleWidget(keyContacts[index]['name'], index),
        ],
      );
    } else if (indexOfNewRole.contains(index) &&
        selectedGroupIndex != index &&
        containsSearch(search, index)) {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (selectedGroupIndex == index) {
              selectedGroupIndex = null;
              activeRole = null;
            } else {
              selectedGroupIndex = index;
              activeRole = keyContacts[index]['role'];
            }
          });
        },
        child: GroupTag(
          keyContacts[index]['role'].toUpperCase(),
        ),
      );
    } else if (keyContacts[index]['role'] == activeRole &&
        containsSearch(search, index)) {
      return getPeopleWidget(keyContacts[index]['name'], index);
    }
    return SizedBox();
  }

  Widget getPeopleWidget(String name, int index) {
    name = name.toLowerCase();
    for (int i = 0; i < people.length; i++) {
      String firstname = people[i]['firstname'].toLowerCase();
      String surname = people[i]['surname'].toLowerCase();
      if (name.contains(firstname) &&
          name.contains(surname) &&
          selectedIndex == index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedIndex == index) {
                selectedIndex = null;
              } else {
                selectedIndex = index;
              }
            });
          },
          child: ContactWidgetExtended(
            surname: people[i]['surname'] ?? '',
            firstname: people[i]['firstname'] ?? '',
            building: people[i]['building'] ?? '',
            room: people[i]['room'] ?? '',
            email: people[i]['email'] ?? '',
            telephone: people[i]['telephone'] ?? '',
          ),
        );
      } else if (name.contains(firstname) && name.contains(surname)) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (selectedIndex == index) {
                selectedIndex = null;
              } else {
                selectedIndex = index;
              }
            });
          },
          child: ContactWidget(
            firstname: people[i]['firstname'],
            surname: people[i]['surname'],
          ),
        );
      }
    }
    return SizedBox();
  }

  bool containsSearch(String search, int index) {
    if (search == '') {
      return true;
    } else if (keyContacts[index]['role']
        .toLowerCase()
        .contains(search.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  int cast<int>(x) => x is int ? x : null;

  void getAlphabeticalOrder() {
    keyContacts.sort((a, b) => cast<int>(a['role'].compareTo(b['role'])));
  }

  @override
  void initState() {
    super.initState();
    keyContacts = categories.documents[kDocumentIndex['contacts']].data['Key'];
    people = categories.documents[kDocumentIndex['contacts']].data['People'];
    getAlphabeticalOrder();
    getRoles();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: Stack(
      children: <Widget>[
        ListView.builder(
            padding: kListViewBuilderPadding,
            itemCount: keyContacts.length,
            itemBuilder: (context, index) {
              return getWidget(index);
            }),
        SearchBar(
          category: 'Role',
          onChanged: (value) {
            setState(() {
              search = value;
            });
          },
        ),
      ],
    ));
  }
}
