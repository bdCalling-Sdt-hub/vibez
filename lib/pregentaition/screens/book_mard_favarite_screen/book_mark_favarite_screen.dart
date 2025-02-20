import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/widgets/custom_event_card.dart';

import '../../../controllers/user/user_event_controller.dart';
import '../../../core/app_routes/app_routes.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/custom_text.dart';

class BookMarkFavariteScreen extends StatefulWidget {
  const BookMarkFavariteScreen({super.key});

  @override
  State<BookMarkFavariteScreen> createState() => _BookMarkFavariteScreenState();
}

class _BookMarkFavariteScreenState extends State<BookMarkFavariteScreen> {


  UserEventController userEventController = Get.put(UserEventController());


  @override
  void dispose() {
    userEventController.bookMarkEvents.clear();
    super.dispose();
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userEventController.fetchBookEvent();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Bookmarked Events", fontsize: 20.h),
      ),



      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [


            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 50,
            //     itemBuilder: (context, index) {
            //       return  Padding(
            //         padding:  EdgeInsets.only(top: 20.h),
            //         child: const CustomEventCard(
            //           isFavouriteVisible: true,
            //         ),
            //       );
            //     },
            //   ),
            // )
            //




            Expanded(
              child: Obx(() =>

              userEventController.bookMarkLoading.value ? const CustomLoader() : userEventController.bookMarkEvents.isEmpty ?
              Center(child: CustomText(text: "No Events Found!")) :

              ListView.builder(
                itemCount: userEventController.bookMarkEvents.length,
                itemBuilder: (context, index) {
                  var events = userEventController.bookMarkEvents[index];
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
                        isFavouriteVisible: events.isBooked ?? true,
                        isBooked: events.isBooked,
                        onTap: () {
                          userEventController.love(id: events.id.toString());
                          userEventController.bookMarkEvents.removeWhere((event) => event.id == events.id);
                        },
                      ),
                    ),
                  );
                },
              ),
              ),
            )



          ],
        ),
      ),

    );
  }
}
