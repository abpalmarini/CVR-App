import 'package:flutter/material.dart';
import 'package:cvr/constants.dart';
import 'package:cvr/screens/equipment_screens/imaging_screen.dart';
import 'package:flutter/services.dart';
import 'equipment_screens/sequencing_screen.dart';
import 'equipment_screens/cytometry_screen.dart';
import 'equipment_screens/mol_purification_screen.dart';
import 'equipment_screens/general_screen.dart';
import 'package:cvr/screens/forms_screens/useful_forms_screen.dart';
import 'package:cvr/screens/people_screens/directory_screen.dart';
import 'package:cvr/screens/people_screens/useful_contacts_screen.dart';
import 'package:cvr/widgets/drawer_category_widgets.dart';
import 'event_screens/seminars_screen.dart';
import 'event_screens/meetings_screen.dart';

var categories;

class HomeScreen extends StatefulWidget {
  final categoriesTemp;
  HomeScreen({this.categoriesTemp});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  bool equipmentSubSelector = false;
  int equipmentSubSelectedIndex = 0;
  bool peopleSubSelector = true;
  int peopleSubSelectedIndex = 0;
  bool eventSubSelector = false;
  int eventSubSelectedIndex = 0;
  bool formSubSelector = false;
  int formSubSelectedIndex = 0;

  Widget getScreen() {
    if (selectedIndex == 0 && peopleSubSelectedIndex == 0) {
      return PeopleDirectoryScreen();
    } else if (selectedIndex == 0 && peopleSubSelectedIndex == 1) {
      return UsefulContactsScreen();
    } else if (selectedIndex == 1 && eventSubSelectedIndex == 0) {
      return SeminarScreen();
    } else if (selectedIndex == 1 && eventSubSelectedIndex == 1) {
      return MeetingsScreen();
    } else if (selectedIndex == 2 && equipmentSubSelectedIndex == 0) {
      return MicroscopeScreen();
    } else if (selectedIndex == 2 && equipmentSubSelectedIndex == 1) {
      return SequencingScreen();
    } else if (selectedIndex == 2 && equipmentSubSelectedIndex == 2) {
      return CytometryScreen();
    } else if (selectedIndex == 2 && equipmentSubSelectedIndex == 3) {
      return PurificationScreen();
    } else if (selectedIndex == 2 && equipmentSubSelectedIndex == 4) {
      return PreparatoryScreen();
    } else if (selectedIndex == 3 && formSubSelectedIndex == 0) {
      return UsefulFormsScreen();
    }
  }

  void showSubSelector(int index) {
    if (index == 0) {
      equipmentSubSelector = false;
      eventSubSelector = false;
      formSubSelector = false;
      peopleSubSelector = true;
    } else if (index == 1) {
      equipmentSubSelector = false;
      peopleSubSelector = false;
      formSubSelector = false;
      eventSubSelector = true;
    } else if (index == 2) {
      peopleSubSelector = false;
      eventSubSelector = false;
      formSubSelector = false;
      equipmentSubSelector = true;
    } else if (index == 3) {
      equipmentSubSelector = false;
      peopleSubSelector = false;
      eventSubSelector = false;
      formSubSelector = true;
    }
  }

