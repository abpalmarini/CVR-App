import 'package:flutter/material.dart';

const List<String> kCategories = [
  'PEOPLE',
  'EVENTS',
  'EQUIPMENT',
  'FORMS',
];

const List<String> kEquipments = [
  'IMAGING',
  'NGS',
  'FLOW CYTOMETRY',
  'MOLECULAR PURIFICATION & QUANTITATION',
  'GENERAL',
];

const List<String> kPeopleSubCategories = [
  'DIRECTORY',
  'USEFUL CONTACTS',
];

const List<String> kEventSubCategories = [
  'SEMINARS',
  'MEETINGS',
];

const List<String> kFormSubCategories = [
  'USEFUL FORMS',
];

const Map<String, int> kDocumentIndex = {
  'equipment': 1,
  'contacts': 0,
  'links': 2,
};

const kTitleStyle = TextStyle(
  fontFamily: 'Nunito Bold',
  letterSpacing: 0.8,
);

const kSelectedHeaderStyle = TextStyle(
  color: Colors.white,
  fontSize: 22,
  letterSpacing: 1,
  fontFamily: 'Nunito Bold',
);

const kNotSelectedHeaderStyle = TextStyle(
  color: Colors.white60,
  fontSize: 22,
  letterSpacing: 1,
  fontFamily: 'Nunito Bold',
);

const kInfoTextStyle = TextStyle(
  fontFamily: 'IBMsemibold',
  fontSize: 16,
  color: Colors.black54,
  fontWeight: FontWeight.w600,
);

const kHeaderStyle = TextStyle(
  fontFamily: 'IBMbold',
  fontSize: 19,
  fontWeight: FontWeight.bold,
);

const kInfoTextStylePop = TextStyle(
  fontFamily: 'IBMsemibold',
  fontSize: 17,
  color: Colors.black54,
  fontWeight: FontWeight.w600,
);

const kHeaderStylePop = TextStyle(
  fontFamily: 'Nunito Bold',
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const kDrawerHeader = TextStyle(
  color: Colors.white60,
  fontSize: 14,
  letterSpacing: 1,
  fontFamily: 'Nunito Bold',
);

const kDrawerSelectedHeader = TextStyle(
  color: Colors.white,
  fontSize: 14,
  letterSpacing: 1,
  fontFamily: 'Nunito Bold',
);

const kDateTimeStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontFamily: 'Nunito Bold',
);

const kEquipmentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF368EB3),
      Color(0xFF2695C4),
      Color(0xFF70BBE4),
      // Color(0xFFBBF4F6),
    ],
    stops: [
      0.1,
      0.25,
      0.6,
    ]);

const kListViewBuilderPadding = EdgeInsets.only(top: 85.5, bottom: 17.5);

const kWidgetPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

const kDrawerHeaderPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 10);
