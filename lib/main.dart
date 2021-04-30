import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:buangin_app/blocs/auth_bloc.dart';
import 'package:buangin_app/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.green[400],
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Lato'),
        home: LoginScreen(),
      ),
    );
  }
}
