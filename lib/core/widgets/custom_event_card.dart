import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:seth/services/api_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/user/user_event_controller.dart';
import 'custom_text.dart';

class CustomEventCard extends StatelessWidget {
  final bool isFavouriteVisible;
  final bool? isBooked;
  final VoidCallback? onTap;
  final String? name;
  final String? location;
  final String? image;
   CustomEventCard({super.key, this.isFavouriteVisible = false, this.name, this.location, this.image, this.isBooked = false, this.onTap});

  UserEventController userEventController = Get.put(UserEventController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 241.h,
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(16.r),
          image:  DecorationImage(
              image: NetworkImage(
                  "${ApiConstants.imageBaseUrl}/$image"),
              fit: BoxFit.cover)),
      child: Column(
        children: [

          SizedBox(height: 16.h),
          isFavouriteVisible == false ? const SizedBox() :  Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding:  EdgeInsets.all(8.r),
                  child:  Icon(
                    isBooked == true ?  Icons.favorite : Icons.favorite_border,
                    color: isBooked == true ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ),
          ),

          const Spacer(),
          Padding(
            padding: EdgeInsets.all(7.r),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: name ?? "N/A",
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          CustomText(
                              text: location ?? "N/A",
                              color: Colors.black),
                        ],
                      ),
                    ),



                    Card(
                        color: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.5.h, horizontal: 10.w),
                          child: CustomText(
                              text: "View Details",
                              fontWeight: FontWeight.w600),
                        )),
                  ],
                )),
              ),
            ),
          ),
          SizedBox(height: 12.h)
        ],
      ),
    );
  }
}