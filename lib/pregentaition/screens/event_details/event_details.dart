import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/utils/app_constants.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_loader.dart';
import 'package:seth/core/widgets/custom_network_image.dart';
import 'package:seth/helpers/prefs_helper.dart';
import 'package:seth/helpers/time_format.dart';
import 'package:seth/services/api_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/user/user_event_controller.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../models/event_details_model.dart';
import 'inner_widgets/custom_comment_card.dart';

class EventDetails extends StatefulWidget {
  final String id;

  const EventDetails({super.key, required this.id});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  UserEventController userEventController = Get.put(UserEventController());

  String? userRole;
  String? myId;

  @override
  void initState() {
    getLocalData();
    userEventController.getEventDetails(id: widget.id.toString());
    super.initState();
  }

  getLocalData() async {
    userRole = await PrefsHelper.getString(AppConstants.role);
    myId = await PrefsHelper.getString(AppConstants.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          var event = userEventController.eventDetails.value.eventDetails;
          return userEventController.eventDetailsLoading.value
              ? CustomLoader(top: 320.h)
              : Column(
                  children: [
                    SizedBox(
                      height: 360.h,
                      child: Stack(
                        children: [
                          CustomNetworkImage(
                              imageUrl:
                                  "${ApiConstants.imageBaseUrl}/${event?.coverPhoto?.publicFileUrl ?? ""}",
                              height: 504.h,
                              width: double.infinity),
                          Positioned(
                              top: 30.h,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.w),
                                // width: MediaQuery.of(context).size.width,
                                width: 344.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        text: "${event?.name}",
                                        fontsize: 20.h,
                                        color: Colors.black,
                                      ),
                                    ),
                                    // userRole == "user" ? const SizedBox.shrink() : Icon(Icons.edit, color: Colors.black)
                                  ],
                                ),
                              )),
                          Positioned(
                            bottom: 30.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 250.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text:
                                                "${event?.name?[0].toUpperCase()}${event?.name?.substring(1) ?? ""}",
                                            fontsize: 28.h,
                                            fontWeight: FontWeight.w600),
                                        CustomText(
                                            text: event?.address ?? "N/A",
                                            maxline: 3),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launchUrl(
                                          Uri.https("${event?.ticketLink}"));
                                    },
                                    child: SizedBox(
                                      width: 100.w,
                                      child: Card(
                                          color: Colors.green,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 6.5.h,
                                                horizontal: 10.w),
                                            child: CustomText(
                                                text: "Buy Here",
                                                fontWeight: FontWeight.w600),
                                          )),
                                    ),
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
                                    CustomText(
                                        text: TimeFormatHelper.getDate(
                                            event?.date.toString() ??
                                                DateTime.now().toString()),
                                        fontsize: 16.h),
                                    CustomText(
                                      text: TimeFormatHelper.getMonth(
                                          event?.date.toString() ??
                                              DateTime.now().toString()),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: TimeFormatHelper.getDayName(
                                            event?.date.toString() ??
                                                DateTime.now().toString()),
                                        fontsize: 16.h),
                                    CustomText(text: "${event?.time} - End"),
                                  ],
                                ),
                                userRole == "manager"
                                    ? const SizedBox.shrink()
                                    : GestureDetector(
                                        onTap: () {
                                          userEventController.love(
                                              id: widget.id.toString());
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: EdgeInsets.all(4.r),
                                            child: Obx(() {
                                              userEventController
                                                  .loveLoading.value;
                                              return Icon(
                                                event?.isBooked == true
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                color: event?.isBooked == true
                                                    ? Colors.red
                                                    : Colors.black,
                                                size: 15.r,
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            event?.category == "concert"
                                ? SizedBox.shrink()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          text: "Filters",
                                          fontsize: 16.h,
                                          top: 24.h,
                                          fontWeight: FontWeight.w600),
                                      ListView.builder(
                                        itemCount: event?.filters?.length ?? 0,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          var filter = event?.filters?[index];
                                          return customFilter(
                                              level:
                                                  "${filter?.name?[0].toUpperCase()}${filter?.name?.substring(1) ?? ""}",
                                              values: filter?.subfilters ?? []);
                                        },
                                      ),
                                      SizedBox(height: 32.h),
                                      userRole == "manager"
                                          ? const SizedBox.shrink()
                                          : CustomButton(
                                              color: Colors.transparent,
                                              titlecolor:
                                                  AppColors.primaryColor,
                                              title: "Rate the Vibe",
                                              onpress: () {
                                                context.pushNamed(
                                                    AppRoutes.ratingScreen,
                                                    extra: {
                                                      'category': event
                                                          ?.category
                                                          .toString(),
                                                      'eventId':
                                                          widget.id.toString()
                                                    });
                                              }),
                                      CustomText(
                                          text: "Vibez",
                                          fontsize: 16.h,
                                          fontWeight: FontWeight.w600,
                                          top: 32.h,
                                          bottom: 16.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 220.w,
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                    itemCount:
                                                        userEventController
                                                            .eventDetails
                                                            .value
                                                            .ratings
                                                            ?.length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      var rating =
                                                          userEventController
                                                              .eventDetails
                                                              .value
                                                              .ratings?[index];
                                                      return customVibez(
                                                          rate:
                                                              "${rating?.value}",
                                                          vibezName:
                                                              "${rating?.title?.toLowerCase()}");
                                                    }),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: const Color(0xff272727)),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.r),
                                              child: Column(
                                                children: [
                                                  CustomText(
                                                      text:
                                                          "${userEventController.eventDetails.value.overAllRatings}",
                                                      fontsize: 36.h),
                                                  CustomText(
                                                      text: "Overall Ratings",
                                                      color: AppColors
                                                          .textColor808080),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    text: "Photos",
                                    fontsize: 16.h,
                                    fontWeight: FontWeight.w600,
                                    top: 32.h,
                                    bottom: 20.h),
                                myId != event?.userId
                                    ? const SizedBox.shrink()
                                    : GestureDetector(
                                        onTap: () async {
                                          final ImagePicker picker =
                                              ImagePicker();
                                          final XFile? image =
                                              await picker.pickImage(
                                                  source: ImageSource.gallery);

                                          if (image != null) {
                                            userEventController.removeAddPhoto(
                                                image: File(image.path),
                                                eventId: event?.id);
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(2.r),
                                          decoration: const BoxDecoration(
                                            color: AppColors.primaryColor,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.add,
                                              color: Colors.white),
                                        ),
                                      )
                              ],
                            ),
                            SizedBox(
                              height: 115.h,
                              child: Obx(
                                () {
                                  return userEventController
                                          .eventDetailsLoading.value
                                      ? const CustomLoader()
                                      : ListView.builder(
                                          itemCount: event?.photos?.length ?? 0,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return Stack(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(4.r),
                                                  child: CustomNetworkImage(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .primaryColor,
                                                          width: 0.08),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      imageUrl:
                                                          "${ApiConstants.imageBaseUrl}/${event?.photos?[index].publicFileUrl}",
                                                      height: 110.h,
                                                      width: 169.w),
                                                ),
                                                myId != event?.userId
                                                    ? SizedBox.shrink()
                                                    : Positioned(
                                                        top: 10.h,
                                                        right: 10.w,
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              userEventController.removeAddPhoto(
                                                                  imageId: event
                                                                      ?.photos?[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  eventId: event
                                                                      ?.id);
                                                            },
                                                            child: const Icon(
                                                                Icons
                                                                    .remove_circle,
                                                                color: Colors
                                                                    .red))),
                                              ],
                                            );
                                          },
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

                                // CustomButton(
                                //     height: 32.h,
                                //     width: 90.w,
                                //     color: Colors.transparent,
                                //     titlecolor: AppColors.primaryColor,
                                //     title: "View All", onpress: (){})
                              ],
                            ),
                            SizedBox(height: 20.h),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: event?.reviews?.length,
                              itemBuilder: (context, index) {
                                var comment = event?.reviews?[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: CustomCommentCard(
                                    comment:
                                        comment?.message?.comment.toString(),
                                    reviewerName: comment?.user?.name ?? "N/A",
                                    rating:
                                        comment?.avgRating.toString() ?? "0.0",
                                    date: comment?.createdAt ?? DateTime.now(),
                                    reviewerImage: comment?.user?.image,
                                    image: comment?.message?.photos,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 50.h)
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        }),
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
                color: vibezName == "music"
                    ? const Color(0xff9b4dff)
                    : vibezName == "drinks"
                        ? const Color(0xfff84c4d)
                        : vibezName == "price"
                            ? const Color(0xff37AC51)
                            : vibezName == "atmosphere"
                                ? const Color(0xffF88051)
                                : vibezName == "breathability"
                                    ? const Color(0xff3381FF)
                                    : vibezName == "service"
                                        ? Colors.yellow
                                        : vibezName == "food"
                                            ? const Color(0xff9B4DFF)
                                            : vibezName == "ambience"
                                                ? const Color(0xff37AC51)
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

  customFilter({required String level, required List<Subfilter> values}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "$level", fontsize: 12.h, bottom: 16.h, top: 20.h),
        SizedBox(
          height: 50.h,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: values.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.only(right: 16.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: CustomText(
                          text: "${values[index].value}",
                          color: Colors.white)));
            },
          ),
        )
      ],
    );
  }
}
