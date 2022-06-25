// ignore_for_file: prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:fish_care/constants/routes.dart';
import 'package:fish_care/firebase_options.dart';
import 'package:fish_care/services/auth/auth_service.dart';
import 'package:fish_care/views/login_view.dart';
import 'package:fish_care/views/main_view.dart';
import 'package:fish_care/views/register_view.dart';
import 'package:fish_care/views/display_view.dart';
import 'package:fish_care/views/verify_email.view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    routes: {
      '/': (context) {
        return HomePage();
      },
      loginRoute: (context) => LoginView(),
      registerRoute: (context) => RegisterView(),
      mainRoute: (context) => MainView(),
      verifyEmailRoute: (context) => VerifyEmailView(),
      displayRoute: (context) => DisplayView(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuhtService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
              } else {
                return VerifyEmailView();
              }
            } else {
              return LoginView();
            }
            return MainView();
          default:
            return CircularProgressIndicator();
        }
      },
    );
  }
}
