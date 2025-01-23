import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_category_category_card.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/core/widgets/custom_text_field.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});

  final TextEditingController searchCtrl = TextEditingController();

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
          Assets.icons.menu.svg(),
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
                  borderRadio: 25.r,
                  hintText: "Search",
                  validator: (value) {},
                  prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                    child: Assets.icons.searchLight.svg(height: 20.h),
                  ),
                  suffixIcon: Padding(
                    padding:  EdgeInsets.all(35.r),
                    child: Assets.icons.filter.svg(),
                  ),
                  controller: searchCtrl),



              CustomText(
                  top: 24.h,
                  bottom: 20.h,
                  text: "Select Category",  fontsize: 20.h, fontWeight: FontWeight.w600),



              GridView.builder(
                itemCount: 7,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.82,
                      crossAxisSpacing: 16,
                       mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return const CustomCategoryCategoryCard();
                  },
              ),





              SizedBox(
                height: 44.h,
                child: ListView.builder(
                   shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        margin: EdgeInsets.only(right: 12.w),
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child:  Row(
                          children: [
                            Card(
                                shape: const CircleBorder(),
                                color: Colors.white,
                                child: Padding(
                                  padding:  EdgeInsets.all(8.r),
                                  child: Assets.icons.grid.svg(height: 12.h, fit: BoxFit.cover),
                                )),

                              CustomText(text: "All Events",)

                          ],
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


