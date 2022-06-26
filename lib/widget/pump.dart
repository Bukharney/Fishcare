import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Pump extends StatefulWidget {
  List pump;
  Pump({Key? key, required this.pump}) : super(key: key);

  @override
  State<Pump> createState() => _PumpState(pump);
}

class _PumpState extends State<Pump> {
  List pump;
  _PumpState(this.pump);
  final _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.headline4!.fontSize! * 0.5 + 100.0,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'PUMP IN',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                ToggleSwitch(
                  changeOnTap: false,
                  animationDuration: 100,
                  minWidth: 60,
                  minHeight: 40.0,
                  initialLabelIndex: pump[0],
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
                    await _database.update({'FISH/PUMPIN/': value});
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'PUMP OUT',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                ToggleSwitch(
                  changeOnTap: false,
                  animationDuration: 100,
                  minWidth: 60,
                  minHeight: 40.0,
                  initialLabelIndex: pump[1],
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
                    await _database.update({'FISH/PUMPOUT/': value});
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
