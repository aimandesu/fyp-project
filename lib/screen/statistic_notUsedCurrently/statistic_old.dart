import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StatisticOld extends StatelessWidget {
  const StatisticOld({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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

    return Container(
      height: size.height * 0.1,
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              left: 5,
            ),
            child: Text(
              "Statistic",
              style: TextStyle(),
            ),
          ),
          Container(
            height: size.height * 0.05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Satelit"),
                Text("Radar"),
                Text("Swirl"),
              ],
            ),
          )
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
