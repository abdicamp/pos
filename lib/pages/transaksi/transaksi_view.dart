import 'package:flutter/material.dart';

class TransaksiView extends StatefulWidget {
  const TransaksiView({super.key});

  @override
  State<TransaksiView> createState() => _TransaksiViewState();
}

class _TransaksiViewState extends State<TransaksiView> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(children: [Text("Transaksi View")]));
  }
}
