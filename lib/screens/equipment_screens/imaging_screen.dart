import 'package:cvr/widgets/equipment_widget.dart';
import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import 'package:cvr/screens/home_screen.dart';
import 'package:cvr/constants.dart';
import 'package:cvr/widgets/search_bar.dart';

class MicroscopeScreen extends StatefulWidget {
  @override
  _MicroscopeScreenState createState() => _MicroscopeScreenState();
}

class _MicroscopeScreenState extends State<MicroscopeScreen> {
  var imaging;

  List<String> imagingNames = [];
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
    for (int i = 0; i < imaging.length; i++) {
      imagingNames.add(imaging[i]['name'].trim());
      sortedNames.add(imaging[i]['name'].trim());
    }
    sortedNames.sort();
    for (int i = 0; i < sortedNames.length; i++) {
      for (int j = 0; j < imagingNames.length; j++) {
        if (sortedNames[i] == imagingNames[j] && notUsed(j)) {
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

    imaging = categories.documents[kDocumentIndex['equipment']].data['Imaging'];
    getAlphabeticalOrder();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            padding: kListViewBuilderPadding,
            itemCount: imaging.length,
            itemBuilder: (context, index) {
              return containsSearch(search, index)
                  ? EquipmentWidget(
                      nameOfEquipment: imaging[indexOrder[index]]['name'] ?? '',
                      building: imaging[indexOrder[index]]['building'] ?? '',
                      room: imaging[indexOrder[index]]['room'] ?? '',
                      application:
                          imaging[indexOrder[index]]['application'] ?? '',
                      curator: imaging[indexOrder[index]]['curator'] ?? '',
                      extensionNumber:
                          imaging[indexOrder[index]]['extension'] ?? '',
                      curator2: imaging[indexOrder[index]]['curator2'] ?? '',
                      extensionNumber2:
                          imaging[indexOrder[index]]['extension2'] ?? '',
                      booking: imaging[indexOrder[index]]['booking'] ?? '',
                      charges: imaging[indexOrder[index]]['charges'] ?? '',
                    )
                  : SizedBox();
            },
          ),
          SearchBar(
            category: 'Imaging',
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
