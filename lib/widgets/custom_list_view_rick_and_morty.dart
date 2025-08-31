import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'custom_card_type_2.dart';

class CustomListViewRickAndMorty extends StatelessWidget{
  const CustomListViewRickAndMorty({super.key});

  @override
  Widget build(BuildContext context) {
    List characters =  [];

    Future getProjectDetails() async {
      final url = Uri.parse("https://rickandmortyapi.com/api/character");
      return await http.get(url);
    }

    builder(context, projectSnap){
      if (projectSnap.connectionState == ConnectionState.none &&
          projectSnap.hasData == null) {
        return Container();
      }

      final json = jsonDecode(projectSnap.data.body) as Map<String, dynamic>;
      final info = json["info"];
      final results = json["results"];
      debugPrint(info.toString());

      for (Map<String, dynamic> r in results){
        debugPrint("name: ${r["name"]}");
        debugPrint("image ${r["image"]}");

        characters.add(
          CustomCardType2(
            name: r["name"],
            imageUrl: r["image"],
          ),
        );
      }

      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          ...characters,
        ],
      );
    }

    return FutureBuilder(
      future: getProjectDetails(),
      builder: builder
    );
  }
}