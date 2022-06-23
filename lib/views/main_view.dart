// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fish_care/views/display_view.dart';
import 'package:fish_care/views/profile_view.dart';
import 'package:fish_care/views/setings_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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
