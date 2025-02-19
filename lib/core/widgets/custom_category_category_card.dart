
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/services/api_constants.dart';

import 'custom_text.dart';

class CustomCategoryCategoryCard extends StatelessWidget {
  final String? category;
  final String? image;
  const CustomCategoryCategoryCard({super.key, this.category, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.circular(16.r),
          image:  DecorationImage(
              image: NetworkImage("${ApiConstants.imageBaseUrl}/$image"),
              fit: BoxFit.cover)
      ),

      child: Column(
        children: [
          const Spacer(),

          Padding(
            padding:  EdgeInsets.all(7.r),
            child: Container(
              height: 33.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                color: const Color(0xff3590ff).withOpacity(.6),
              ),


              child: Center(child: CustomText(text: category.toString(), fontWeight: FontWeight.w600)),

            ),
          ),

          SizedBox(height: 12.h)
        ],
      ),
    );
  }
}
