import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fyp_project/constant.dart';
import 'package:fyp_project/screen/help_centre/widgets/map_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../places_tutorial/location_service.dart';

class MapCentre extends StatefulWidget {
  const MapCentre({super.key});

  @override
  State<MapCentre> createState() => _MapCentreState();
}

class _MapCentreState extends State<MapCentre> {
  final TextEditingController _searchController = TextEditingController();

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
            height: size.height * 0.8,
            margin: marginDefined,
            padding: paddingDefined,
            decoration: decorationDefinedShadow(
                Theme.of(context).colorScheme.onPrimary, 25),
            child: Column(
              children: [
                const Text("Tambah Pusat Bantuan"),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _searchController,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var place = await LocationService().getPlace(
                            _searchController.text,
                          );
                          print(place);
                        },
                        child: const Text("Search Place"))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
