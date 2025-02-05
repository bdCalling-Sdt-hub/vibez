import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/widgets/custom_event_card.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../global/custom_assets/assets.gen.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///=====================App Bar ==================>>>>
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: CustomText(
            textAlign: TextAlign.start,
            text: "V I B E Z",
            fontWeight: FontWeight.w900,
            fontsize: 17.h),
        actions: [
          Assets.icons.notification.svg(),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: (){
              context.pushNamed(AppRoutes.settingScreen);
            },
            child: CustomNetworkImage(
                boxShape: BoxShape.circle,
                imageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq2_gZLg3wkjFxo7S_sF_rpbkbGv00qG9Y7A&s",
                height: 26.h,
                width: 26.w),
          ),
          SizedBox(width: 16.w)
        ],
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [


            ///===================My Events and All Events===============>>>

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                GestureDetector(
                  onTap: (){
                    context.pushNamed(AppRoutes.managerEventsScreen, extra: "My Events");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: const Color(0xff272727)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                      child: Row(
                        children: [
                          Assets.icons.dress.svg(),
                          CustomText(text: "My Events", fontWeight: FontWeight.w600, fontsize: 16.h, left: 8.w)
                        ],
                      ),
                    ),
                  ),
                ),


                SizedBox(width: 16.w),

                GestureDetector(
                  onTap: (){
                    context.pushNamed(AppRoutes.managerEventsScreen, extra: "All Events");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: const Color(0xff272727)
                    ),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 12.h, horizontal: 28.w),
                      child: Row(
                        children: [
                          Assets.icons.dress.svg(),
                          CustomText(text: "All Events", fontWeight: FontWeight.w600, fontsize: 16.h, left: 8.w)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),



            SizedBox(height: 20.h),

            ///=====================Edit Profile====================<>>>

            CustomButton(
                color: Colors.transparent,
                titlecolor: AppColors.primaryColor,
                title: "Create Event", onpress: (){
                  context.pushNamed(AppRoutes.createEventScreen, extra: "Create Event");

            }),







            ///================My Current Events==================>>>

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    top: 24.h,
                    bottom: 20.h,
                    text: "My Current Events",
                    fontsize: 20.h,
                    right: 12.w,
                    fontWeight: FontWeight.w600),

                const Spacer(),

                ///==============View All button===================>>>
                CustomButton(
                    height: 32.h,
                    width: 100.w,
                    titlecolor: AppColors.primaryColor,
                    color: Colors.transparent,
                    title: "View All", onpress: (){
                  // context.pushNamed(AppRoutes.eventsInYourAreScreen);
                })
              ],
            ),






            ///=========================Events List View================>>>>

            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: const CustomEventCard(),
                    );
                  }),
            ),


          ],
        ),
      ),

    );
  }
}
