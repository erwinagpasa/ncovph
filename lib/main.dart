import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ncovph/main_drawer.dart';
import 'package:ncovph/privacy_scr.dart';

const icoVirus = 'assets/icons/virus.svg';
void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new HomePage(),
    routes: <String, WidgetBuilder>{
      'PrivacyScr': (_) => PrivacyScr(),
    },
  ));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;
  bool isLoading = false;
  int total;
  int admitted;
  int died;
  int recovered;

  int newCase;
  int newAdmission;
  int newDeath;
  int newRecoveries;
  String ncovDate;

  Future<String> getData({isShowLoading: true}) async {
    if (isShowLoading) {
      setState(() {
        isLoading = true;
      });
    }
    var response = await http.get(
        //https://www.doh.gov.ph/covid19tracker
        Uri.encodeFull("https://erwinagpasa.com/ncovapi.php"),
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      if (isShowLoading) {
        setState(() {
          isLoading = false;

          var resBody = jsonDecode(response.body);
          total = resBody['total'];
          admitted = resBody['admitted'];
          died = resBody['died'];
          recovered = resBody['recovered'];
          newCase = resBody['newCase'];
          newAdmission = resBody['newAdmission'];
          newDeath = resBody['newDeath'];
          newRecoveries = resBody['newRecoveries'];
          ncovDate = resBody['ncovDate'];
        });
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    if (mounted) {
      setState(() {
        //data = jsonDecode(response.body);
      });
    }

    return "Success!";
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<Null> _onRefresh() async {
    await getData(isShowLoading: false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: MainDrawer(),
      backgroundColor: Colors.white,
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.transparent,
        elevation: 0.0, //color for drawer icon
      ),
      body: isLoading
          ? Container(
              child: SpinKitDoubleBounce(
                color: Colors.redAccent,
                size: 30.0,
              ),
            )
          : RefreshIndicator(
              key: refreshKey,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            child: SvgPicture.asset(icoVirus,
                                height: 131.0, color: Colors.red[400]),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(top: 12.0, bottom: 55.0),
                            child: new Text(
                              'nCoV PH',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          new Text(
                            'COVID-19 Case Tracker Philippines',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 14.0),
                          ),
                          new Text(
                            'TOTAL CONFIRMED (NATIONWIDE)',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18.0),
                          ),
                          new Text('$ncovDate'),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: new Text(
                              '$total'.replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => "${m[1]},"),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 36.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: new Text(
                              '$newCase'.replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => "${m[1]},"),
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 18.0),
                            ),
                          ),
                          new Text(
                            'New Cases',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 55.0),
                        child: Column(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 15.0, bottom: 15.0),
                                        color: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            new Text(
                                              'ADMITTED',
                                              style: const TextStyle(
                                                  color: Colors.blue),
                                            ),
                                            new Text(
                                              '$admitted'.replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => "${m[1]},"),
                                              style: const TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 30.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: new Text(
                                                '$newAdmission'.replaceAllMapped(
                                                    new RegExp(
                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                    (Match m) => "${m[1]},"),
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            new Text(
                                              'New Admission',
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 15.0, bottom: 15.0),
                                        color: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            new Text(
                                              'DIED',
                                              style: const TextStyle(
                                                  color: Colors.red),
                                            ),
                                            new Text(
                                              '$died'.replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => "${m[1]},"),
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 30.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: new Text(
                                                '$newDeath'.replaceAllMapped(
                                                    new RegExp(
                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                    (Match m) => "${m[1]},"),
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            new Text(
                                              'New Deaths',
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 15.0, bottom: 15.0),
                                        color: Colors.white,
                                        child: Column(
                                          children: <Widget>[
                                            new Text(
                                              'RECOVERED',
                                              style: const TextStyle(
                                                  color: Colors.green),
                                            ),
                                            new Text(
                                              '$recovered'.replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => "${m[1]},"),
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 30.0),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              child: new Text(
                                                '$newRecoveries'.replaceAllMapped(
                                                    new RegExp(
                                                        r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                    (Match m) => "${m[1]},"),
                                                style: const TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            new Text(
                                              'New Recoveries',
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(top: 55.0),
                                  child: Center(
                                    child: new Text(
                                      'Source: doh.gov.ph',
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onRefresh: _onRefresh,
            ),
    );
  }
}



