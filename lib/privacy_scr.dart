import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PrivacyScr extends StatefulWidget {
  @override
  _PrivacyScrState createState() => _PrivacyScrState();
}

class _PrivacyScrState extends State<PrivacyScr> {
  Icon actionIcon = new Icon(Icons.more_vert);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        bottom: PreferredSize(
            child: Container(
              color: Colors.black12,
              height: 0.5,
            ),
            preferredSize: Size.fromHeight(0.5)),
        iconTheme: IconThemeData(color: Colors.white), //color for drawer icon
        actionsIconTheme:
            IconThemeData(color: Colors.white), //color for appBar icon

        centerTitle: true, //centering the title
        title:
            new Text('Privacy Policy', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff571330),
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            onPressed: () {
              Navigator.of(context).pushNamed('emailRoute');
            },
          ),
        ],
      ),
      body: WebviewScaffold(url: 'https://erwinagpasa.com/privacyapp.html'),
    );
  }
}
