import 'dart:async';

import 'package:buangin_app/screens/info_harga.dart';
import 'package:buangin_app/screens/kumpul_sampah.dart';

import 'package:buangin_app/screens/menu_poin.dart';
import 'package:buangin_app/screens/menu_saldo.dart';
import 'package:buangin_app/screens/box/poin.dart';
import 'package:buangin_app/screens/box/saldo.dart';
import 'package:buangin_app/screens/box/sampahTerkumpul.dart';
import 'package:buangin_app/screens/menu_sampah.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buangin_app/blocs/auth_bloc.dart';
import 'package:buangin_app/screens/login.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription<User> loginStateSubscription;

  @override
  void initState() {
    var authBloc = Provider.of<AuthBloc>(context, listen: false);
    loginStateSubscription = authBloc.currentUser.listen((fbUser) {
      if (fbUser == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
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
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "BUANGIN",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.white, fontSize: 20),
          ),
          backwardsCompatibility: false,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Color.fromRGBO(18, 189, 38, 1),
          elevation: 4.0,
        ),
        body: Center(
          child: StreamBuilder<User>(
              stream: authBloc.currentUser,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Bagian Nama dan Saldo
                      Stack(
                        children: [
                          //Nama
                          Container(
                            height: MediaQuery.of(context).size.height * 0.23,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.black87,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      "Halo,",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      snapshot.data.displayName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                  alignment: Alignment.topRight,
                                  icon: Icon(Icons.logout),
                                  onPressed: () => authBloc.logout(),
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                          //Saldo
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              GestureDetector(
                                child: kotakSaldo(),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => saldoMenu()));
                                },
                              ),
                              Spacer(),
                              GestureDetector(
                                child: kotakPoin(),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => poinMenu()));
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                      //Sampah Terkumpul
                      GestureDetector(
                        child: sampahTerkumpul(),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => sampahMenu()));
                        },
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => kumpulSampah()));
                            },
                            child: Text(
                              "Kumpulkan Sampah !",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Color.fromRGBO(18, 189, 38, 1),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0)))),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => hargaSampah()));
                            },
                            child: Text(
                              "Info Harga",
                              style: TextStyle(
                                  color: Color.fromRGBO(18, 189, 38, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1),
                            ),
                            style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: Color.fromRGBO(18, 189, 38, 1),
                                    width: 2),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10.0)))),
                      ),
                    ]);
              }),
        ));
  }
}
