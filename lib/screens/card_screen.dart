import 'dart:convert';

import 'package:fl_componentes/widgets/custom_card_type_1.dart';
import 'package:fl_componentes/widgets/custom_card_type_2.dart';
import 'package:fl_componentes/widgets/custom_list_view_rick_and_morty.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class CardScreen extends StatelessWidget{
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Widget"),
      ),
      body: CustomListViewRickAndMorty(),
    );
  }
}