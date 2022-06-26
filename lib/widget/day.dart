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
                          "Remain ${date0[1].difference(now).inDays + 1} Day",
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
                          '${now.difference(date0[0]).inDays + 1}',
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
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Reset'),
                                  content: const Text(
                                      'Are you sure you want to reset?'),
                                  actions: [
                                    TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Enter period',
                                        hintStyle: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 15),
                                        border: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        fillColor: Colors.white,
                                        filled: true,
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.blue, width: 2.0),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0)),
                                        ),
                                      ),
                                      onChanged: (value) async {
                                        date[1] = int.parse(value);
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await _database.update(
                                                {'FISH/PREOID/': date[1]});
                                            await _database.update({
                                              'FISH/DATE0/':
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(now)
                                            });
                                            await _database.update({
                                              'FISH/DATE1/': DateFormat(
                                                      'yyyy-MM-dd')
                                                  .format(now.add(
                                                      Duration(days: date[1])))
                                            });
                                            Navigator.of(context).pop(true);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ).then((value) => value ?? false);
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
