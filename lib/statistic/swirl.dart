import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Swirl extends StatelessWidget {
  const Swirl({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}
