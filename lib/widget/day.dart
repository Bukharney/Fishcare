import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Day extends StatefulWidget {
  final List date, date0;
  const Day({Key? key, required this.date, required this.date0})
      : super(key: key);

  @override
  State<Day> createState() => _DayState(date, date0);
}

class _DayState extends State<Day> {
  List date, date0;
  _DayState(this.date, this.date0);
  final _database = FirebaseDatabase.instance.ref();
  var now = DateTime.now();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          now = DateTime.now();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.headline4!.fontSize! * 0.5 + 200.0,
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text("DAY",
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
                Container(
                  width: 180,
                  height: 70,
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          DateFormat().format(now),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 80, 0, 255)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          "Remain ${date0[1].difference(now).inDays} Day",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1),
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Text(
                          '${now.difference(date0[0]).inDays}',
                          style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(202, 236, 219, 1),
                          ),
                          onPressed: () async {
                            await _database.update({
                              'FISH/DATE0/':
                                  DateFormat('yyyy-MM-dd').format(now)
                            });
                            await _database.update({
                              'FISH/DATE1/': DateFormat('yyyy-MM-dd')
                                  .format(now.add(Duration(days: date[1])))
                            });
                          },
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
    );
  }
}
