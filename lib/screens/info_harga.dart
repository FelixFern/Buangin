import 'package:buangin_app/screens/box/detail_sampah.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class hargaSampah extends StatefulWidget {
  @override
  _hargaSampahState createState() => _hargaSampahState();
}

// ignore: camel_case_types
class _hargaSampahState extends State<hargaSampah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black87),
            title: Text(
              "Harga Sampah",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontSize: 20),
            ),
            elevation: 4.0,
            backgroundColor: Colors.white),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      "SAMPAH PLASTIK",
                      style: TextStyle(
                          color: Color.fromRGBO(18, 189, 38, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Divider(
                        color: Color.fromRGBO(202, 202, 202, 1),
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    detailSampah(
                        judul: "Botol Plastik",
                        deskripsi:
                            "Botol plastik minuman berukuran 200 ml, 250 ml, 330 ml, 500 ml, 600 ml, 1,5 L ",
                        gambar: 'assets/image/sampah/botol_plastik.png',
                        harga: 3000,
                        poin: 60),
                    detailSampah(
                        judul: "Tutup Galon",
                        deskripsi: "Tutup pada galon air minum",
                        gambar: 'assets/image/sampah/tutup_galon.png',
                        harga: 3000,
                        poin: 60),
                    detailSampah(
                        judul: "Tutup Botol Plastik",
                        deskripsi:
                            "Tutup botol plastik minuman berukuran 200 ml, 250 ml, 330 ml, 500 ml, 600 ml, ",
                        gambar: 'assets/image/sampah/tutup_botol_p.png',
                        harga: 2800,
                        poin: 56),
                    detailSampah(
                        judul: "Gelas Plastik",
                        deskripsi: "Gelas plastik 120 ml, 240 ml",
                        gambar: 'assets/image/sampah/gelas_plastik.png',
                        harga: 3500,
                        poin: 70),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "SAMPAH LAINNYA",
                      style: TextStyle(
                          color: Color.fromRGBO(18, 189, 38, 1),
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Divider(
                        color: Color.fromRGBO(202, 202, 202, 1),
                        thickness: 1,
                      ),
                    ),
                    detailSampah(
                        judul: "Pecahan Kaca",
                        deskripsi:
                            "Dapat berupa bekas pecahan kaca botol minum, kaca cermin.",
                        gambar: 'assets/image/sampah/kaca.png',
                        harga: 850,
                        poin: 17),
                    detailSampah(
                        judul: "Kaleng",
                        deskripsi: "Kaleng minuman besi",
                        gambar: 'assets/image/sampah/kaleng.png',
                        harga: 1200,
                        poin: 25),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
