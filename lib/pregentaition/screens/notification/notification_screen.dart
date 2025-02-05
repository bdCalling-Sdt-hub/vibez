import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/utils/app_colors.dart';

import '../../../core/widgets/custom_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: CustomText(text: "Notifications", fontsize: 20.h),
      ),
      
      
      
      body: Column(
        children: [
          
          
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {


                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
                  leading: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor
                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(15.r),
                      child: const Icon(Icons.notifications, color: Colors.white, size: 30),
                    ),
                  ),

                  title: CustomText(
                    maxline: 5,
                    textAlign: TextAlign.start,
                    fontsize: 17.h,
                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",),
                );

              },
            ),
          )
          
        ],
      ),
    );
  }
}
