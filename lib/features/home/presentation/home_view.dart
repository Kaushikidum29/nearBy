import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:near_by/features/search/presentation/search_page.dart';
import 'package:near_by/features/search/presentation/widgets/category_list.dart';
import 'package:near_by/features/search/presentation/widgets/floating_action_buttons.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LatLng? currentPosition;
  GoogleMapController? mapController;

  final List<Map<String, String>> categories = [
    {'name': 'Restaurants', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Petrol', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Hotels', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Coffee', 'image': 'https://via.placeholder.com/150'},
    {'name': 'ATMs', 'image': 'https://via.placeholder.com/150'},
    {
      'name': 'Shopping',
      'image':
      'https://static.vecteezy.com/system/resources/previews/009/157/893/non_2x/shopping-cart-set-of-shopping-cart-icon-on-white-background-shopping-cart-icon-shopping-cart-design-shopping-cart-icon-sign-shopping-cart-icon-isolated-shopping-cart-symbol-free-vector.jpg',
    },
    {
      'name': 'Hospitals & Clinics',
      'image':
      'https://img.freepik.com/premium-vector/hospital-icon-vector-illustration_910989-3524.jpg?semt=ais_hybrid&w=740',
    },
    {'name': 'More', 'image': 'https://via.placeholder.com/150'},
  ];

  // Track current size (extent) of the bottom sheet (from 0.16 to 1.0)
  double _sheetCurrentSize = 0.16;
  String? _address; // add in your _HomeViewState class


  @override
  void initState() {
    super.initState();
    _initLocationFlow();
  }

  Future<void> _initLocationFlow() async {
    await requestLocationPermission(); // Ask permission
    await _fetchLocation();            // Get current location
  }

  Future<void> _fetchLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _address = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        _address = "Unable to get address";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    // Define animation ranges for smooth fade
    const double headerFadeStart = 0.16; // initial bottom sheet size
    const double headerFadeEnd = 0.4;    // fully hidden header

    // Calculate header opacity: fades out from 1 to 0 as sheet grows within range
    double headerOpacity =
        1.0 - ((_sheetCurrentSize - headerFadeStart) / (headerFadeEnd - headerFadeStart));
    headerOpacity = headerOpacity.clamp(0.0, 1.0);

    // FAB fades out starting from 0.7 to 1.0 of sheet extent
    const double fabFadeStart = 0.7;
    const double fabFadeEnd = 1.0;
    double fabOpacity =
        1.0 - ((_sheetCurrentSize - fabFadeStart) / (fabFadeEnd - fabFadeStart));
    fabOpacity = fabOpacity.clamp(0.0, 1.0);

    return Scaffold(
      body: Stack(
        children: [
          // 🗺️ Map background
          currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: currentPosition!,
              zoom: 15,
            ),
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            onMapCreated: (controller) => mapController = controller,
          ),

          // 🔍 Search bar and categories with smooth opacity
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: AnimatedOpacity(
                opacity: headerOpacity,
                duration: const Duration(milliseconds: 250),
                child: IgnorePointer(
                  ignoring: headerOpacity == 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 10.0),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35.0),
                          border: Border.all(color: Colors.grey.shade300),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.blueGrey,
                              size: 30,
                            ),
                            const SizedBox(width: 8),
                             Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => SearchPage()),
                                  );
                                },
                                child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Search here...',
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.mic, color: Colors.grey),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            const CircleAvatar(
                              radius: 14,
                              backgroundImage: NetworkImage(
                                'https://example.com/profile.jpg',
                              ),
                            ),
                          ],
                        ),
                      ),
                      CategoryList(items: categories),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 🟢 Floating Action Buttons with smooth opacity, hides near full sheet
          Positioned(
            bottom: mediaQuery.size.height * _sheetCurrentSize + 16,
            right: 16,
            child: AnimatedOpacity(
              opacity: fabOpacity,
              duration: const Duration(milliseconds: 250),
              child: IgnorePointer(
                ignoring: fabOpacity == 0,
                child: FloatingActionButtons(
                  callBack: () async {
                    Position position = await Geolocator.getCurrentPosition();
                    mapController?.animateCamera(
                      CameraUpdate.newLatLng(
                        LatLng(position.latitude, position.longitude),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // 📥 Draggable Bottom Sheet which can expand fully
          DraggableScrollableSheet(
            initialChildSize: 0.16,
            minChildSize: 0.16,
            maxChildSize: 1.0, // full screen allowed
            builder: (_, scrollController) {
              return NotificationListener<DraggableScrollableNotification>(
                onNotification: (notification) {
                  setState(() {
                    _sheetCurrentSize = notification.extent;
                  });
                  return false;
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -4),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: currentPosition == null
                      ? const Text("Getting location...")
                      : ListView(
                    controller: scrollController,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const Text(
                        "Your Current Location:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _address??"", style: const TextStyle(fontSize: 14),
                      ),
                      // additional content can be added here
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
  }
}
