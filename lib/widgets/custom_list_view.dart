import 'dart:convert';
import 'dart:typed_data';
import 'package:fl_componentes/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget{
  const CustomListView({
    super.key,
    required this.name,
    required this.image,
    required this.descriptions,
    this.extras,
    required this.fuente,
  });

  final String name;
  final String image;
  final String? extras;
  final List<String> descriptions;
  final Future<dynamic> fuente;

  itemBuilder(BuildContext context, int index, characters) {
    final Map character = characters[index];
    List<Text> description = [];
    for (String des in descriptions){
      description.add(Text("$des: ${getData(des, character)}"));
    }
    final List extra = character[extras];
    final Widget? imageWidget = image.isEmpty ? null : getImage(getData(image, character));
    return CustomCardType(
      image: imageWidget,
      name: getData(name, character),
      descriptions: description,
      extras: extra,
    );
  }
  
  String getData(String clave, Map data){
    List<String> claves = clave.split("/");
    if (claves.length == 1){
      return (data as Map<String, dynamic>)[clave].toString();
    }

    dynamic res = Map.from(data);
    for (int i = 0;i < claves.length; i++){
      debugPrint("res: $res,  key: ${claves[i]}");
      debugPrint("response: ${res[claves[i]].toString()}");
      res = res[claves[i]];
      if (res == null){
        return "nulo";
      }
    }
    debugPrint("res: $res");
    return res.toString();
  }

  Widget builder(context, projectSnap){
    if ((projectSnap.connectionState == ConnectionState.none &&
        projectSnap.hasData == null) ||
        projectSnap.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }else {
      final temp = projectSnap.data;
      final List character = (temp is List) ? temp : [temp];
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: character.length,
        itemBuilder: (context, index) => itemBuilder(context, index, character),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fuente,
      builder: builder
    );
  }
  Widget getImage(String data) {
    if (data.contains("data:image/jpeg;base64")){
      Uint8List imageBytes = base64Decode(data.split(',').last);
      return Image.memory(imageBytes);
    }else {
      return Image.network(
        data,
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
}
