import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Bubble extends StatefulWidget {
  const Bubble({
    required this.message,
    required this.isUser,
    super.key,
    this.picture,
    this.location,
  });

  final String message;
  final bool isUser;
  final List<dynamic>? picture;
  final GeoPoint? location;

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  final Set<Marker> markers = <Marker>{};
  CameraPosition? currentPlex;

  @override
  void didChangeDependencies() {
    bool isInit = true;
    if (isInit) {
      if (widget.picture == null && widget.location != null) {
        currentPlex = CameraPosition(
          target: LatLng(widget.location!.latitude, widget.location!.longitude),
          zoom: 14,
        );
        String markerId = "location";
        markers.add(
          Marker(
            markerId: MarkerId('marker$markerId'),
            // infoWindow: const InfoWindow(title: "From Json Marker"),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position:
                LatLng(widget.location!.latitude, widget.location!.longitude),
          ),
        );
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              widget.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: widget.isUser
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: !widget.isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomRight: widget.isUser
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                ),
              ),
              width: kIsWeb
                  ? widget.message.length > 70
                      ? size.width * 0.6
                      : null
                  : widget.message.length > 48
                      ? size.width * 0.8
                      : null,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
              child: widget.picture == null && widget.location == null
                  ? Text(widget.message, textAlign: TextAlign.start)
                  : widget.picture != null && widget.location == null
                      ? Column(
                          children: [
                            Text(widget.message, textAlign: TextAlign.start),
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: ListView.builder(
                                itemCount: widget.picture!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Image.network(
                                    widget.picture![index].toString(),
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 300,
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.message),
                              Text(
                                  "${widget.location!.latitude},${widget.location!.longitude}"),
                              Expanded(
                                child: GoogleMap(
                                  mapType: MapType.normal,
                                  markers: markers,
                                  zoomControlsEnabled: false,
                                  initialCameraPosition:
                                      currentPlex as CameraPosition,
                                  onMapCreated:
                                      (GoogleMapController controllers) {
                                    controller.complete(controllers);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ],
    );
  }
}
