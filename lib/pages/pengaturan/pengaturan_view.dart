import 'package:flutter/material.dart';

class PengaturanView extends StatefulWidget {
  const PengaturanView({super.key});

  @override
  State<PengaturanView> createState() => _PengaturanViewState();
}

class _PengaturanViewState extends State<PengaturanView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [Text("Pengaturan View")]));
  }
}
