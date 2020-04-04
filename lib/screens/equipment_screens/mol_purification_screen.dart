import 'package:cvr/widgets/equipment_widget.dart';
import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import 'package:cvr/screens/home_screen.dart';
import 'package:cvr/constants.dart';
import 'package:cvr/widgets/search_bar.dart';

class PurificationScreen extends StatefulWidget {
  @override
  _PurificationScreenState createState() => _PurificationScreenState();
}

class _PurificationScreenState extends State<PurificationScreen> {
  var purifiers;

  List<String> purifierNames = [];
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
    for (int i = 0; i < purifiers.length; i++) {
      purifierNames.add(purifiers[i]['name'].trim());
      sortedNames.add(purifiers[i]['name'].trim());
    }
    sortedNames.sort();
    for (int i = 0; i < sortedNames.length; i++) {
      for (int j = 0; j < purifierNames.length; j++) {
        if (sortedNames[i] == purifierNames[j] && notUsed(j)) {
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
    purifiers = categories.documents[kDocumentIndex['equipment']]
        .data['Molecular Purification & Quantitation'];
    getAlphabeticalOrder();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            padding: kListViewBuilderPadding,
            itemCount: purifiers.length,
            itemBuilder: (context, index) {
              return containsSearch(search, index)
                  ? EquipmentWidget(
                      nameOfEquipment:
                          purifiers[indexOrder[index]]['name'] ?? '',
                      building: purifiers[indexOrder[index]]['building'] ?? '',
                      room: purifiers[indexOrder[index]]['room'] ?? '',
                      application:
                          purifiers[indexOrder[index]]['application'] ?? '',
                      curator: purifiers[indexOrder[index]]['curator'] ?? '',
                      extensionNumber:
                          purifiers[indexOrder[index]]['extension'] ?? '',
                      curator2: purifiers[indexOrder[index]]['curator2'] ?? '',
                      extensionNumber2:
                          purifiers[indexOrder[index]]['extension2'] ?? '',
                      booking: purifiers[indexOrder[index]]['booking'] ?? '',
                      charges: purifiers[indexOrder[index]]['charges'] ?? '',
                    )
                  : SizedBox();
            },
          ),
          SearchBar(
            category: 'Molecular Purification & Quantitation',
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
