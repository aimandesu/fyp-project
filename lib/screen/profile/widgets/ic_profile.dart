import 'package:flutter/material.dart';

class IcProfile extends StatelessWidget {
  const IcProfile({
    required this.image,
    super.key,
  });

  final Map<String, dynamic> image;

  @override
  Widget build(BuildContext context) {
    List<dynamic> keys = image.keys.toList();
    List<dynamic> values = image.values.toList();

    return PageView.builder(
      itemCount: image.length,
      itemBuilder: (context, index) {
        return identificationCard(keys[index], values[index]);
      },
    );
  }

  Container identificationCard(
    String position,
    String imageUrl,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(position == 'back' ? "Belakang" : "Depan"),
          Expanded(
            child: SizedBox(
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
