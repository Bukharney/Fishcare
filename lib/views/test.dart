import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/utilities/Textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late DateTime date1 = DateTime.now();
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _snap;
  late Timer _timer;

  List<String> lamp = <String>[
    '00.00',
    '00.00',
  ];
  List<int> date = <int>[0, 0];
  List<double> temp = <double>[0.0, 0.0];
  late final TextEditingController ki;
  var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _activateListners();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  Future<void> _activateListners() async {
    _snap = _database.child('data').onValue.listen((event) {
      setState(() {
        date[0] = event.snapshot.child('date/date').value as int;
        date[1] = event.snapshot.child('date/num').value as int;
        lamp[0] = event.snapshot.child('lamp/on').value.toString();
        lamp[1] = event.snapshot.child('lamp/off').value.toString();
        temp[0] = event.snapshot.child('temp/low').value as double;
        temp[1] = event.snapshot.child('temp/high').value as double;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(DateFormat('EEE, d/M/y').format(date1)),
                  Text(" ${now.hour}:${now.minute}:${now.second}"),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          width: 330,
                          height: 165,
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 10),
                                        child: Text("DAY",
                                            style: TextStyle(
                                                fontSize: 45,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white))),
                                    Container(
                                      width: 150,
                                      height: 50,
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 1),
                                            child: Text(
                                              "Remain ${date[1] - date[0]} Day",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue[700]),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 1),
                                            child: Text(
                                              "Peroid ${date[1]} day",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.green[700]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 0, 0, 0),
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                  fontSize: 60,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: const Color.fromRGBO(
                                                    202, 236, 219, 1),
                                              ),
                                              onPressed: () async {},
                                              child: const Text('RESET',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(lamp[0]),
                    Text(lamp[1]),
                    Text('${temp[0]}'),
                    Text('${temp[1]}'),
                    const MyWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    _snap.cancel;
    super.deactivate();
  }
}
