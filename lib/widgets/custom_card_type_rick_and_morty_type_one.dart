import 'package:flutter/material.dart';

class CustomCardTypeRickAndMortyTypeOne extends StatelessWidget {
  const CustomCardTypeRickAndMortyTypeOne({
    super.key,
    required this.image,
    required this.name,
    required this.species,
    required this.status,
    required this.gender
  });

  final String image;
  final String name;
  final String species;
  final String status;
  final String gender;

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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: Image.network(
              image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
                Text('Species: $species'),
                Text('Status: $status'),
                Text('Gender: $gender'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}