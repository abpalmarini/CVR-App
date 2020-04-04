import 'package:cvr/widgets/equipment_widget.dart';
import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import 'package:cvr/screens/home_screen.dart';
import 'package:cvr/constants.dart';
import 'package:cvr/widgets/search_bar.dart';

class CytometryScreen extends StatefulWidget {
  @override
  _CytometryScreenState createState() => _CytometryScreenState();
}

class _CytometryScreenState extends State<CytometryScreen> {
  var cytometries;

  List<String> cytometryNames = [];
  List<String> sortedNames = [];
  List<int> indexOrder = [];
  String search = '';
  List<int> usedNumbers = [];

  bool notUsed(int number) {
    for (int i = 0; i < usedNumbers.length; i++) {
      if (number == usedNumbers[i]) {
        return false;
      }
    }
    return true;
  }

  void getAlphabeticalOrder() {
    for (int i = 0; i < cytometries.length; i++) {
      cytometryNames.add(cytometries[i]['name'].trim());
      sortedNames.add(cytometries[i]['name'].trim());
    }
    sortedNames.sort();
    for (int i = 0; i < sortedNames.length; i++) {
      for (int j = 0; j < cytometryNames.length; j++) {
        if (sortedNames[i] == cytometryNames[j] && notUsed(j)) {
          usedNumbers.add(j);
          indexOrder.add(j);
        }
      }
    }
  }

  bool containsSearch(String search, int index) {
    if (search == '') {
      return true;
    } else if (sortedNames[index]
        .toLowerCase()
        .contains(search.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    cytometries = categories
        .documents[kDocumentIndex['equipment']].data['Flow Cytometry'];
    getAlphabeticalOrder();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            padding: kListViewBuilderPadding,
            itemCount: cytometries.length,
            itemBuilder: (context, index) {
              return containsSearch(search, index)
                  ? EquipmentWidget(
                      nameOfEquipment:
                          cytometries[indexOrder[index]]['name'] ?? '',
                      building:
                          cytometries[indexOrder[index]]['building'] ?? '',
                      room: cytometries[indexOrder[index]]['room'] ?? '',
                      application:
                          cytometries[indexOrder[index]]['application'] ?? '',
                      curator: cytometries[indexOrder[index]]['curator'] ?? '',
                      extensionNumber:
                          cytometries[indexOrder[index]]['extension'] ?? '',
                      curator2:
                          cytometries[indexOrder[index]]['curator2'] ?? '',
                      extensionNumber2:
                          cytometries[indexOrder[index]]['extension2'] ?? '',
                      booking: cytometries[indexOrder[index]]['booking'] ?? '',
                      charges: cytometries[indexOrder[index]]['charges'] ?? '',
                    )
                  : SizedBox();
            },
          ),
          SearchBar(
            category: 'Flow Cytometry',
            onChanged: (value) {
              search = value;
              setState(() {});
            },
          )
        ],
      ),
    );
  }
}
