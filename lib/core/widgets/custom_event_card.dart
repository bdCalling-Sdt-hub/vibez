import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';

class CustomEventCard extends StatelessWidget {
  final bool isFavouriteVisible;
  const CustomEventCard({super.key, this.isFavouriteVisible = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 241.h,
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(16.r),
          image: const DecorationImage(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRq2_gZLg3wkjFxo7S_sF_rpbkbGv00qG9Y7A&s"),
              fit: BoxFit.cover)),
      child: Column(
        children: [

          SizedBox(height: 16.h),
          isFavouriteVisible == false ? SizedBox() :  Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding:  EdgeInsets.all(8.r),
                child: const Icon(Icons.favorite, color: Colors.red),
              ),
            ),
          ),

          const Spacer(),
          Padding(
            padding: EdgeInsets.all(7.r),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text: "Holiday Concert",
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                          CustomText(
                              text: "123 Lincoln Ave - 10:00 PM",
                              color: Colors.black),
                        ],
                      ),
                    ),



                    Card(
                        color: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 6.5.h, horizontal: 10.w),
                          child: CustomText(
                              text: "Buy Here",
                              fontWeight: FontWeight.w600),
                        )),
                  ],
                )),
              ),
            ),
          ),
          SizedBox(height: 12.h)
        ],
      ),
    );
  }
}
