import 'package:bed_capacity/main.dart';
import 'package:flutter/material.dart';
import 'package:bed_capacity/models/hospital.dart';
import 'package:bed_capacity/common/styles.dart';
import 'package:http/http.dart' as http;

class BedRequestForm extends StatefulWidget {
  static const String routeName = '/bed_request_form';
  final Hospital hospital;

  const BedRequestForm({Key? key, required this.hospital}) : super(key: key);

  @override
  _BedRequestFormState createState() => _BedRequestFormState();
}

class _BedRequestFormState extends State<BedRequestForm> {
  final namaController = TextEditingController();
  final umurController = TextEditingController();
  final alamatController = TextEditingController();
  final telpController = TextEditingController();
  String? genderRadio = 'L';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkPrimaryColor,
        appBar: AppBar(
            backgroundColor: darkPrimaryColor,
            title: Center(
              child: Text("Bed Request", style: myTextTheme.overline),
            )),
        body: ListView(
          children: <Widget>[
            Container(
              color: darkPrimaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 40.0, bottom: 45.0),
                    child: Text(
                      "Permintaan Bed ke\n" + widget.hospital.nama,
                      style: myTextTheme.headline5,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
              ),
              child: Container(
                color: Colors.white,
                height: 700.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 30, bottom: 30),
                      child: Text(
                        "Silakan Masukkan Data",
                        style: myTextTheme.headline6,
                      ),
                    ),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: formKey,
                      child: buildForm(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    namaController.dispose();
    umurController.dispose();
    alamatController.dispose();
    telpController.dispose();
    super.dispose();
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.only(right:24.0, left:24.0),
      child: Column(
        children: <Widget> [
          TextFormField(
            controller: namaController,
            decoration: const InputDecoration(
              icon: Icon(Icons.account_box_sharp),
              border: UnderlineInputBorder(),
              labelText: "Nama",
              hintText: "Silakan Masukkan Nama Anda",
            ),
            validator: (value) {
              return value!.isEmpty ? "Mohon isi nama anda" : null;
            },
          ),
          Column(
            children: <Widget> [
              RadioListTile<String>(
                title: const Text('Laki-Laki'),
                value: 'L',
                groupValue: genderRadio,
                onChanged: (value) {
                  setState(() {
                    genderRadio = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Perempuan'),
                value: 'P',
                groupValue: genderRadio,
                onChanged: (value) {
                  setState(() {
                    genderRadio = value;
                  });
                },
              ),
            ],
          ),
          TextFormField(
              controller: umurController,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today_sharp),
              border: UnderlineInputBorder(),
              labelText: "Umur",
              hintText: "Silakan Masukkan Umur Anda",
            ),
            validator: (value) {
              if (value == null) return "Mohon isi umur anda";
              if (int.tryParse(value) == null) return "Mohon isi umur yang benar";
              var umur = int.parse(value);
              if (umur < 0) return "Mohon isi umur yang benar";
              return null;
            }
          ),
          TextFormField(
            controller: alamatController,
            decoration: const InputDecoration(
              icon: Icon(Icons.house_sharp),
              border: UnderlineInputBorder(),
              labelText: "Alamat",
              hintText: "Silakan Masukkan Alamat Tinggal Anda",
            ),
            validator: (value) {
              return value!.isEmpty ? "Mohon isi alamat anda" : null;
            },
          ),
          TextFormField(
              controller: telpController,
            decoration: const InputDecoration(
              icon: Icon(Icons.phone),
              border: UnderlineInputBorder(),
              labelText: "Telepon",
              hintText: "Silakan Masukkan Nomor Telepon Anda",
            ),
            validator: (value) {
              return value!.isEmpty ? "Mohon isi nomor telpon anda" : null;
            }
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: btnColor,
            ),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                var request = http.MultipartRequest(
                    "POST",
                    Uri.parse("https://temenin-isoman.herokuapp.com/bed-capacity/"));

                request.fields['rs_input'] = widget.hospital.pk.toString();
                request.fields['nama'] = namaController.text;
                request.fields['gender'] = genderRadio!;
                request.fields['umur'] = umurController.text;
                request.fields['alamat'] = alamatController.text;
                request.fields['telp'] = telpController.text;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Memproses Data')),
                );

                await request.send();

                Navigator.pushNamed(context, BedRequestConfirmationPage.routeName);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Bed Request Berhasil Dikirim')),
                );
              }
            },
            child: const Text('KIRIM', style: TextStyle(color: darkPrimaryColor),),
          ),
        ],
      ),
    );
  }
}
