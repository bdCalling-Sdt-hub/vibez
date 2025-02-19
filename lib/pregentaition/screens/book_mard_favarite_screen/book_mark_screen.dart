import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/widgets/custom_event_card.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../controllers/user/user_event_controller.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/custom_text.dart';

class BookMarkScreen extends StatefulWidget {
  final String category;
   BookMarkScreen({super.key, required this.category});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {


  UserEventController userEventController = Get.put(UserEventController());


  @override
  void dispose() {
    userEventController.events.clear();
    super.dispose();
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userEventController.fetchEvent(category: "${widget.category}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: widget.category.toString(), fontsize: 20.h),

        actions: [
          GestureDetector(
            onTap: (){
              context.pushNamed(AppRoutes.filterScreen, extra: widget.category.toString());
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent
              ),

              child: Padding(
                padding:  EdgeInsets.all(8.r),
                child: Assets.icons.tune.svg(),
              ),
            ),
          ),


          SizedBox(width: 20.w)
        ],
      ),



      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [

            Expanded(
              child: Obx(() =>

              userEventController.eventLoading.value ?  const CustomLoader() : userEventController.events.isEmpty ?
              Center(child: CustomText(text: "No Events Found!")) :

              ListView.builder(
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
            )






          ],
        ),
      ),

    );
  }
}
