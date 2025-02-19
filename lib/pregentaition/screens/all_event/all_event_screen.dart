import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/widgets/custom_event_card.dart';
import 'package:seth/core/widgets/custom_loader.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../controllers/user/user_event_controller.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_field.dart';

class AllEventScreen extends StatefulWidget {
  final String category;
  AllEventScreen({super.key, required this.category});

  @override
  State<AllEventScreen> createState() => _AllEventScreenState();
}

class _AllEventScreenState extends State<AllEventScreen> {
  final TextEditingController searchCtrl = TextEditingController();

  UserEventController userEventController = Get.put(UserEventController());


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userEventController.fetchEvent(category: "${widget.category}");
    });

    super.initState();
  }



  @override
  void dispose() {
    userEventController.events.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: CustomText(text: widget.category.toString(), fontsize: 20.h)
      ),



      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [


            widget.category == "Search Results" ?
            CustomTextField(
              borderRadio: 25,
              hintText: "Search",
              validator: (value) {},
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Assets.icons.searchLight.svg(height: 20.h)
              ),
              controller: searchCtrl,
            ) : const SizedBox(),


            Expanded(
              child: Obx(() =>

              userEventController.eventLoading.value ? const CustomLoader() : userEventController.events.isEmpty ?
                  Center(child: CustomText(text: "No Events Found!")) :

                 ListView.builder(
                  itemCount: userEventController.events.length,
                  itemBuilder: (context, index) {
                    var events = userEventController.events[index];
                    return  Padding(
                      padding:  EdgeInsets.only(top: 20.h),
                      child: GestureDetector(
                        onTap: (){
                          context.pushNamed(AppRoutes.eventDetails);
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
