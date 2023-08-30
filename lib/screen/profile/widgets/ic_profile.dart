import 'package:flutter/material.dart';

import 'package:fyp_project/responsive_layout_controller.dart';

class IcProfile extends StatelessWidget {
  const IcProfile({
    required this.image,
    super.key,
  });

  final Map<String, dynamic> image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final isTablet = ResponsiveLayoutController.isTablet(context);
    List<dynamic> keys = image.keys.toList();
    List<dynamic> values = image.values.toList();

    return SizedBox(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: isTablet ? size.width * 0.6 : size.width * 1,
            padding: const EdgeInsets.all(8),
            child:
                // FutureBuilder(
                //     future: Provider.of<ProfileProvider>(context, listen: false)
                //         .fetchOwnProfile(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Container();
                //       } else {
                //         if (snapshot.hasData) {
                //           // final image = snapshot.data!['identificationImage'];
                //           List<dynamic> keys = image.keys.toList();
                //           List<dynamic> values = image.values.toList();
                //           return

                PageView.builder(
              itemCount: image.length,
              itemBuilder: (context, index) {
                // print(snapshot.data!['identificationImage'][0]);
                // return Text("data");
                return identifactionCard(
                    isTablet, size, keys[index], values[index]);
              },
            ),

            //     } else {
            //       return const Text("no data");
            //     }
            //   }
            // }),
          )

          // Row(
          //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     identifactionCard(isTablet, size, "Front IC",
          //         "https://images.mein-mmo.de/medien/2021/07/ayakatitel.jpg"),
          //     identifactionCard(isTablet, size, "Back IC",
          //         "https://moewalls.com/wp-content/uploads/2022/08/ayaka-genshin-impact-thumb.jpg"),

          //   ],
          // ),
          ),
    );
  }

  Container identifactionCard(
    bool isTablet,
    Size size,
    String position,
    String imageUrl,
  ) {
    return Container(
      // color: Colors.red,
      width: isTablet ? size.width * 0.6 : size.width * 1,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(position),
          Expanded(
            child: SizedBox(
              // width: size.width * 1,
              child: Center(
                child: Image.network(
                  imageUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// Container(
//   // color: Colors.blue,
//   width: isTablet ? size.width * 0.6 : size.width * 1,
//   padding: const EdgeInsets.all(8),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       const Text(""),
//       Expanded(
//         child: SizedBox(
//           // width: size.width * 1,
//           child: Center(
//             child: Image.network(
//               "",
//               loadingBuilder: (context, child, loadingProgress) {
//                 if (loadingProgress == null) {
//                   return child;
//                 }
//                 return Center(
//                   child: CircularProgressIndicator(
//                     value: loadingProgress.expectedTotalBytes !=
//                             null
//                         ? loadingProgress.cumulativeBytesLoaded /
//                             loadingProgress.expectedTotalBytes!
//                         : null,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       )
//     ],
//   ),
// ),
