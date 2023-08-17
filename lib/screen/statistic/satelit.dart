import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Satelit extends StatelessWidget {
  const Satelit({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Satelit"),
        InteractiveViewer(
          // panEnabled: false, // Set it to false
          boundaryMargin: const EdgeInsets.all(100),
          minScale: 1,
          maxScale: 2,
          child: CachedNetworkImage(
            imageUrl: "https://api.met.gov.my/static/images/satelit-latest.gif",
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        const Text("Description"),
      ],
    );
  }
}
