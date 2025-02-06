import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seth/core/widgets/custom_event_card.dart';

import '../../../core/widgets/custom_text.dart';

class BookMarkFavariteScreen extends StatelessWidget {
  const BookMarkFavariteScreen({super.key});

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


            Expanded(
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return  Padding(
                    padding:  EdgeInsets.only(top: 20.h),
                    child: const CustomEventCard(
                      isFavouriteVisible: true,
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
