import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class LampSettings extends StatefulWidget {
  final List lamp;
  const LampSettings({Key? key, required this.lamp}) : super(key: key);

  @override
  State<LampSettings> createState() => _LampSettingsState(lamp);
}

class _LampSettingsState extends State<LampSettings> {
  List lamp;
  _LampSettingsState(this.lamp);
  late TimeOfDay timeOn;
  late TimeOfDay timeOff;
  final initialTime = TimeOfDay.now();
  final _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.0),
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.headline4!.fontSize! * 0.5 + 100.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 120,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('LAMP',
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          await _database.update({'FISH/LEDONH/': timeOn.hour});
                          await _database
                              .update({'FISH/LEDONM/': timeOn.minute});
                        } catch (e) {
                          showErrorDialog(context, e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen,
                          maximumSize: const Size(90, 40)),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Center(
                          child: Text(
                              '${lamp[0].toString().padLeft(2, '0')} : ${lamp[1].toString().padLeft(2, '0')}'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
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
                            'FISH/LEDOFFH/': timeOff.hour,
                          });
                          await _database
                              .update({'FISH/LEDOFFM/': timeOff.minute});
                        } catch (e) {
                          showErrorDialog(context, e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          maximumSize: const Size(90, 40)),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Center(
                          child: Text(
                              '${lamp[2].toString().padLeft(2, '0')} : ${lamp[3].toString().padLeft(2, '0')}'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
