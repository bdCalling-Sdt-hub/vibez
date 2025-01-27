import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_category_category_card.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/core/widgets/custom_text_field.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../../core/widgets/custom_event_card.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});

  final TextEditingController searchCtrl = TextEditingController();

  List category = ["Ticketed Parties", "Concerts", 'Nightclubs', "Bars", 'Party Restaurants', 'Restaurants', "Comedy Clubs"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      ///=====================App Bar ==================>>>>
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: CustomText(
          textAlign: TextAlign.start,
            text: "V I B E Z", fontWeight: FontWeight.w900, fontsize: 17.h),

        actions: [
          Assets.icons.notification.svg(),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () async {
             showMenu<String>(
                context: context,
                color: Colors.white,
                position: const RelativeRect.fromLTRB(70.0, 70.0, 0.0, 0.0),
                items:  [
                  PopupMenuItem(
                    onTap: () {
                      context.pushNamed(AppRoutes.settingScreen);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Assets.icons.person.svg(color: AppColors.primaryColor, width: 55.w),
                        CustomText(text: "My Profile", color: AppColors.primaryColor, left: 12.w)
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: (){ context.pushNamed(AppRoutes.settingScreen);},
                    child: Row(
                      children: [
                        Assets.icons.setting.svg(),
                        CustomText(text: "Settings", color: Colors.black, left: 20.w)
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      context.pushNamed(AppRoutes.settingScreen);
                    },
                    child: Row(
                      children: [
                        Assets.icons.signOutCircle.svg(),
                        CustomText(text: "Log Out", color: Colors.red, left: 20.w)
                      ],
                    ),
                  ),
                ],
              );
            },
            child: Assets.icons.menu.svg(),
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
              CustomTextField(
                  borderRadio: 25,
                  hintText: "Search",
                  validator: (value) => "",
                  prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                    child: Assets.icons.searchLight.svg(height: 20.h),
                  ),
                  suffixIcon: const Icon(Icons.filter_alt_outlined),
                  controller: searchCtrl),



              CustomText(
                  top: 24.h,
                  bottom: 20.h,
                  text: "Select Category",  fontsize: 20.h, fontWeight: FontWeight.w600),



              GridView.builder(
                itemCount: category.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.82,
                      crossAxisSpacing: 16,
                       mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: (){
                          context.pushNamed(AppRoutes.bookMarkScreen, extra: "${category[index]}");
                        },
                        child:  CustomCategoryCategoryCard(
                          category: category[index],
                        ));
                  },
              ),



              CustomText(
                  top: 24.h,
                  bottom: 20.h,
                  text: "Featured Events",  fontsize: 20.h, fontWeight: FontWeight.w600),


              ListView.builder(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: 8.h),
                    child: const CustomEventCard(),
                  );
                }),

              SizedBox(height: 80.h)


            ],
          ),
        ),
      ),
    );
  }
}



