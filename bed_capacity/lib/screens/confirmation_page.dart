import 'package:flutter/material.dart';
import 'package:bed_capacity/common/styles.dart';

class BedRequestConfirmationPage extends StatelessWidget {
  static const routeName = '/bed_request_success';
  const BedRequestConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: darkPrimaryColor,
            title: Center(
              child: Text("Bed Request", style: myTextTheme.overline),
            ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Icon(Icons.check_circle_outline_rounded, size: 100.0, color: Colors.grey)),
              const Text("Permintaan Anda Sukses!\nSilakan tekan tombol di bawah\nuntuk kembali ke halaman utama",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: btnColor,
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  child: Text('KEMBALI', style: TextStyle(color: darkPrimaryColor),),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
