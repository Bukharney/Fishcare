// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/widget/setlamp.dart';
import 'package:fish_care/widget/settemp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _database = FirebaseDatabase.instance.ref();
  late StreamSubscription _snap;
  late Timer _timer;
  var now = DateTime.now();
  List<int> time = <int>[0, 0, 0, 0];

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
    _snap = _database.child('FISH').onValue.listen((event) {
      setState(() {
        time[0] = event.snapshot.child('LEDONH/').value as int;
        time[1] = event.snapshot.child('LEDONM/').value as int;
        time[2] = event.snapshot.child('LEDOFFH/').value as int;
        time[3] = event.snapshot.child('LEDOFFM/').value as int;
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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          constraints: BoxConstraints.expand(
                            height: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .fontSize! *
                                    0.5 +
                                100.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text('PROJECT',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text('SETTING',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)),
                            ],
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LampSettings(lamp: time),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