  Widget getMainCategory(int index, String title, IconData icon) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        onTap: () {
          setState(() {
            selectedIndex = index;
            showSubSelector(index);
            Navigator.pop(context);
          });
        },
        child: selectedIndex == index
            ? DrawerMainCategorySelected(title, icon)
            : DrawerMainCategory(title, icon),
      ),
    );
  }

  Widget getSubCategory(int index, String category, String title) {
    if (category == kCategories[2]) {
      return Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          splashColor: Theme.of(context).accentColor,
          onTap: () {
            setState(() {
              selectedIndex = 2; // the position of Equipment in headers
              showSubSelector(2);
              equipmentSubSelectedIndex = index;
              Navigator.pop(context);
            });
          },
          child: equipmentSubSelectedIndex == index && selectedIndex == 2
              ? DrawerSubCategorySelected(title)
              : DrawerSubCategory(title),
        ),
      );
    } else if (category == kCategories[0]) {
      return Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          splashColor: Theme.of(context).accentColor,
          onTap: () {
            setState(() {
              selectedIndex = 0; // the position of People in headers
              showSubSelector(0);
              peopleSubSelectedIndex = index;
              Navigator.pop(context);
            });
          },
          child: peopleSubSelectedIndex == index && selectedIndex == 0
              ? DrawerSubCategorySelected(title)
              : DrawerSubCategory(title),
        ),
      );
    } else if (category == kCategories[1]) {
      return Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          splashColor: Theme.of(context).accentColor,
          onTap: () {
            setState(() {
              selectedIndex = 1; // the position of Events in headers
              showSubSelector(1);
              eventSubSelectedIndex = index;
              Navigator.pop(context);
            });
          },
          child: eventSubSelectedIndex == index && selectedIndex == 1
              ? DrawerSubCategorySelected(title)
              : DrawerSubCategory(title),
        ),
      );
    } else if (category == kCategories[3]) {
      return Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          splashColor: Theme.of(context).accentColor,
          onTap: () {
            setState(() {
              selectedIndex = 3; // the position of Forms in headers
              showSubSelector(3);
              formSubSelectedIndex = index;
              Navigator.pop(context);
            });
          },
          child: eventSubSelectedIndex == index && selectedIndex == 3
              ? DrawerSubCategorySelected(title)
              : DrawerSubCategory(title),
        ),
      );
    }
  }

  void bottomItemOnTap(int index) {
    setState(() {
      selectedIndex = index;
      showSubSelector(index);
    });
  }

  @override
  void initState() {
    super.initState();
    categories = widget.categoriesTemp;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text("PEOPLE"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text("EVENTS"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            title: Text("EQUIPMENT"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste),
            title: Text("FORMS"),
          ),
        ],
        //LOGIC
        currentIndex: selectedIndex,
        onTap: bottomItemOnTap,
        //COLORS
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Color(0xFF737373),
        //STYLE
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontFamily: 'Nunito Bold'),
        unselectedLabelStyle: TextStyle(fontFamily: 'Nunito Bold'),
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(child: Image.asset('images/CVR_logo.png')),
              ),
              getMainCategory(0, "PEOPLE", Icons.people),
              getSubCategory(0, "PEOPLE", kPeopleSubCategories[0]),
              getSubCategory(1, "PEOPLE", kPeopleSubCategories[1]),
              Divider(color: Colors.white),
              getMainCategory(1, "EVENTS", Icons.access_time),
              getSubCategory(0, "EVENTS", kEventSubCategories[0]),
              getSubCategory(1, "EVENTS", kEventSubCategories[1]),
              Divider(color: Colors.white),
              getMainCategory(2, "EQUIPMENT", Icons.build),
              getSubCategory(0, "EQUIPMENT", kEquipments[0]),
              getSubCategory(1, "EQUIPMENT", kEquipments[1]),
              getSubCategory(2, "EQUIPMENT", kEquipments[2]),
              getSubCategory(3, "EQUIPMENT", kEquipments[3]),
              getSubCategory(4, "EQUIPMENT", kEquipments[4]),
              Divider(color: Colors.white),
              getMainCategory(3, "FORMS", Icons.content_paste),
              getSubCategory(0, "FORMS", kFormSubCategories[0]),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'CVR',
          style: kTitleStyle,
        ),
        elevation: 0.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          equipmentSubSelector == false
              ? SizedBox()
              : Container(
                  height: 30,
                  color: Theme.of(context).primaryColor,
                  child: ListView.builder(
                      itemCount: kEquipments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              equipmentSubSelectedIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Center(
                              child: Text(
                                kEquipments[index],
                                style: equipmentSubSelectedIndex == index
                                    ? kSelectedHeaderStyle
                                    : kNotSelectedHeaderStyle,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
          peopleSubSelector == false
              ? SizedBox()
              : Container(
                  height: 30,
                  color: Theme.of(context).primaryColor,
                  child: ListView.builder(
                      itemCount: kPeopleSubCategories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              peopleSubSelectedIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Center(
                              child: Text(
                                kPeopleSubCategories[index],
                                style: peopleSubSelectedIndex == index
                                    ? kSelectedHeaderStyle
                                    : kNotSelectedHeaderStyle,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
          eventSubSelector == false
              ? SizedBox()
              : Container(
                  height: 30,
                  color: Theme.of(context).primaryColor,
                  child: ListView.builder(
                      itemCount: kEventSubCategories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              eventSubSelectedIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Center(
                              child: Text(
                                kEventSubCategories[index],
                                style: eventSubSelectedIndex == index
                                    ? kSelectedHeaderStyle
                                    : kNotSelectedHeaderStyle,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
          formSubSelector == false
              ? SizedBox()
              : Container(
                  height: 30,
                  color: Theme.of(context).primaryColor,
                  child: ListView.builder(
                      itemCount: kFormSubCategories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              formSubSelectedIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Center(
                              child: Text(
                                kFormSubCategories[index],
                                style: formSubSelectedIndex == index
                                    ? kSelectedHeaderStyle
                                    : kNotSelectedHeaderStyle,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
          SizedBox(height: 15),
          Expanded(
            child: getScreen(),
          ),
          Divider(height: 0, thickness: 1),
        ],
      ),
    );
  }
}
