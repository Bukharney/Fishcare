// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fish_care/views/display_view.dart';
import 'package:fish_care/views/profile_view.dart';
import 'package:fish_care/views/setings_view.dart';
import 'package:flutter/material.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  int pageIndex = 1;
  @override
  Widget build(BuildContext context) {
    List<Widget> pageList = <Widget>[
      SettingsView(),
      DisplayView(),
      ProfileView()
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: pageList[pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        height: 50,
        index: 1,
        backgroundColor: Color.fromRGBO(137, 209, 172, 1),
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: const [
          Icon(Icons.settings),
          Icon(Icons.home_filled),
          Icon(Icons.person),
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Sign out'),
        content: Text('Are you sure you went to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Yes'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
