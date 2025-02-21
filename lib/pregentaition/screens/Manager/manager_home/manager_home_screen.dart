
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';

import '../../../../controllers/manager/manager_event_controller.dart';
import '../../../../controllers/user/user_event_controller.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_event_card.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../core/widgets/custom_network_image.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../global/custom_assets/assets.gen.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../services/api_constants.dart';

class ManagerHomeScreen extends StatefulWidget {
  const ManagerHomeScreen({super.key});

  @override
  State<ManagerHomeScreen> createState() => _ManagerHomeScreenState();
}

class _ManagerHomeScreenState extends State<ManagerHomeScreen> {
  ManagerEventController managerEventController = Get.put(ManagerEventController());




  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLocalData();
    });
    managerEventController.fetchEvent();
  }

  String? image;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocalData();
  }


  getLocalData() async {
    String? newImage = await PrefsHelper.getString(AppConstants.image);
    setState(() {
      image = newImage;
    });
  }

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
                imageUrl: (image != null && image!.isNotEmpty)
                    ? "${ApiConstants.imageBaseUrl}/$image"
                    : "https://templates.joomla-monster.com/joomla30/jm-news-portal/components/com_djclassifieds/assets/images/default_profile.png",
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
                    context.pushNamed(AppRoutes.managerAllEventScreen);
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
                title: "Create Event", onpress: ()async{

              // final List<String> businessTypes = [
              //   "Are you a manager for a restaurant?",
              //   "Are you a manager for a bars?",
              //   "Are you a manager for a nightclubs?",
              //   "Are you a manager for a party restaurant?",
              //   "Are you a manager for  ticketed parties?",
              //   "Are you a manager for a comedy club?",
              //   "Are you a manager for concerts?",
              // ];

                  var managerType = await PrefsHelper.getString(AppConstants.managerType);

                  if(managerType == "Are you a manager for a restaurant?"){
                    context.pushNamed(AppRoutes.createEventScreen, extra: "restaurant");
                  }

                  else if(managerType == "Are you a manager for a nightclubs?"){
                    context.pushNamed(AppRoutes.createEventScreen, extra: "night-clubs");
                  }


                  else if(managerType == "Are you a manager for a bars?"){
                    context.pushNamed(AppRoutes.createEventScreen, extra: "bars");
                  }

                  else if(managerType == "Are you a manager for a party restaurant?"){
                    context.pushNamed(AppRoutes.createEventScreen, extra: "party-restaurant");
                  }


                  else if(managerType == "Are you a manager for  ticketed parties?"){
                    context.pushNamed(AppRoutes.createEventScreen, extra: "ticketed-parties");
                  }

                  else if(managerType == "Are you a manager for a comedy club?"){
                    context.pushNamed(AppRoutes.createEventScreen, extra: "comedy-clubs");
                  }

                  else{
                    // context.pushNamed(AppRoutes.createEventScreen, extra: "concert");
                    context.pushNamed(AppRoutes.createEventScreen, extra: "comedy-clubs");
                  }
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

                // const Spacer(),
                //
                // ///==============View All button===================>>>
                // CustomButton(
                //     height: 32.h,
                //     width: 100.w,
                //     titlecolor: AppColors.primaryColor,
                //     color: Colors.transparent,
                //     title: "View All", onpress: (){
                //   // context.pushNamed(AppRoutes.eventsInYourAreScreen);
                // })
              ],
            ),



            ///=========================Events List View================>>>>


            Obx(() =>
            Expanded(
              child: managerEventController.eventLoading.value ?  const CustomLoader() : managerEventController.events.isEmpty ?
              Center(child: CustomText(text: "No Events Found!", top: 100.h, bottom: 100.h)) : ListView.builder(
                shrinkWrap: true,
                itemCount: managerEventController.events.length,
                itemBuilder: (context, index) {
                  var events = managerEventController.events[index];
                  return  Padding(
                    padding:  EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                      onTap: (){
                        context.pushNamed(AppRoutes.eventDetails, extra: events.id);
                      },
                      child: CustomEventCard(
                        name: events.name,
                        location: events.location?.type,
                        image: events.coverPhoto?.publicFileUrl,
                        isFavouriteVisible: false,
                      ),
                    ),
                  );
                },
              ),
            )),



          ],
        ),
      ),

    );
  }
}
