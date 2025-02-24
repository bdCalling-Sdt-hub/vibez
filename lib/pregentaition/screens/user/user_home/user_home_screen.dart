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
import 'package:seth/pregentaition/screens/user/user_home/inner_widgets/customDialog.dart';

import '../../../../controllers/notifications_controller.dart';
import '../../../../controllers/user/user_event_controller.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/custom_event_card.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../helpers/prefs_helper.dart';
import '../../../../models/cetegory_model.dart';
import '../../../../services/api_constants.dart';
import '../../../../services/socket_services.dart';
import 'package:badges/badges.dart' as badges;

class UserHomeScreen extends StatefulWidget {
  UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final TextEditingController searchCtrl = TextEditingController();
  UserEventController userEventController = Get.put(UserEventController());
  NotificationsController notificationsController = Get.put(NotificationsController());

  String? image;
  String? role;


  @override
  void initState() {

    socket();


    notificationsController.listenNotification();
    notificationsController.unReadCount();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLocalData();
    });
    userEventController.fetchEvent();
    userEventController.getCategory();
    userEventController.fetchFeaturedEvent();
  }




  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocalData();
  }


  socket()async{
    SocketServices.init();
    SocketServices();
  }


  getLocalData() async {
    String? newImage = await PrefsHelper.getString(AppConstants.image);
    String? newRole = await PrefsHelper.getString(AppConstants.role);
    setState(() {
      image = newImage;
      role = newRole;
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
          Obx(() =>
              GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoutes.notificationScreen);
                },
                child: badges.Badge(
                  badgeContent: notificationsController.unreadCount.value == "0" ? const SizedBox.shrink() :  CustomText(text: notificationsController.unreadCount.toString(), color: Colors.white, fontsize: 7.h),
                  badgeStyle: notificationsController.unreadCount.value == "0" ? const badges.BadgeStyle(badgeColor: Colors.transparent) :  badges.BadgeStyle(
                    badgeColor: Colors.red,
                    padding: EdgeInsets.all(8.r),
                  ),
                  position: badges.BadgePosition.topEnd(top: -5, end: -5),
                  child: Assets.icons.notification.svg(),
                ),
              ),
          ),

          SizedBox(width: 12.w),
          GestureDetector(
            onTap: (){
              if(role == "guest"){
                customDialog(context);
              }else{
                context.pushNamed(AppRoutes.settingScreen).then((_){ getLocalData();});
              }

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
        padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///========================Search Box====================>>>
              SizedBox(
                height: 45.h,
                child: CustomTextField(
                  onTap: (){
                    if(searchCtrl.text.isNotEmpty){
                      context.pushNamed(AppRoutes.allEventScreen, extra: "${searchCtrl.text}");
                    }
                  },
                    borderRadio: 25,
                    hintText: "Search",
                    validator: (value) {},
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Assets.icons.searchLight.svg(height: 20.h),
                    ),
                    controller: searchCtrl,
                 ),
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
                        if(role == "guest"){
                          customDialog(context);
                        }else{ context.pushNamed(AppRoutes.eventDetails, extra: events.id);}

                      },
                      child: CustomEventCard(
                        name: events.name,
                        location: events.address ?? "N/A",
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
                      context.pushNamed(AppRoutes.eventsInYourAreScreen, extra: "Select you location");
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
                    loaderIgnore: true,
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
                        if(role == "guest"){
                          customDialog(context);
                        }else{
                          context.pushNamed(AppRoutes.eventDetails);
                        }

                      },
                      child: CustomEventCard(
                        name: events.name,
                        location: events.address ?? "N/A",
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

  final List categoryList = [
    "Ticketed Parties",
    "Concerts",
    'Nightclubs',
    "Bars",
    'Party Restaurants',
    'Restaurants',
    "Comedy Clubs"
  ];
}
