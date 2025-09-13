import 'package:fl_componentes/providers/rick_morty_provider.dart';
import 'package:fl_componentes/widgets/custom_list_view.dart';
import 'package:flutter/material.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
      ),
    );
  }
}
/**
 * {
    "": 1,
    "": "Earth (C-137)",
    "": "Planet",
    "": "Dimension C-137",
    "": [
    "https://rickandmortyapi.com/api/character/38",
    "https://rickandmortyapi.com/api/character/45",
    "https://rickandmortyapi.com/api/character/71",
    "https://rickandmortyapi.com/api/character/82",
    "https://rickandmortyapi.com/api/character/83",
    "https://rickandmortyapi.com/api/character/92",
    "https://rickandmortyapi.com/api/character/112",
    "https://rickandmortyapi.com/api/character/114",
    "https://rickandmortyapi.com/api/character/116",
    "https://rickandmortyapi.com/api/character/117",
    "https://rickandmortyapi.com/api/character/120",
    "https://rickandmortyapi.com/api/character/127",
    "https://rickandmortyapi.com/api/character/155",
    "https://rickandmortyapi.com/api/character/169",
    "https://rickandmortyapi.com/api/character/175",
    "https://rickandmortyapi.com/api/character/179",
    "https://rickandmortyapi.com/api/character/186",
    "https://rickandmortyapi.com/api/character/201",
    "https://rickandmortyapi.com/api/character/216",
    "https://rickandmortyapi.com/api/character/239",
    "https://rickandmortyapi.com/api/character/271",
    "https://rickandmortyapi.com/api/character/302",
    "https://rickandmortyapi.com/api/character/303",
    "https://rickandmortyapi.com/api/character/338",
    "https://rickandmortyapi.com/api/character/343",
    "https://rickandmortyapi.com/api/character/356",
    "https://rickandmortyapi.com/api/character/394"
    ],
    "": "https://rickandmortyapi.com/api/location/1",
    "": "2017-11-10T12:42:04.162Z"
    },
 */