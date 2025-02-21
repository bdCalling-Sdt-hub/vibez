import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_category_category_card.dart';
import 'package:seth/core/widgets/custom_network_image.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/core/widgets/custom_text_field.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../../controllers/user/user_event_controller.dart';
import '../../../../core/widgets/custom_event_card.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../models/cetegory_model.dart';

class ManagerAllEventScreen extends StatefulWidget {
  ManagerAllEventScreen({super.key});

  @override
  State<ManagerAllEventScreen> createState() => _ManagerAllEventScreenState();
}

class _ManagerAllEventScreenState extends State<ManagerAllEventScreen> {
  final TextEditingController searchCtrl = TextEditingController();

  UserEventController userEventController = Get.put(UserEventController());

  String? image;


  @override
  void initState() {
    super.initState();
    userEventController.fetchEvent();
    userEventController.getCategory();
    userEventController.fetchFeaturedEvent();
  }

  final List categoryList = [
    "Ticketed Parties",
    "Concerts",
    'Nightclubs',
    "Bars",
    'Party Restaurants',
    'Restaurants',
    "Comedy Clubs"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///=====================App Bar ==================>>>>
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: CustomText(
            text: "All Events", fontWeight: FontWeight.w600, fontsize: 20.h),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///========================Search Box====================>>>
              CustomTextField(
                borderRadio: 25,
                hintText: "Search",
                validator: (value) {},
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Assets.icons.searchLight.svg(height: 20.h),
                ),
                suffixIcon: const Icon(Icons.filter_alt_outlined),
                controller: searchCtrl,

              ),


              CustomText(
                  top: 24.h,
                  bottom: 20.h,
                  text: "Select Category",
                  fontsize: 20.h,
                  fontWeight: FontWeight.w600),

              Obx(() =>
              userEventController.categoryLoading.value ? const CustomLoader() :
              GridView.builder(
                itemCount: userEventController.category.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.82,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  var category = userEventController.category[index];
                  return GestureDetector(
                      onTap: () {
                        final List<Filter> filters = List<Filter>.from(category.filters as Iterable);
                        print("****************************************** ${filters.first.name}");
                        context.pushNamed(AppRoutes.bookMarkScreen,
                            extra: {
                              "category" : "${categoryList[index]}",
                              "filter" : filters
                            });
                      },
                      child: CustomCategoryCategoryCard(
                        image: category.image.toString(),
                        category: categoryList[index],
                      ));
                },
              ),
              ),

              CustomText(
                  top: 24.h,
                  bottom: 20.h,
                  text: "Featured Events",
                  fontsize: 20.h,
                  fontWeight: FontWeight.w600),


              Obx(() =>
              userEventController.featuredEventLoading.value ?  const CustomLoader() : userEventController.featuredEvents.isEmpty ?
              Center(child: CustomText(text: "No Events Found!", top: 100.h, bottom: 100.h)) :
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: userEventController.featuredEvents.length,
                itemBuilder: (context, index) {
                  var events = userEventController.featuredEvents[index];
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
              )),




              ///================Events In your Area==================>>>

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      top: 24.h,
                      bottom: 20.h,
                      text: "Events in Your Area",
                      fontsize: 20.h,
                      right: 12.w,
                      fontWeight: FontWeight.w600),

                  GestureDetector(
                    onTap: (){
                      context.pushNamed(AppRoutes.eventsInYourAreScreen);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(6.r),
                        child: Assets.icons.location.svg(color: AppColors.primaryColor),
                      ),
                    ),
                  ),

                  const Spacer(),



                  ///==============View All button===================>>>

                  CustomButton(
                      height: 32.h,
                      width: 100.w,
                      titlecolor: AppColors.primaryColor,
                      color: Colors.transparent,
                      title: "View All", onpress: (){
                    context.pushNamed(AppRoutes.allEventScreen, extra: "Events in Your Area");
                  })
                ],
              ),




              ///=========================Events List View================>>>>

              Obx(() =>
              userEventController.eventLoading.value ?  const CustomLoader() : userEventController.events.isEmpty ?
              Center(child: CustomText(text: "No Events Found!", top: 100.h, bottom: 100.h)) :
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: userEventController.events.length,
                itemBuilder: (context, index) {
                  var events = userEventController.events[index];
                  return  Padding(
                    padding:  EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                      onTap: (){
                        context.pushNamed(AppRoutes.eventDetails, extra: events.id);
                      },
                      child: CustomEventCard(
                        name: events.name,
                        location: events.location?.type,
                        image: events.photos?.first.publicFileUrl,
                        isFavouriteVisible: false,
                      ),
                    ),
                  );
                },
              ),
              ),


              SizedBox(height: 80.h)
            ],
          ),
        ),
      ),
    );
  }
}
