import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPlacePage extends StatefulWidget {
  const AddNewPlacePage({super.key});

  @override
  State<AddNewPlacePage> createState() => _AddNewPlacePageState();
}

class _AddNewPlacePageState extends State<AddNewPlacePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final List<File> images = [];
  LatLng? selectedLocation;
  GoogleMapController? mapController;

  final _formKey = GlobalKey<FormState>();

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => images.add(File(pickedFile.path)));
    }
  }

  Future<void> getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition();
    setState(() {
      selectedLocation = LatLng(position.latitude, position.longitude);
      mapController?.animateCamera(CameraUpdate.newLatLng(selectedLocation!));
    });
  }

  void savePlace() {
    if (_formKey.currentState?.validate() != true) return;

    Fluttertoast.showToast(
      msg: "Your place has been submitted. Admin will approve it.",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Add New Place",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan.shade800,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Place Name",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Sunset Point',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Place name is required'
                    : null,
              ),

              const SizedBox(height: 16),
              const Text(
                "Place Description",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: descController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write about the place',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Description is required'
                    : null,
              ),

              const SizedBox(height: 16),
              const Text(
                "Place Images",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ...images.map(
                    (file) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        file,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.add_a_photo, color: Colors.grey),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Select Location",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  ElevatedButton.icon(
                    onPressed: getCurrentLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan.shade800,
                    ),
                    icon: const Icon(Icons.my_location, color: Colors.white),
                    label: const Text(
                      "Use My Location",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(20.5937, 78.9629),
                    zoom: 4,
                  ),
                  onMapCreated: (controller) => mapController = controller,
                  onTap: (pos) => setState(() => selectedLocation = pos),
                  markers: selectedLocation == null
                      ? {}
                      : {
                          Marker(
                            markerId: const MarkerId('selected'),
                            position: selectedLocation!,
                          ),
                        },
                ),
              ),

              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: savePlace,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan.shade800,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Save Place",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
