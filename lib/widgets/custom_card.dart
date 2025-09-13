import 'package:fl_componentes/widgets/sub_card_of_description.dart';
import 'package:flutter/material.dart';

class CustomCardType extends StatelessWidget {
  const CustomCardType({
    super.key,
    required this.image,
    required this.name,
    required this.descriptions,
    this.extras,
  });

  final Widget? image;
  final String name;
  final List<Widget> descriptions;
  final List? extras;

  List<Widget> getExtrasList(){
    List<Widget> res = [];

    if (extras != null){
      for (var extra in extras!){
        res.add(
            Text(extra),
        );
      }
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (image != null) ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: image,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...descriptions,
                Column(
                  spacing: 10,
                  children: getExtrasList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}