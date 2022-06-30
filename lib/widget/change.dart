import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Change extends StatefulWidget {
  List change;
  Change({Key? key, required this.change}) : super(key: key);

  @override
  State<Change> createState() => _ChangeState(change);
}

class _ChangeState extends State<Change> {
  List change;
  _ChangeState(this.change);
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
                Text(
                  'CHANGE : ${change[0]}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                ToggleSwitch(
                  changeOnTap: false,
                  animationDuration: 100,
                  minWidth: 100,
                  minHeight: 40.0,
                  initialLabelIndex: change[0],
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
                    await _database.update({'FISH/CHANGE/': value});
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
