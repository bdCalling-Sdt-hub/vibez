import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/widgets/custom_event_card.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../core/widgets/custom_text.dart';

class BookMarkScreen extends StatelessWidget {
  final String category;
   BookMarkScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: category.toString(), fontsize: 20.h),

        actions: [
          GestureDetector(
            onTap: (){
              context.pushNamed(AppRoutes.filterScreen, extra: category.toString());
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
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return  Padding(
                    padding:  EdgeInsets.only(top: 20.h),
                    child: GestureDetector(
                      onTap: (){
                        context.pushNamed(AppRoutes.eventDetails);
                      },
                      child: const CustomEventCard(
                      ),
                    ),
                  );
                },
              ),
            )





          ],
        ),
      ),

    );
  }
}
