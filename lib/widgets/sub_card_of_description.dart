import 'package:flutter/material.dart';

class SubCardOfDescription extends StatelessWidget{
  const SubCardOfDescription({
    super.key,
    required this.characterString,
  });

  final String characterString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(characterString),
      ],
    );
  }

}