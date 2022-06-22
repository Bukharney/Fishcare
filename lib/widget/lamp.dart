import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class Lamp extends StatefulWidget {
  final List lamp;
  const Lamp({Key? key, required this.lamp}) : super(key: key);

  @override
  State<Lamp> createState() => _LampState(lamp);
}

class _LampState extends State<Lamp> {
  List lamp;
  _LampState(this.lamp);
  late TimeOfDay timeOn;
  late TimeOfDay timeOff;
  final initialTime = TimeOfDay.now();
  final _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.0),
      width: 330,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 120,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Lamp',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(
                width: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('ON',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () async {
                        final newTime = await showTimePicker(
                          context: context,
                          initialTime: initialTime,
                        );
                        if (newTime == null) {
                          return;
                        }
                        setState(() {
                          timeOn = newTime;
                        });
                        try {
                          await _database
                              .update({'data/lamp/onH/': timeOn.hour});
                          await _database
                              .update({'data/lamp/onM/': timeOn.minute});
                        } catch (e) {
                          showErrorDialog(context, e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen,
                          minimumSize: const Size(75, 35)),
                      child: Text(
                          '${lamp[0].toString().padLeft(2, '0')} : ${lamp[1].toString().padLeft(2, '0')}'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('OFF',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      ElevatedButton(
                          onPressed: () async {
                            final newTime = await showTimePicker(
                              context: context,
                              initialTime: initialTime,
                            );
                            if (newTime == null) {
                              return;
                            }
                            setState(() {
                              timeOff = newTime;
                            });
                            try {
                              await _database.update({
                                'data/lamp/offH/': timeOff.hour,
                              });
                              await _database
                                  .update({'data/lamp/offM/': timeOff.minute});
                            } catch (e) {
                              showErrorDialog(context, e.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent,
                              minimumSize: const Size(75, 35)),
                          child: Text(
                              '${lamp[2].toString().padLeft(2, '0')} : ${lamp[3].toString().padLeft(2, '0')}')),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
