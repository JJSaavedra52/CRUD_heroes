import 'package:fl_componentes/providers/providers.dart';
import 'package:flutter/material.dart';

class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  List<dynamic> locations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    final data = await RickMortyProvider.getOnDisplayLocations();
    setState(() {
      locations = data.take(10).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty Episodes')),
      body: /*isLoading
          ? */const Center(child: CircularProgressIndicator())/*
          : CustomListView(
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
      ),*/
    );
  }
}
