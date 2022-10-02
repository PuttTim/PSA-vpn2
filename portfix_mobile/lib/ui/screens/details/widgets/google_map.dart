import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:portfix_mobile/data/equipment/equipment_model.dart';

class MapWidget extends StatefulWidget {
  final EquipmentModel equipmentModel;
  const MapWidget({
    Key? key,
    required this.equipmentModel,
  }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _controller;
  String darkMode = "";

  @override
  void initState() {
    super.initState();
    (() async {
      darkMode = await rootBundle.loadString(
        'assets/map_styles/dark_mode.json',
      );
    })();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var location = LatLng(
      widget.equipmentModel.geoPoint.latitude,
      widget.equipmentModel.geoPoint.longitude,
    );

    return SizedBox(
      width: width,
      height: width,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: location,
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: MarkerId(widget.equipmentModel.id),
            position: location,
          ),
        },
        onMapCreated: (googleMapController) {
          _controller = googleMapController;
          _controller?.setMapStyle(
            Theme.of(context).brightness == Brightness.dark ? darkMode : null,
          );
        },
      ),
    );
  }
}
