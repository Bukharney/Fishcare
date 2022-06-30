// ignore_for_file: prefer_const_constructors
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_care/constants/routes.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final user = FirebaseAuth.instance.currentUser;
  late String cpass;
  late String npass;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(137, 209, 172, 1),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints.expand(
                        height:
                            Theme.of(context).textTheme.headline4!.fontSize! *
                                    0.5 +
                                100.0,
                      ),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('PROFILE',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          Text('SETTING',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                        ],
                      )),
                    ),
                    SizedBox(height: 10),
                    Container(
                      constraints: BoxConstraints.expand(
                        height:
                            Theme.of(context).textTheme.headline4!.fontSize! *
                                    0.5 +
                                100.0,
                      ),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('EMAIL',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(user!.email.toString(),
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black)),
                        ],
                      )),
                    ),
                    SizedBox(height: 10),
                    Container(
                      constraints: BoxConstraints.expand(
                        height:
                            Theme.of(context).textTheme.headline4!.fontSize! *
                                    0.5 +
                                220.0,
                      ),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'ACCOUNT',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(200, 40),
                                  primary: Colors.lightGreen),
                              onPressed: () async {
                                try {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AlertDialog(
                                          title: Text("Change password"),
                                          actions: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                      onChanged: (value) {
                                                        log(value);
                                                        cpass = value;
                                                      },
                                                      keyboardType:
                                                          TextInputType
                                                              .visiblePassword,
                                                      obscureText: true,
                                                      decoration:
                                                          InputDecoration(
                                                        label: Text(
                                                            "Current password"),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                      onChanged: (value) {
                                                        log(value);
                                                        npass = value;
                                                      },
                                                      keyboardType:
                                                          TextInputType
                                                              .visiblePassword,
                                                      obscureText: true,
                                                      decoration:
                                                          InputDecoration(
                                                        label: Text(
                                                            "New password"),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  child: Text("Close",
                                                      style: TextStyle(
                                                          color: Colors.grey)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("Confirm",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .blueAccent)),
                                                  onPressed: () async {
                                                    try {
                                                      User? user = FirebaseAuth
                                                          .instance.currentUser;
                                                      final cred =
                                                          EmailAuthProvider
                                                              .credential(
                                                                  email: user!
                                                                      .email!,
                                                                  password:
                                                                      cpass);
                                                      await user
                                                          .reauthenticateWithCredential(
                                                              cred)
                                                          .then((value) {
                                                        user
                                                            .updatePassword(
                                                                npass)
                                                            .then((value) {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Password change successfully!',
                                                              gravity:
                                                                  ToastGravity
                                                                      .CENTER);
                                                          Navigator.of(context)
                                                              .pop();
                                                        }).catchError((err) {
                                                          Fluttertoast.showToast(
                                                              msg: err.message,
                                                              gravity:
                                                                  ToastGravity
                                                                      .CENTER);
                                                        });
                                                      });
                                                    } on FirebaseAuthException catch (e) {
                                                      if (e.code ==
                                                          'wrong-password') {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Password is incorrect',
                                                            gravity:
                                                                ToastGravity
                                                                    .CENTER);
                                                      }
                                                      log(e.code);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } catch (e) {
                                  log(e.toString());
                                }
                              },
                              child: Text('CHANGE PASSWORD'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(200, 40),
                                  primary: Colors.amber),
                              onPressed: () async {
                                try {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: Text("Sign out"),
                                        content: Text("You want to sign out?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Cancel",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text("OK",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            onPressed: () async {
                                              try {
                                                await FirebaseAuth.instance
                                                    .signOut();

                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Sign out successfully!',
                                                    gravity:
                                                        ToastGravity.CENTER);
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                  loginRoute,
                                                  (route) => false,
                                                );
                                              } catch (e) {
                                                log(e.toString());
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } catch (e) {
                                  log(e.toString());
                                }
                              },
                              child: Text('SIGN OUT'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(200, 40),
                                  primary: Colors.redAccent),
                              onPressed: () async {
                                try {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      // return object of type Dialog
                                      return AlertDialog(
                                        title: Text("Delete account"),
                                        content: Text(
                                            "You want to delete this account?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Cancel",
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text("OK",
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            onPressed: () async {
                                              try {
                                                await FirebaseAuth
                                                    .instance.currentUser!
                                                    .delete();
                                                Fluttertoast.showToast(
                                                    msg: 'Delete successfully!',
                                                    gravity:
                                                        ToastGravity.CENTER);
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                  loginRoute,
                                                  (route) => false,
                                                );
                                              } on FirebaseAuthException catch (e) {
                                                if (e.code ==
                                                    'requires-recent-login') {
                                                  log('The user must reauthenticate before this operation can be executed.');
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } catch (e) {
                                  log(e.toString());
                                }
                              },
                              child: Text('DELETE ACCOUNT'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
