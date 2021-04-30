import 'package:flutter/material.dart';

// ignore: camel_case_types
class detailSampah extends StatelessWidget {
  @override
  // ignore: override_on_non_overriding_member
  final String judul;
  final String deskripsi;
  final String gambar;
  final int harga;
  final int poin;

  const detailSampah(
      {Key key, this.judul, this.deskripsi, this.gambar, this.harga, this.poin})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
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
      height: 91,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15,
          ),
          Container(
            width: 80,
            height: 80,
            child: Image.asset(
              gambar,
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
                Text(judul,
                    style: TextStyle(
                        color: Color.fromRGBO(0, 170, 19, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 14)),
                Text(
                  deskripsi,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/image/saldo_logo_g.png',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Rp.",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          harga.toString(),
                          style: TextStyle(
                              fontSize: 10,
                              color: Color.fromRGBO(0, 170, 19, 1),
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "/kg",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/image/poin_logo_g.png',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          poin.toString(),
                          style: TextStyle(
                              fontSize: 10,
                              color: Color.fromRGBO(0, 170, 19, 1),
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          "Poin/kg",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
