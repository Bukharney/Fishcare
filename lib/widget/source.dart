import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class Mornitor extends StatefulWidget {
  final List source;
  const Mornitor({Key? key, required this.source}) : super(key: key);

  @override
  State<Mornitor> createState() => _MornitorState(source);
}

class _MornitorState extends State<Mornitor> {
  List source;
  _MornitorState(this.source);
  final _database = FirebaseDatabase.instance.ref();
  final _controller1 = TextEditingController();

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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TEMP',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    maximumSize: const Size(70, 40),
                  ),
                  onPressed: () {},
                  child: Center(
                    child: Text('${source[1]}'),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'MAIN',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                      maximumSize: const Size(70, 40)),
                  onPressed: () {},
                  child: Center(
                    child: Text('${source[0]}'),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DELAY',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                      maximumSize: const Size(70, 40)),
                  onPressed: () {},
                  child: Center(
                    child: TextField(
                      controller: _controller1,
                      cursorColor: Colors.white,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      showCursor: true,
                      decoration: InputDecoration(
                        label: Center(
                          child: Text('${source[2]}'),
                        ),
                        focusColor: Colors.white,
                        border: InputBorder.none,
                        labelStyle: const TextStyle(color: Colors.white),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.transparent),
                      ),
                      onSubmitted: (value) async {
                        try {
                          await _database
                              .update({'FISH/DLAY/': double.parse(value)});
                        } catch (e) {
                          showErrorDialog(context, e.toString());
                        }
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
