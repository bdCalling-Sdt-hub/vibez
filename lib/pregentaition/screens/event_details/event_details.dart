import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_network_image.dart';

import '../../../core/widgets/custom_text.dart';
import 'inner_widgets/custom_comment_card.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 504.h,
              child: Stack(
                children: [
                  CustomNetworkImage(
                      imageUrl:
                          "https://images.pexels.com/photos/1763075/pexels-photo-1763075.jpeg?cs=srgb&dl=pexels-sebastian-ervi-866902-1763075.jpg&fm=jpg",
                      height: 504.h,
                      width: double.infinity),
                  Positioned(
                      top: 30.h,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        // width: MediaQuery.of(context).size.width,
                        width: 344.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                            ),
                            Expanded(
                              child: CustomText(
                                text: "Maclaren",
                                fontsize: 20.h,
                                color: Colors.black,
                              ),
                            ),
                            const Icon(Icons.edit, color: Colors.black)
                          ],
                        ),
                      )),
                  Positioned(
                    bottom: 30.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: "Maclaren",
                                    fontsize: 28.h,
                                    fontWeight: FontWeight.w600),
                                CustomText(
                                    text: "Location: Lincoln Ave, New York",
                                    maxline: 3),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                            child: Card(
                                color: Colors.green,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.5.h, horizontal: 10.w),
                                  child: CustomText(
                                      text: "Buy Here",
                                      fontWeight: FontWeight.w600),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            ///=========================================================>>>
            ///=========================================================>>>



            SizedBox(height: 20.h),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            CustomText(text: "20", fontsize: 16.h),
                            CustomText(text: "January"),

                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Sunday", fontsize: 16.h),
                            CustomText(text: "7:00 PM - End"),
                          ],
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding:  EdgeInsets.all(4.r),
                            child:  Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 15.r,
                            ),
                          ),
                        ),
                      ],
                    ),





                    CustomText(
                        text: "Filters",
                        fontsize: 16.h,
                        top: 24.h,
                        fontWeight: FontWeight.w600),




                    customFilter(level: "Music", value: "EDM"),
                    customFilter(level: "Energy", value: "High"),
                    customFilter(level: "Crowd", value: "Moderate"),
                    SizedBox(height: 32.h),
                    CustomButton(
                        color: Colors.transparent,
                        titlecolor: AppColors.primaryColor,
                        title: "Rate the Vibe",
                        onpress: () {
                          context.pushNamed(AppRoutes.ratingScreen);
                        }),
                    CustomText(
                        text: "Vibez",
                        fontsize: 16.h,
                        fontWeight: FontWeight.w600,
                        top: 32.h,
                        bottom: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 220.w,
                          child: Column(
                            children: [
                              customVibez(rate: "4.3", vibezName: "Music"),
                              customVibez(rate: "4.3", vibezName: "Drinks"),
                              customVibez(rate: "4.3", vibezName: "Price"),
                              customVibez(rate: "4.3", vibezName: "Atmosphere"),
                              customVibez(rate: "4.3", vibezName: "Breathability"),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              color: const Color(0xff272727)),
                          child: Padding(
                            padding: EdgeInsets.all(10.r),
                            child: Column(
                              children: [
                                CustomText(text: "4.6", fontsize: 36.h),
                                CustomText(
                                    text: "Overall Ratings",
                                    color: AppColors.textColor808080),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    CustomText(
                        text: "Photos",
                        fontsize: 16.h,
                        fontWeight: FontWeight.w600,
                        top: 32.h,
                        bottom: 20.h),
                    SizedBox(
                      height: 115.h,
                      child: ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(4.r),
                            child: CustomNetworkImage(
                                border: Border.all(
                                    color: AppColors.primaryColor, width: 0.08),
                                borderRadius: BorderRadius.circular(8.r),
                                imageUrl:
                                    "https://images.pexels.com/photos/1763075/pexels-photo-1763075.jpeg?cs=srgb&dl=pexels-sebastian-ervi-866902-1763075.jpg&fm=jpg",
                                height: 110.h,
                                width: 169.w),
                          );
                        },
                      ),
                    ),



                    SizedBox(height: 24.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: "Comments",
                            fontsize: 16.h,
                            fontWeight: FontWeight.w600),


                        CustomButton(
                          height: 32.h,
                          width: 90.w,
                            color: Colors.transparent,
                            titlecolor: AppColors.primaryColor,
                            title: "View All", onpress: (){})
                      ],
                    ),

                    SizedBox(height: 20.h),


                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(vertical: 16.h),
                          child: CustomCommentCard(),
                        );
                      },
                    ),



                    SizedBox(height: 50.h)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  customVibez({required String rate, required String vibezName}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.h),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: vibezName == "Music"
                    ? const Color(0xff9b4dff)
                    : vibezName == "Drinks"
                        ? const Color(0xfff84c4d)
                        : vibezName == "Price"
                            ? const Color(0xff37AC51)
                            : vibezName == "Atmosphere"
                                ? const Color(0xffF88051)
                                : vibezName == "Breathability"
                                    ? const Color(0xff3381FF)
                                    : Colors.black),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: CustomText(
                  text: "4.3", fontsize: 16.h, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(width: 16.w),
          CustomText(
            text: vibezName.toString(),
            fontWeight: FontWeight.w600,
            fontsize: 16.h,
          )
        ],
      ),
    );
  }

  customFilter({required String level, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "$level", fontsize: 12.h, bottom: 16.h, top: 20.h),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomText(text: "$value", color: Colors.white)),
      ],
    );
  }
}
