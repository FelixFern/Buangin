import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class historySaldo extends StatelessWidget {
  final int jenis;
  final int nominal;
  final String date;

  const historySaldo({Key key, this.jenis, this.nominal, this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color color;
    String addormin;
    String title;
    if (jenis == 0) {
      color = Color.fromRGBO(255, 69, 69, 1);
      addormin = "-";
      title = "Penarikan saldo";
    } else {
      addormin = "+";
      color = Color.fromRGBO(0, 170, 9, 1);
      title = "Pengumpulan Sampah";
    }
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
          height: 68,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 15,
              ),
              Container(
                width: 47,
                height: 47,
                child: Image.asset(
                  "assets/image/saldo_logo_g.png",
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14)),
                    Row(
                      children: [
                        Text(
                          addormin +
                              "Rp." +
                              NumberFormat.currency(locale: 'eu', symbol: '')
                                  .format(nominal)
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: color),
                        ),
                        Spacer(),
                        Text(
                          date,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.black38),
                        ),
                        SizedBox(
                          width: 15,
                        )
                      ],
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
