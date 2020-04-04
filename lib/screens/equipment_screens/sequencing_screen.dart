import 'package:cvr/widgets/equipment_widget.dart';
import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import 'package:cvr/screens/home_screen.dart';
import 'package:cvr/constants.dart';
import 'package:cvr/widgets/search_bar.dart';

class SequencingScreen extends StatefulWidget {
  @override
  _SequencingScreenState createState() => _SequencingScreenState();
}

class _SequencingScreenState extends State<SequencingScreen> {
  var sequencers;

  List<String> sequencerNames = [];
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
    for (int i = 0; i < sequencers.length; i++) {
      sequencerNames.add(sequencers[i]['name'].trim());
      sortedNames.add(sequencers[i]['name'].trim());
    }
    sortedNames.sort();
    for (int i = 0; i < sortedNames.length; i++) {
      for (int j = 0; j < sequencerNames.length; j++) {
        if (sortedNames[i] == sequencerNames[j] && notUsed(j)) {
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
    sequencers = categories.documents[kDocumentIndex['equipment']]
        .data['Next Generation Sequencing'];
    getAlphabeticalOrder();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            padding: kListViewBuilderPadding,
            itemCount: sequencers.length,
            itemBuilder: (context, index) {
              return containsSearch(search, index)
                  ? EquipmentWidget(
                      nameOfEquipment:
                          sequencers[indexOrder[index]]['name'] ?? '',
                      building: sequencers[indexOrder[index]]['building'] ?? '',
                      room: sequencers[indexOrder[index]]['room'] ?? '',
                      application:
                          sequencers[indexOrder[index]]['application'] ?? '',
                      curator: sequencers[indexOrder[index]]['curator'] ?? '',
                      extensionNumber:
                          sequencers[indexOrder[index]]['extension'] ?? '',
                      curator2: sequencers[indexOrder[index]]['curator2'] ?? '',
                      extensionNumber2:
                          sequencers[indexOrder[index]]['extension2'] ?? '',
                      booking: sequencers[indexOrder[index]]['booking'] ?? '',
                      charges: sequencers[indexOrder[index]]['charges'] ?? '',
                    )
                  : SizedBox();
            },
          ),
          SearchBar(
            category: 'NGS',
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
