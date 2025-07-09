import 'package:flutter/material.dart';

class PenggunaView extends StatefulWidget {
  const PenggunaView({super.key});

  @override
  State<PenggunaView> createState() => _PenggunaViewState();
}

class _PenggunaViewState extends State<PenggunaView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [Text("Pengguna View")]));
  }
}
