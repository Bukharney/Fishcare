import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Lamp extends StatefulWidget {
  List lamp;
  Lamp({Key? key, required this.lamp}) : super(key: key);

  @override
  State<Lamp> createState() => _LampState(lamp);
}

class _LampState extends State<Lamp> {
  List lamp;
  _LampState(this.lamp);
  final _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          width: 330,
          height: 120,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              const Text(
                'LAMP',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              ToggleSwitch(
                changeOnTap: false,
                animationDuration: 100,
                minWidth: 100,
                minHeight: 40.0,
                initialLabelIndex: lamp[4],
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                icons: const [
                  Icons.lightbulb_outline,
                  Icons.lightbulb,
                ],
                totalSwitches: 2,
                iconSize: 30.0,
                activeBgColors: const [
                  [Colors.black45, Colors.black26],
                  [Colors.yellow, Colors.orange]
                ],
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (value) async {
                  if (lamp[5] == 0) {
                    showErrorDialog(context, 'Plaese select manual first!');
                  } else {
                    await _database.update({'data/lamp/status/': value});
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ToggleSwitch(
                changeOnTap: false,
                animationDuration: 300,
                radiusStyle: true,
                minWidth: 80,
                minHeight: 20.0,
                initialLabelIndex: lamp[5],
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                activeBgColors: const [
                  [Colors.green, Color.fromARGB(255, 226, 255, 64)],
                  [Color.fromARGB(255, 226, 255, 64), Colors.green],
                ],
                totalSwitches: 2,
                labels: const ['AUTO', 'MANUAL'],
                fontSize: 8,
                iconSize: 30.0,
                animate: true,
                curve: Curves.bounceInOut,
                onToggle: (value) async {
                  await _database.update({'data/lamp/mode/': value});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
