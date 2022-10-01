import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:portfix_mobile/data/equipment/equipment_model.dart';
import 'package:portfix_mobile/data/equipment/equipment_repository.dart';
import 'package:portfix_mobile/data/tasks/task_model.dart';
import 'package:portfix_mobile/ui/theme.dart';

class DetailsScreen extends StatefulWidget {
  final TaskModel taskModel;
  const DetailsScreen({Key? key, required this.taskModel}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String darkMode = "";
  final EquipmentRepository _equipmentRepository =
      EquipmentRepository.getInstance();
  GoogleMapController? _controller;

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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details of Task"),
        elevation: 0,
        backgroundColor: CustomTheme.primary,
      ),
      body: FutureBuilder<EquipmentModel>(
        future: _equipmentRepository.getEquipmentById(
          widget.taskModel.equipmentId,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var location = LatLng(
            snapshot.data!.geoPoint.latitude,
            snapshot.data!.geoPoint.longitude,
          );
          return Column(
            children: [
              SizedBox(
                width: width,
                height: width,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: location,
                    zoom: 16,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(snapshot.data!.id),
                      position: location,
                    ),
                  },
                  onMapCreated: (googleMapController) {
                    _controller = googleMapController;
                    _controller?.setMapStyle(
                      Theme.of(context).brightness == Brightness.dark
                          ? darkMode
                          : null,
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
