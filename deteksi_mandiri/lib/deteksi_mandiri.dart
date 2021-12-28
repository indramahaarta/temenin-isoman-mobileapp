library deteksi_mandiri;

import 'package:flutter/material.dart';
import 'package:deteksi_mandiri/screens/main_page.dart';

class DeteksiMandiri extends StatelessWidget {
  static const routeName = '/deteksi-mandiri';

  const DeteksiMandiri({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}
