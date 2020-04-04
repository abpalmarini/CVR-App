import 'package:cvr/constants.dart';
import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import 'package:cvr/screens/home_screen.dart';
import 'package:cvr/widgets/contact_widgets.dart';
import 'package:cvr/widgets/search_bar.dart';

class PeopleDirectoryScreen extends StatefulWidget {
  @override
  _PeopleDirectoryScreenState createState() => _PeopleDirectoryScreenState();
}

class _PeopleDirectoryScreenState extends State<PeopleDirectoryScreen> {
  var people;

  List<String> fullNames = [];
  List<String> sortedFullNames = [];
  List<int> indexOrder = [];
  String search = '';
  List<int> usedNumbers = [];
  List<int> alphabetLetterPositions = [];
  int selectedIndex;

  bool notUsed(int number) {
    for (int i = 0; i < usedNumbers.length; i++) {
      if (number == usedNumbers[i]) {
        return false;
      }
    }
    return true;
  }

  void getAlphabeticalOrder() {
    for (int i = 0; i < people.length; i++) {
      fullNames.add(
          '${people[i]['surname'].trim()} ${people[i]['firstname'].trim()}');
      sortedFullNames.add(
          '${people[i]['surname'].trim()} ${people[i]['firstname'].trim()}');
    }
    sortedFullNames.sort();
    for (int i = 0; i < sortedFullNames.length; i++) {
      for (int j = 0; j < fullNames.length; j++) {
        if (sortedFullNames[i] == fullNames[j] && notUsed(j)) {
          usedNumbers.add(j);
          indexOrder.add(j);
        }
      }
    }
  }

  bool containsSearch(String search, int index) {
    if (search == '') {
      return true;
    } else if (sortedFullNames[index]
        .toLowerCase()
        .contains(search.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  Widget getWidget(String search, int index) {
    if (containsSearch(search, index) && selectedIndex == index) {
      return ContactWidgetExtended(
        surname: people[indexOrder[index]]['surname'] ?? '',
        firstname: people[indexOrder[index]]['firstname'] ?? '',
        building: people[indexOrder[index]]['building'] ?? '',
        room: people[indexOrder[index]]['room'] ?? '',
        email: people[indexOrder[index]]['email'] ?? '',
        telephone: people[indexOrder[index]]['telephone'] ?? '',
      );
    } else if (containsSearch(search, index)) {
      return ContactWidget(
        surname: people[indexOrder[index]]['surname'] ?? '',
        firstname: people[indexOrder[index]]['firstname'] ?? '',
      );
    } else {
      return SizedBox();
    }
  }

  @override
  void initState() {
    super.initState();
    people = categories.documents[kDocumentIndex['contacts']].data['People'];
    getAlphabeticalOrder();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: Stack(
      children: <Widget>[
        ListView.builder(
            padding: kListViewBuilderPadding,
            itemCount: people.length,
            itemBuilder: (context, index) {
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
                child: getWidget(search, index),
              );
            }),
        SearchBar(
          category: 'Directory',
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
