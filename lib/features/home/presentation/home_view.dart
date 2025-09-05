import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:near_by/features/home/presentation/widgets/bottom_sheet_wrapper.dart';
import 'package:near_by/features/home/presentation/widgets/drawer_view.dart';
import 'package:near_by/features/home/presentation/widgets/fab_buttons.dart';
import 'package:near_by/features/home/presentation/widgets/map_widget.dart';
import 'package:near_by/features/home/presentation/widgets/search_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  LatLng? currentPosition;
  GoogleMapController? mapController;
  double _sheetCurrentSize = 0.16;
  String? _address;

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

  @override
  void initState() {
    super.initState();
    _initLocationFlow();
  }

  Future<void> _initLocationFlow() async {
    await requestLocationPermission();
    await _fetchLocation();
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
          _address =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() => _address = "Unable to get address");
    }
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }
  }

  double _calculateFABOpacity() {
    const double fabFadeStart = 0.7;
    const double fabFadeEnd = 1.0;
    double fabOpacity =
        1.0 -
            ((_sheetCurrentSize - fabFadeStart) / (fabFadeEnd - fabFadeStart));
    return fabOpacity.clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      // 👇 Add the drawer here
      drawer: const DrawerView(),

      body: Stack(
        children: [
          // Map widget
          MapWidget(
            currentPosition: currentPosition,
            onMapCreated: (controller) => mapController = controller,
          ),

          // Search & Category Header
          SearchHeader(
            categories: categories,
            sheetCurrentSize: _sheetCurrentSize,
          ),

          // FABs
          FABButtons(
            opacity: _calculateFABOpacity(),
            bottomOffset: mediaQuery.size.height * _sheetCurrentSize + 16,
            onPressed: () async {
              Position position = await Geolocator.getCurrentPosition();
              mapController?.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(position.latitude, position.longitude),
                ),
              );
            },
          ),

          // Bottom Sheet
          BottomSheetWrapper(
            sheetCurrentSize: _sheetCurrentSize,
            onSizeChange: (val) => setState(() => _sheetCurrentSize = val),
            currentPosition: currentPosition,
            address: _address,
          ),
        ],
      ),
    );
  }
}
