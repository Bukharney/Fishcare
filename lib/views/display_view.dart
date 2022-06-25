// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/widget/day.dart';
import 'package:fish_care/widget/lamp.dart';
import 'package:fish_care/widget/temp.dart';
import 'package:flutter/material.dart';

class DisplayView extends StatefulWidget {
  const DisplayView({Key? key}) : super(key: key);

  @override
  State<DisplayView> createState() => _DisplayViewState();
}

class _DisplayViewState extends State<DisplayView> {
  late DateTime date1 = DateTime.now();
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _snap;
  late Timer _timer;

  List<int> date = <int>[0, 0];
  List<int> lamp = <int>[0, 0, 0, 0, 0, 0];
  List<double> temp = <double>[0.0, 0.0, 0.0];
  var now = DateTime.now();
  List<DateTime> date0 = <DateTime>[
    DateTime.parse("2021-12-11"),
    DateTime.parse("2020-02-12"),
  ];
  late TimeOfDay timeOn;
  late TimeOfDay timeOff;
  final initialTime = TimeOfDay.now();
  late DateTime a;
  @override
  void initState() {
    _activateListners();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        setState(() {
          now = DateTime.now();
        });
      }
    });
    super.initState();
  }

  Future<void> _activateListners() async {
    _snap = _database.child('FISH').onValue.listen((event) {
      setState(() {
        date[0] = event.snapshot.child('CHANGE/').value as int;
        date[1] = event.snapshot.child('PREOID/').value as int;
        date0[0] =
            DateTime.parse(event.snapshot.child('DATE0/').value.toString());
        date0[1] =
            DateTime.parse(event.snapshot.child('DATE1/').value.toString());

        lamp[0] = event.snapshot.child('LED/').value as int;
        lamp[1] = event.snapshot.child('STATUS/').value as int;
        temp[0] = event.snapshot.child('TEMP_WATER').value as double;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(137, 209, 172, 1),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Day(
                          date: date,
                          date0: date0,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Temp(temp: temp),
                        const SizedBox(
                          height: 15,
                        ),
                        Lamp(lamp: lamp),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
