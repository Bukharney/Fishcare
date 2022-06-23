import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class TempSettings extends StatefulWidget {
  final List temp;
  const TempSettings({Key? key, required this.temp}) : super(key: key);

  @override
  State<TempSettings> createState() => _TempSettingsState(temp);
}

class _TempSettingsState extends State<TempSettings> {
  List temp;
  _TempSettingsState(this.temp);
  late TimeOfDay timeOn;
  late TimeOfDay timeOff;
  final initialTime = TimeOfDay.now();
  final _database = FirebaseDatabase.instance.ref();

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

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
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 120,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Temp',
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen,
                              maximumSize: const Size(90, 40)),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Center(
                                child: TextField(
                                  controller: _controller1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType: TextInputType.number,
                                  showCursor: false,
                                  decoration: InputDecoration(
                                    labelText: ' ${temp[0]}  ํc',
                                    focusColor: Colors.white,
                                    border: InputBorder.none,
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    floatingLabelStyle: const TextStyle(
                                        color: Colors.transparent),
                                    suffixText: ' ํc',
                                    suffixStyle:
                                        const TextStyle(color: Colors.white),
                                  ),
                                  onSubmitted: (value) async {
                                    try {
                                      await _database.update({
                                        'data/temp/low/': double.parse(value)
                                      });
                                    } catch (e) {
                                      showErrorDialog(context, e.toString());
                                    }
                                  },
                                ),
                              ))),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.redAccent,
                            maximumSize: const Size(90, 40)),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: TextField(
                            controller: _controller2,
                            onSubmitted: (value) async {
                              try {
                                await _database.update(
                                    {'data/temp/high/': double.parse(value)});
                              } catch (e) {
                                showErrorDialog(context, e.toString());
                              }
                            },
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.number,
                            showCursor: false,
                            decoration: InputDecoration(
                              labelText: ' ${temp[1]}  ํc',
                              focusColor: Colors.white,
                              border: InputBorder.none,
                              labelStyle: const TextStyle(color: Colors.white),
                              floatingLabelStyle:
                                  const TextStyle(color: Colors.transparent),
                              suffixText: ' ํc',
                              suffixStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
