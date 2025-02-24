
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seth/core/widgets/custom_button.dart';

import '../../../../controllers/user/user_event_controller.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';

class EventsInYourAreScreen extends StatefulWidget {
  final String title;
  const EventsInYourAreScreen({super.key, required this.title});

  @override
  State<EventsInYourAreScreen> createState() => _GetLocationState();
}

class _GetLocationState extends State<EventsInYourAreScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  UserEventController userEventController = Get.put(UserEventController());

  Position? _currentPosition;
  final Set<Marker> _markers = {};
  LatLng? _selectedLocation;
  final TextEditingController _locationController = TextEditingController();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(51.5074, -0.1278),
    zoom: 14.0,
  );

  // Constants for text and error messages
  static const String locationPermissionDenied = 'Location permission is denied.';
  static const String locationPermissionDeniedForever = 'Location permission is permanently denied.';
  static const String locationServicesDisabled = 'Location services are disabled.';
  static const String pleaseSelectLocation = 'Please select a location on the map';
  static const String failedToRetrieveAddress = 'Failed to retrieve address';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _checkGeocodingPlugin(); // Check if the geocoding plugin is registered
  }


  Future<void> _checkGeocodingPlugin() async {
    const MethodChannel channel = MethodChannel('flutter.baseflow.com/geocoding');
    try {
      final List<dynamic> plugins = await channel.invokeMethod('getPlugins');
      print('Registered plugins: $plugins');
    } on PlatformException catch (e) {
      print('Failed to get plugins: ${e.message}');
    }
  }


  Future<void> _getCurrentLocation() async {
    // Check if location services are enabled
    if (!await Geolocator.isLocationServiceEnabled()) {
      // Show alert dialog if location services are disabled
      _showLocationServicesDialog();
      return;
    }

    // Check location permissions using `permission_handler`
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      // Request permission
      status = await Permission.location.request();
      if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission is denied.')),
        );
        return;
      }
    }

    if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permission is permanently denied.')),
      );
      openAppSettings(); // Open app settings to grant permissions
      return;
    }

    // If permission is granted, get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;

      // Add marker at current location
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: 'You are here'),
        ),
      );
    });

    _goToCurrentLocation();
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    if (_currentPosition != null) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 14.0,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  Future<String?> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.locality}, ${place.country}'; // Customize as per your requirement
      }
    } catch (e) {
      print('Error getting address from coordinates: $e');
    }
    return null;
  }

  void _onMapTapped(LatLng location) async {
    String? address = await _getAddressFromLatLng(location);

    List<Placemark> placemarks = await placemarkFromCoordinates(location.latitude, location.longitude);
    Placemark place = placemarks.first;

    // ✅ Badda, Dhaka নেওয়ার জন্য
    String formattedAddress = "${place.subLocality}, ${place.locality}, ${place.country}";

    setState(() {
      _selectedLocation = location;
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: location,
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      );
      if (address != null) {
        _locationController.text = formattedAddress;
      }
    });
  }

  @override
  void dispose() {
    userEventController.events.clear();
    _locationController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,


      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "${widget.title}", fontsize: 20.h),
      ),


      body: Column(
        children: [


          SizedBox(
            height: 530.h,
            child: Stack(
              children: [


                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _initialPosition,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  padding: EdgeInsets.only(top: 300.h),
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    controller.setMapStyle(_nightModeStyle); // Apply Dark Mode
                  },
                  onTap: _onMapTapped,
                ),


                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
                  child: CustomTextField(
                    controller: _locationController,
                    hintText: 'Search Location',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _searchLocation();
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ),

              ],
            ),
          ),


          SizedBox(height: 80.h),


          CustomButton(

              title: widget.title == "Select you location" ? "Go Back" : "Get Events",
              onpress: (){
                if(widget.title == "Select you location"){
                  Navigator.pop(context, {
                    "lat" : _selectedLocation?.latitude.toString(),
                    "log" : _selectedLocation?.longitude.toString(),
                    "address" : _locationController.text,
                  });
                }else{
                  userEventController.fetchEvent(
                      category: "",
                      lat: _selectedLocation?.latitude.toString() ?? "",
                      log: _selectedLocation?.longitude.toString() ?? ""
                  );
                  context.pop();
                }

          })
        ],
      ),
    );
  }

  Future<void> _searchLocation() async {
    if (_locationController.text.isNotEmpty) {
      try {
        List<Location> locations = await locationFromAddress(_locationController.text);
        print("==========================fro address : $locations");
        if (locations.isNotEmpty) {
          LatLng searchedLocation =
          LatLng(locations[0].latitude, locations[0].longitude);

          final GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newLatLng(searchedLocation));

          setState(() {
            _markers.clear();
            _markers.add(Marker(
              markerId: const MarkerId('searchedLocation'),
              position: searchedLocation,
              infoWindow: InfoWindow(title: _locationController.text),
            ));
            _selectedLocation = searchedLocation;
          });
        }
      } catch (e, s) {
        print("-----------------------'$s");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location not found')),
        );
      }
    }
  }

  void _showLocationServicesDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Location Services Disabled'),
          content: const Text('Please enable location services to continue.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                await Geolocator.openLocationSettings(); // Open location settings
              },
              child: const Text('Turn On'),
            ),
          ],
        );
      },
    );
  }
}
const String _nightModeStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8ec3b9"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1a3646"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#4b6878"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#64779e"
      }
    ]
  },
  {
    "featureType": "landscape.man_made",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#334e87"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#283d6a"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6f9ba5"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#304a7d"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#98a5be"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2c6675"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#255763"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#b0d5ce"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#023e58"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#98a5be"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1d2c4d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#0e1626"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#4e6d70"
      }
    ]
  }
]
''';
