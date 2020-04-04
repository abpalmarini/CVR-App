import 'package:flutter/material.dart';
import 'package:cvr/widgets/screen_layout.dart';
import '../home_screen.dart';
import 'package:cvr/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cvr/widgets/search_bar.dart';
import 'package:cvr/widgets/form_widget.dart';

class UsefulFormsScreen extends StatefulWidget {
  @override
  _UsefulFormsScreenState createState() => _UsefulFormsScreenState();
}

class _UsefulFormsScreenState extends State<UsefulFormsScreen> {
  var forms;
  Future<void> _launched;
  String search = '';

  Future<void> _launchInBrowser(String url) async {
    url = url.trim();
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  bool containsSearch(String search, int index) {
    if (search == '') {
      return true;
    } else if (forms[index]['form']
        .toLowerCase()
        .contains(search.toLowerCase())) {
      return true;
    } else {
      return false;
    }
  }

  int cast<int>(x) => x is int ? x : null;

  void getAlphabeticalOrder() {
    forms.sort((a, b) => cast<int>(a['form'].compareTo(b['form'])));
  }

  @override
  void initState() {
    super.initState();
    forms = categories.documents[kDocumentIndex['links']].data['Forms'];
    getAlphabeticalOrder();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        child: Stack(
      children: <Widget>[
        ListView.builder(
            padding: kListViewBuilderPadding,
            //padding: EdgeInsets.only(top: 85.5),
            itemCount: forms.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _launched = _launchInBrowser(forms[index]['url']);
                  });
                },
                child: containsSearch(search, index)
                    ? FormWidget(forms[index]['form'])
                    : SizedBox(),
              );
            }),
        SearchBar(
          category: 'Forms',
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
