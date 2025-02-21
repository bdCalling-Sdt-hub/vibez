import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/widgets/custom_event_card.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../controllers/user/user_event_controller.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/widgets/custom_loader.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../helpers/prefs_helper.dart';
import '../../../models/cetegory_model.dart';
import '../user/user_home/inner_widgets/customDialog.dart';

class BookMarkScreen extends StatefulWidget {
  final String category;
  final List<Filter>? filter;
   BookMarkScreen({super.key, required this.category, this.filter});

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
    getLocalData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userEventController.fetchEvent(category: "${widget.category}");
    });
    super.initState();
  }


  String? role;

  getLocalData() async {
    String? newRole = await PrefsHelper.getString(AppConstants.role);
    setState(() {
      role = newRole;
    });
  }


  @override
  Widget build(BuildContext context) {
    print("======================================================favarite book mark screen");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: widget.category.toString(), fontsize: 20.h),

        actions: [
          GestureDetector(
            onTap: (){
              context.pushNamed(AppRoutes.filterScreen, extra: widget.filter);
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
                        if(role == "guest"){
                          customDialog(context);
                        }else{
                          context.pushNamed(AppRoutes.eventDetails, extra: events.id);
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
            )






          ],
        ),
      ),

    );
  }
}
