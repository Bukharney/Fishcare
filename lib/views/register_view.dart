// ignore_for_file: prefer_const_constructors

import 'package:fish_care/constants/routes.dart';
import 'package:fish_care/services/auth/auth_exceptions.dart';
import 'package:fish_care/services/auth/auth_service.dart';
import 'package:fish_care/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(137, 209, 172, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              child: Text(
                'Create Account',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Please fill the input below.',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 13),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'E-mail',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _email,
                    autocorrect: true,
                    style: (TextStyle(
                        color: Color.fromRGBO(49, 87, 44, 1),
                        fontWeight: FontWeight.w400)),
                    cursorColor: Color.fromRGBO(49, 87, 44, 1),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your E-mail',
                      hintStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.0,
                              style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(30.0)),
                      fillColor: Color.fromRGBO(202, 236, 219, 1),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(56, 123, 89, 1), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Password',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _password,
                    autocorrect: true,
                    style: (TextStyle(
                        color: Color.fromRGBO(49, 87, 44, 1),
                        fontWeight: FontWeight.w400)),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    cursorColor: Color.fromRGBO(49, 87, 44, 1),
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 15),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.0,
                              style: BorderStyle.none),
                          borderRadius: BorderRadius.circular(30.0)),
                      fillColor: Color.fromRGBO(202, 236, 219, 1),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(56, 123, 89, 1), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    try {
                      await AuhtService.firebase().createUser(
                        email: email,
                        password: password,
                      );
                      AuhtService.firebase().sendEmailVerification();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, (route) => false);
                    } on WeakPasswordAuthException {
                      await showErrorDialog(
                        context,
                        'Weak password',
                      );
                    } on EmailAlreadyInUseAuthException {
                      await showErrorDialog(
                        context,
                        'Email is already in use',
                      );
                    } on InvalidEmailAuthException {
                      await showErrorDialog(
                        context,
                        'Invalid email address',
                      );
                    } on GenericAuthException {
                      await showErrorDialog(
                        context,
                        'Failed to register',
                      );
                    }
                  },
                  icon: Icon(
                    Icons.app_registration,
                    color: Color(0xff251F34),
                  ),
                  label: Text(
                    "REGISTER",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff251F34),
                        fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(202, 236, 219, 1),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(
                      color: Color.fromRGBO(19, 42, 19, 1),
                      fontWeight: FontWeight.w400),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  },
                  child: Text('Sign in',
                      style: TextStyle(
                        color: Color.fromRGBO(7, 17, 8, 1),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
