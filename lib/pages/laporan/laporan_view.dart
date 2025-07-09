import 'package:flutter/material.dart';

class LaporanView extends StatefulWidget {
  const LaporanView({super.key});

  @override
  State<LaporanView> createState() => _LaporanViewState();
}

class _LaporanViewState extends State<LaporanView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [Text("Laporan View")]));
  }
}
