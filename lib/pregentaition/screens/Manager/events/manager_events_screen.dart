
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/utils/app_colors.dart';
import '../../../../controllers/manager/manager_event_controller.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/widgets/custom_event_card.dart';
import '../../../../core/widgets/custom_loader.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../global/custom_assets/assets.gen.dart';

class ManagerEventsScreen extends StatefulWidget {
   final String title;
   ManagerEventsScreen({super.key, required this.title});

  @override
  State<ManagerEventsScreen> createState() => _ManagerEventsScreenState();
}

class _ManagerEventsScreenState extends State<ManagerEventsScreen> {
   ManagerEventController managerEventController = Get.put(ManagerEventController());
   int selectedItem = 0;


   @override
  void initState() {
    managerEventController.fetchEvent(type: "past");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          ///=====================App Bar ==================>>>>
          appBar: AppBar(
            centerTitle: true,
            scrolledUnderElevation: 0,
            title: CustomText(text: widget.title, fontsize: 20.h),
          ),
        body: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
              child: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.primaryColor,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: AppColors.primaryColor, // Active tab background color
                  borderRadius: BorderRadius.circular(20),
                ),
                tabs: [
                  // Messages Tab
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor, // Unselected tab border color
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text('Messages',style: TextStyle(fontFamily: "Outfit"),),
                      ),
                    ),
                  ),
                  //Group Messages Tab
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor, // Unselected tab border color
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text('Groups',style: TextStyle(fontFamily: "Outfit"),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Expanded TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  Text("data"),
                  Text("data"),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    //   Scaffold(
    //
    //   ///=====================App Bar ==================>>>>
    //   // appBar: AppBar(
    //   //   centerTitle: true,
    //   //   scrolledUnderElevation: 0,
    //   //   title: CustomText(text: widget.title, fontsize: 20.h),
    //   // ),
    //
    //
    //
    //   // body: Padding(
    //   //   padding:  EdgeInsets.symmetric(horizontal: 24.w),
    //   //   child: Column(
    //   //     children: [
    //   //
    //   //
    //   //       // ///===================My Events and All Events===============>>>
    //   //       //
    //   //       // Row(
    //   //       //   mainAxisAlignment: MainAxisAlignment.start,
    //   //       //   children: [
    //   //       //
    //   //       //     GestureDetector(
    //   //       //       onTap: (){
    //   //       //         setState(() {
    //   //       //           selectedItem == 0;
    //   //       //         });
    //   //       //       },
    //   //       //       child: Container(
    //   //       //         decoration: BoxDecoration(
    //   //       //             borderRadius: BorderRadius.circular(24.r),
    //   //       //             color: selectedItem == 0 ? AppColors.primaryColor :  Colors.transparent,
    //   //       //           border: Border.all(color: Colors.white)
    //   //       //         ),
    //   //       //         child: Padding(
    //   //       //           padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    //   //       //           child: CustomText(text: "Current Events (12)"),
    //   //       //         ),
    //   //       //       ),
    //   //       //     ),
    //   //       //
    //   //       //
    //   //       //     SizedBox(width: 16.w),
    //   //       //
    //   //       //
    //   //       //     GestureDetector(
    //   //       //       onTap: (){
    //   //       //         setState(() {
    //   //       //           selectedItem == 1;
    //   //       //         });
    //   //       //       },
    //   //       //       child: Container(
    //   //       //         decoration: BoxDecoration(
    //   //       //             borderRadius: BorderRadius.circular(24.r),
    //   //       //             color: selectedItem == 1 ? AppColors.primaryColor :  Colors.transparent,
    //   //       //             border: Border.all(color: Colors.white)
    //   //       //         ),
    //   //       //         child: Padding(
    //   //       //           padding:  EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    //   //       //           child: CustomText(text: "Past Events (20)"),
    //   //       //         ),
    //   //       //       ),
    //   //       //     ),
    //   //       //
    //   //       //
    //   //       //   ],
    //   //       // ),
    //   //       //
    //   //
    //   //
    //   //       SizedBox(height: 20.h),
    //   //
    //   //
    //   //       ///=========================Events List View================>>>>
    //   //
    //   //
    //   //       Obx(() =>
    //   //
    //   //       Expanded(
    //   //         child: managerEventController.eventLoading.value ?  const CustomLoader() : managerEventController.events.isEmpty ?
    //   //         Center(child: CustomText(text: "No Events Found!", top: 100.h, bottom: 100.h)) :
    //   //
    //   //         ListView.builder(
    //   //           shrinkWrap: true,
    //   //           itemCount: managerEventController.events.length,
    //   //           itemBuilder: (context, index) {
    //   //             var events = managerEventController.events[index];
    //   //             return  Padding(
    //   //               padding:  EdgeInsets.only(top: 20.h),
    //   //               child: GestureDetector(
    //   //                 onTap: (){
    //   //                   context.pushNamed(AppRoutes.eventDetails, extra: events.id);
    //   //                 },
    //   //                 child: CustomEventCard(
    //   //                   name: events.name,
    //   //                   location: events.location?.type,
    //   //                   image: events.coverPhoto?.publicFileUrl,
    //   //                   isFavouriteVisible: false,
    //   //                 ),
    //   //               ),
    //   //             );
    //   //           },
    //   //         ),
    //   //       )),
    //   //
    //   //
    //   //     ],
    //   //   ),
    //   // ),
    //
    // );
  }
}
