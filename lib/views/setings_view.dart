// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/widget/day.dart';
import 'package:fish_care/widget/lamp.dart';
import 'package:fish_care/widget/temp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late DateTime date1 = DateTime.now();
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _snap;
  late Timer _timer;

  List<int> date = <int>[0, 0];
  List<int> lamp = <int>[0, 0, 0, 0];
  List<double> temp = <double>[0.0, 0.0];
  var now = DateTime.now();
  late TimeOfDay timeOn;
  late TimeOfDay timeOff;
  final initialTime = TimeOfDay.now();

  @override
  void initState() {
    _activateListners();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          now = DateTime.now();
        });
      }
    });
    super.initState();
  }

  Future<void> _activateListners() async {
    _snap = _database.child('data').onValue.listen((event) {
      setState(() {
        date[0] = event.snapshot.child('date/date').value as int;
        date[1] = event.snapshot.child('date/num').value as int;
        lamp[0] = event.snapshot.child('lamp/onH').value as int;
        lamp[1] = event.snapshot.child('lamp/onM').value as int;
        lamp[2] = event.snapshot.child('lamp/offH').value as int;
        lamp[3] = event.snapshot.child('lamp/offM').value as int;
        temp[0] = event.snapshot.child('temp/low').value as double;
        temp[1] = event.snapshot.child('temp/high').value as double;
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
                  child: Column(
                    children: [
                      Lamp(lamp: lamp),
                      const SizedBox(
                        height: 10,
                      ),
                      Temp(temp: temp),
                    ],
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
