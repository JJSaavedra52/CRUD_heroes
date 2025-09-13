import 'package:fl_componentes/providers/providers.dart';
import 'package:fl_componentes/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty Episodes')),
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
