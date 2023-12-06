import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/screen/help_centre/widgets/map_location.dart';
import 'package:http/http.dart' as http;

class MapCentre extends StatefulWidget {
  const MapCentre({super.key});

  @override
  State<MapCentre> createState() => _MapCentreState();
}

class _MapCentreState extends State<MapCentre> {
  final TextEditingController _searchController = TextEditingController();

  void getLocation(String query) async {
    final response =
        await http.get(Uri.parse("http://localhost:3000/api/maps/$query"));
    final json = jsonDecode(response.body);
    print(json);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          width: size.width * 0.6,
          height: size.height * 0.8,
          margin: marginDefined,
          padding: const EdgeInsets.all(20),
          decoration: decorationDefinedShadow(
              Theme.of(context).colorScheme.onPrimary, 25),
          child: const MapLocation(),
        ),
        Expanded(
          child: Container(
            height: size.height * 0.4,
            margin: marginDefined,
            padding: paddingDefined,
            decoration: decorationDefinedShadow(
                Theme.of(context).colorScheme.onPrimary, 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Tambah Pusat Bantuan",
                  style: textStyling30,
                ),
                Container(
                  width: 200,
                  padding: paddingDefined,
                  decoration: decorationDefinedShadow(
                      Theme.of(context).colorScheme.onPrimary, 25),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    getLocation(_searchController.text);
                  },
                  child: const Text("Search Place"),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
