import 'package:fl_componentes/providers/providers.dart';
import 'package:fl_componentes/widgets/widgets.dart';
import 'package:flutter/material.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty Locations')),
      body: CustomListView(
        fuente: RickMortyProvider.getOnDisplayLocations(),
        image: '',
        name: 'name',
        descriptions: [
          'id',
          'type',
          'dimension',
          'url',
          'created',
        ],
        extras: 'residents',
      ),
    );
  }
}