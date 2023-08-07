import 'package:flutter/material.dart';

import 'package:fyp_project/models/user_model.dart';
import 'package:fyp_project/providers/maps.dart';

class Camera extends StatelessWidget {
  const Camera({super.key});

  @override
  Widget build(BuildContext context) {
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var addressController = TextEditingController();

    void clearTextFields() {
      firstNameController.clear();
      lastNameController.clear();
      addressController.clear();
    }

    // Future<void> insertData(
    //   String firstName,
    //   String lastName,
    //   String address,
    // ) async {
    //   var id = mongo.ObjectId();
    //   final data = UserModel(
    //     id: id,
    //     firstName: firstName,
    //     lastName: lastName,
    //     address: address,
    //   );
    //   var result = await MongoDB.insert(data);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(result),
    //     ),
    //   );
    //   clearTextFields();
    // }

    // Widget displayCard(UserModel data) {
    //   return Card(
    //     child: Column(
    //       children: [
    //         Text(data.id.$oid.toString()),
    //         Text(data.firstName.toString()),
    //         Text(data.lastName.toString()),
    //         Text(data.address.toString()),
    //       ],
    //     ),
    //   );
    // }

    return Column(
      children: [
        TextField(
          controller: firstNameController,
          decoration: const InputDecoration(labelText: "First Name"),
        ),
        TextField(
          controller: lastNameController,
          decoration: const InputDecoration(labelText: "Last Name"),
        ),
        TextField(
          controller: addressController,
          decoration: const InputDecoration(labelText: "Address"),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     insertData(
        //       firstNameController.text,
        //       lastNameController.text,
        //       addressController.text,
        //     );
        //   },
        //   child: Text("submit"),
        // ),
        // Container(
        //   child: FutureBuilder(
        //     future: MongoDB.getData(),
        //     builder: (context, AsyncSnapshot snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       } else {
        //         if (snapshot.hasData) {
        //           return Container(
        //             height: 300,
        //             child: ListView.builder(
        //               itemCount: snapshot.data.length,
        //               itemBuilder: (context, index) {
        //                 return displayCard(
        //                   UserModel.fromJson(
        //                     snapshot.data[index],
        //                   ),
        //                 );
        //               },
        //             ),
        //           );
        //         } else {
        //           return Text("no data");
        //         }
        //       }
        //     },
        //   ),
        // ),
        // IconButton(
        //   onPressed: () {
        //     Maps().listPlaces("Kinta", "Ipoh");
        //   },
        //   icon: const Icon(Icons.abc),
        // ),
        // IconButton(
        //   onPressed: () {
        //     Maps().findSpecificPlace("Kinta", "Ipoh");
        //   },
        //   icon: const Icon(Icons.offline_bolt),
        // )
      ],
    );
  }
}
