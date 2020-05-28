import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Colors.grey[50],
            child: Center(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(
                          top: 30,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  'https://erwinagpasa.com/erwinAvatar3.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'Erwin Agpasa',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        'Developer',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 15.0),
            title: Container(
              child: Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('PrivacyScr');
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 15.0),
            title: Container(
              child: Text(
                'Version 1.0 - Build 1',
                style: TextStyle(fontSize: 14, color: Colors.black45),
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
