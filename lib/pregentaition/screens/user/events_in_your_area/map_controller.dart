import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';

import '../../../../core/utils/app_colors.dart';


class MapController extends GetxController {

  final Completer<GoogleMapController> mapController = Completer();
  final RxSet<Marker> markers = <Marker>{}.obs;
  final Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  final RxString searchAddress = ''.obs;
  Position? currentPosition;

  static const CameraPosition initialPosition = CameraPosition(
    target: LatLng(-6.2088, 106.8456),
    zoom: 14.0,
  );

  @override
  void onInit() {
    super.onInit();
    checkLocationPermission();
    // fetchShowerLocations();
  }

  Future<void> checkLocationPermission() async {
    if (await Permission.location
        .request()
        .isGranted) {
      await _getCurrentLocation();
      // fetchShowerLocations();
    } else {
      Get.snackbar(
        'Permission Denied',
        'Location permission is required to use this feature.',
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    markers.add(
      Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
        infoWindow: InfoWindow(title: 'You are here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );

    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
      zoom: 14.0,
    )));
  }

  // Future<void> fetchShowerLocations() async {
  //   if (currentPosition == null) return;
  //
  //   final String uri = Urls.showAllShower(
  //     currentPosition!.latitude.toString(),
  //     currentPosition!.longitude.toString(),
  //   );
  //
  //   final response = await ApiClient.getData(uri);
  //   if (response.statusCode == 200 ) {
  //     final showers = response.body['data'] as List;
  //
  //     markers.clear();
  //     showers.forEach((shower) {
  //       final coordinates = shower['location']['coordinates'];
  //       final LatLng position = LatLng(
  //         (coordinates[1] as num).toDouble(),
  //         (coordinates[0] as num).toDouble(),
  //       );
  //
  //       markers.add(
  //         Marker(
  //           markerId: MarkerId(shower['_id']),
  //           position: position,
  //           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
  //           infoWindow: InfoWindow(
  //             title: shower['name'],
  //             snippet: '\$${shower['price']}',
  //             onTap: () => _showShowerDetails(shower),
  //           ),
  //         ),
  //       );
  //     });
  //   } else {
  //     // Get.snackbar('Error', 'Failed to fetch showers.');
  //   }
  // }

  // Future<void> searchShowerByKeyword(String keyword) async {
  //   if (keyword.isEmpty) return;
  //
  //   final String uri = Urls.searchShower(keyword);
  //
  //   final response = await ApiClient.getData(uri);
  //   if (response.statusCode == 200 && response.body['success']) {
  //     final showers = response.body['data'] as List;
  //
  //     markers.clear();
  //     showers.forEach((shower) {
  //       final coordinates = shower['location']['coordinates'];
  //       final LatLng position = LatLng(
  //         (coordinates[1] as num).toDouble(),
  //         (coordinates[0] as num).toDouble(),
  //       );
  //
  //       markers.add(
  //         Marker(
  //           markerId: MarkerId(shower['_id']),
  //           position: position,
  //           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //           infoWindow: InfoWindow(
  //             title: shower['name'],
  //             snippet: '\$${shower['price']}',
  //             onTap: () => _showShowerDetails(shower),
  //           ),
  //         ),
  //       );
  //     });
  //
  //     final GoogleMapController controller = await mapController.future;
  //     if (markers.isNotEmpty) {
  //       controller.animateCamera(CameraUpdate.newLatLngZoom(
  //         markers.first.position,
  //         14.0,
  //       ));
  //     }
  //   } else {
  //     // Get.snackbar('Error', 'No showers found for the keyword "$keyword".');
  //   }
  // }


  void _showShowerDetails(Map<String, dynamic> shower) {
    Get.dialog(
      AlertDialog(
        title: CustomText(text: shower['name'], fontsize: 18.sp,),
        content: Column(

          mainAxisSize: MainAxisSize.min,
          children: [
            // ClipRRect(
            //     borderRadius: BorderRadius.all(Radius.circular(10)),
            //     child: Image.network(ApiConstants.imageBaseUrl+shower['image']['publicFileURL'],height: 150.h,width: 300.w,)),
            //
            //

            SizedBox(height: 10.h),
            CustomText(text: 'Price: \$${shower['price']}', fontsize: 16.sp,),
            SizedBox(height: 10.h),
            Text(shower['details'], maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7), fontSize: 14.sp),)
          ],
        ),
        actions: [
          SizedBox(
            width: 300.w,
            child: Row(
              children: [
                Expanded(child: CustomButton(title: "View Shower", onpress: () {
                  // Get.to(ShowerDetailsScreen(showerId: shower["_id"],));
                }, fontSize: 12.sp,)),
                SizedBox(width: 8.w,),
                Expanded(child: CustomButton(title: 'Close', onpress: () {
                  Get.back();
                }, fontSize: 12.sp, color: AppColors.primaryColor,)),
              ],
            ),
          )

        ],
      ),
    );
  }
}
