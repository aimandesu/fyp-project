import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    Future<Map<String, dynamic>> testData() async {
      final response = await http.get(
          Uri.parse(
            // "https://api.met.gov.my/v2/data?datasetid=FORECAST&datacategoryid=GENERAL&locationid=LOCATION:237&start_date=2023-04-30&end_date=2023-04-30",
            // "https://api.met.gov.my/v2.1/locations?locationcategoryid=TOWN",
            // "https://api.met.gov.my/v2.1/data?datasetid=FORECAST&datacategoryid=MARINE&locationid=LOCATION:501&start_date=2023-04-30&end_date=2023-04-30",
            "https://api.met.gov.my/v2.1/data?datasetid=WARNING&datacategoryid=WINDSEA2&start_date=2023-04-30&end_date=2023-04-30",
          ),
          headers: {
            // 'Content-Type': 'application/json',
            // 'Accept': 'application/json',
            'Authorization': 'METToken defab7176081f12d108c800a6688e32a3ee9f7c7'
          });
      // final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print(extractedData);
      // print(extractedData['results'][1]['id']);
      print(extractedData);
      return extractedData;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          InteractiveViewer(
            // panEnabled: false, // Set it to false
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 1,
            maxScale: 2,
            child: CachedNetworkImage(
              imageUrl:
                  "https://api.met.gov.my/static/images/satelit-latest.gif",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          InteractiveViewer(
            // panEnabled: false, // Set it to false
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 1,
            maxScale: 2,
            child: CachedNetworkImage(
              imageUrl: "https://api.met.gov.my/static/images/radar-latest.gif",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          InteractiveViewer(
            // panEnabled: false, // Set it to false
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 1,
            maxScale: 2,
            child: CachedNetworkImage(
              imageUrl: "https://api.met.gov.my/static/images/swirl-latest.gif",
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );

    // TextButton(onPressed: testData, child: Text("Test"));

    //     FutureBuilder(
    //   future: testData(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       return ListView.builder(
    //         itemCount: snapshot.data!['metadata']['resultset']['limit'],
    //         itemBuilder: (context, index) {
    //           return Row(
    //             children: [
    //               Text(index.toString()),
    //               Text(snapshot.data!['results'][index]['name'].toString())
    //             ],
    //           );
    //         },
    //       );
    //     } else if (snapshot.hasError) {
    //       return Text('${snapshot.error}');
    //     } else {
    //       return Text("no data");
    //     }
    //   },
    // );
  }
}
