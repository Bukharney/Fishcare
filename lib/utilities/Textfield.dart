import 'package:firebase_database/firebase_database.dart';
import 'package:fish_care/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _text1 = TextEditingController();
  final _database = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'E-mail',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _text1,
              autocorrect: true,
              style: (const TextStyle(
                  color: Color.fromRGBO(49, 87, 44, 1),
                  fontWeight: FontWeight.w400)),
              keyboardType: TextInputType.emailAddress,
              cursorColor: const Color.fromRGBO(19, 42, 19, 1),
              obscureText: false,
              decoration: InputDecoration(
                hintText: 'Enter your E-mail',
                hintStyle: TextStyle(color: Colors.grey[700], fontSize: 15),
                border: UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(30.0)),
                fillColor: const Color.fromRGBO(202, 236, 219, 1),
                filled: true,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(56, 123, 89, 1), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await _database
                          .update({'data/date/num': int.parse(_text1.text)});
                    } catch (e) {
                      showErrorDialog(context, e.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      minimumSize: const Size(75, 35)),
                  child: const Text('sda')),
            ),
          ],
        ),
      ),
    );
  }
}
