import 'package:flutter/material.dart';
import 'package:tesla_controller/pages/home.dart';

void main() {
  runApp(new ConduitApp());
}

class ConduitApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Conduit',
      color: Colors.red,
      home: new HomePage('Conduit'),
    );
  }
}