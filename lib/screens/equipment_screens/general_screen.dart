import 'package:cvr/widgets/equipment_widget.dart';
import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import 'package:cvr/screens/home_screen.dart';
import 'package:cvr/constants.dart';
import 'package:cvr/widgets/search_bar.dart';

class PreparatoryScreen extends StatefulWidget {
  @override
  _PreparatoryScreenState createState() => _PreparatoryScreenState();
}

class _PreparatoryScreenState extends State<PreparatoryScreen> {
  var generalEquipment;

  List<String> generalEquipmentNames = [];
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
    for (int i = 0; i < generalEquipment.length; i++) {
      generalEquipmentNames.add(generalEquipment[i]['name'].trim());
      sortedNames.add(generalEquipment[i]['name'].trim());
    }
    sortedNames.sort();
    for (int i = 0; i < sortedNames.length; i++) {
      for (int j = 0; j < generalEquipmentNames.length; j++) {
        if (sortedNames[i] == generalEquipmentNames[j] && notUsed(j)) {
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
    generalEquipment =
        categories.documents[kDocumentIndex['equipment']].data['General'];
    getAlphabeticalOrder();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            padding: kListViewBuilderPadding,
            itemCount: generalEquipment.length,
            itemBuilder: (context, index) {
              return containsSearch(search, index)
                  ? EquipmentWidget(
                      nameOfEquipment:
                          generalEquipment[indexOrder[index]]['name'] ?? '',
                      building:
                          generalEquipment[indexOrder[index]]['building'] ?? '',
                      room: generalEquipment[indexOrder[index]]['room'] ?? '',
                      application: generalEquipment[indexOrder[index]]
                              ['application'] ??
                          '',
                      curator:
                          generalEquipment[indexOrder[index]]['curator'] ?? '',
                      extensionNumber: generalEquipment[indexOrder[index]]
                              ['extension'] ??
                          '',
                      curator2:
                          generalEquipment[indexOrder[index]]['curator2'] ?? '',
                      extensionNumber2: generalEquipment[indexOrder[index]]
                              ['extension2'] ??
                          '',
                      booking:
                          generalEquipment[indexOrder[index]]['booking'] ?? '',
                      charges:
                          generalEquipment[indexOrder[index]]['charges'] ?? '',
                    )
                  : SizedBox();
            },
          ),
          SearchBar(
            category: 'General',
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
