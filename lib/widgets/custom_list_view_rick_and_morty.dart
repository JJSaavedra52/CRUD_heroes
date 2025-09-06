import 'package:fl_componentes/providers/rick_morty_provider.dart';
import 'package:fl_componentes/widgets/custom_card_type_rick_and_morty_type_one.dart';
import 'package:flutter/material.dart';

class CustomListViewRickAndMorty extends StatelessWidget{
  const CustomListViewRickAndMorty({super.key});

  itemBuilder(BuildContext context, int index, List characters) {
    final character = characters[index];
    return CustomCardTypeRickAndMortyTypeOne(
      image: character['image'],
      name: character['name'],
      species: character['species'],
      status: character['status'],
      gender: character['gender'],
    );
  }

  Widget builder(context, projectSnap){
    if (projectSnap.connectionState == ConnectionState.none && projectSnap.hasData == null) {
      return const Center(child: CircularProgressIndicator());
    }else {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: projectSnap.data.length,
        itemBuilder: (context, index) => itemBuilder(context, index, projectSnap.data),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RickMortyProvider.getOnDisplayCharacters(),
      builder: builder
    );
  }
}