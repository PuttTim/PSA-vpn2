import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:portfix_mobile/data/engineer/engineer_repository.dart';
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
  final EquipmentRepository _equipmentRepo = EquipmentRepository.getInstance();
  final EngineerRepository _engineerRepo = EngineerRepository.getInstance();
  GoogleMapController? _controller;
  String? name;

  Map<int, String> priorityMap = {
    1: "Low",
    2: "Medium",
    3: "High",
  };

  @override
  void initState() {
    super.initState();
    (() async {
      darkMode = await rootBundle.loadString(
        'assets/map_styles/dark_mode.json',
      );
      if (widget.taskModel.status == Status.inProgress) {
        var engineer = await _engineerRepo.getEngineerById(
          widget.taskModel.engineerId!,
        );
        setState(() {
          name = engineer.name;
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskModel.title),
        elevation: 0,
        backgroundColor: CustomTheme.primary,
      ),
      body: FutureBuilder<EquipmentModel>(
        future: _equipmentRepo.getEquipmentById(
          widget.taskModel.equipmentId,
        ),
        builder: (context, equipmentSnapshot) {
          if (equipmentSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var location = LatLng(
            equipmentSnapshot.data!.geoPoint.latitude,
            equipmentSnapshot.data!.geoPoint.longitude,
          );
          return SingleChildScrollView(
            child: Column(
              children: [
                googleMap(
                  width,
                  location,
                  equipmentSnapshot,
                  context,
                ),
                const SizedBox(height: 5),
                card(
                  context,
                  "Priority",
                  priorityMap[widget.taskModel.priority]!,
                  double.infinity,
                ),
                Row(
                  children: [
                    card(
                      context,
                      "Due Date",
                      DateFormat('dd MMM y')
                          .format(widget.taskModel.dueDate.toDate())
                          .toString(),
                      (width / 2) - 28,
                    ),
                    card(
                      context,
                      "Status",
                      widget.taskModel.status,
                      (width / 2) - 28,
                    ),
                  ],
                ),
                Visibility(
                  visible: name != null,
                  child: card(
                    context,
                    "Assigned To",
                    name ?? "",
                    double.infinity,
                    true,
                  ),
                ),
                card(
                  context,
                  "Description",
                  widget.taskModel.description,
                  double.infinity,
                  true,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {},
                    child: const Text("I will be doing this!"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Padding card(
    BuildContext context,
    String title,
    String content,
    double width, [
    bool isDescription = false,
  ]) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 1,
      ),
      child: Card(
        color: Theme.of(context).colorScheme.primary.withAlpha(70),
        child: Container(
          width: width,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isDescription
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }

  Widget googleMap(
    double width,
    LatLng location,
    AsyncSnapshot<EquipmentModel> snapshot,
    BuildContext context,
  ) {
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
            markerId: MarkerId(snapshot.data!.id),
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
