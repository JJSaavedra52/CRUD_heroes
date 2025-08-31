import 'package:flutter/material.dart';

class AlertScreen extends StatelessWidget{
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alert"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text("Alert"),
      ),
    );
  }
}