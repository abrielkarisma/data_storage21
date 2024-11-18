import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SqfLiteEx extends StatefulWidget {
  const SqfLiteEx({super.key});

  @override
  State<SqfLiteEx> createState() => _SqfLiteExState();
}

class _SqfLiteExState extends State<SqfLiteEx> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [Text("Akay")]),
      ),
    );
  }
}
