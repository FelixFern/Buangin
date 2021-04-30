import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class historySampah extends StatelessWidget {
  final int nominal;
  final String date;
  final double berat;
  final int poin;

  const historySampah({Key key, this.nominal, this.date, this.berat, this.poin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color color = Color.fromRGBO(0, 170, 9, 1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Color.fromRGBO(244, 244, 244, 1),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ]),
          height: 95,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Berat Sampah : " + berat.toStringAsFixed(2) + " Kg",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18)),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/image/saldo_logo_g.png',
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "+Rp." +
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '')
                                        .format(nominal)
                                        .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: color),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/image/poin_logo_g.png',
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              poin.toString() + " Poin",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(0, 170, 19, 1),
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                    Text(
                      date,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.black38),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
