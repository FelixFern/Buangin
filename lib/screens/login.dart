import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buangin_app/blocs/auth_bloc.dart';
import 'package:buangin_app/screens/home.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    loginStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 170, 19, 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/logo_white.png',
              height: 253,
              width: 253,
            ),
            Text(
              "Selamat Datang di",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            Text(
              "Buangin",
              style: TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 70,
            ),
            OutlinedButton.icon(
                onPressed: () => authBloc.loginGoogle(),
                label: Text(
                  "Masuk dengan Google",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 3),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)))),
          ],
        ),
      ),
    ));
  }
}
