import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import 'package:seth/core/widgets/custom_event_card.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_text_field.dart';

class AllEventScreen extends StatelessWidget {
  final String category;
  AllEventScreen({super.key, required this.category});

  final TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: CustomText(text: category.toString(), fontsize: 20.h)
      ),



      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [


            category == "Search Results" ?
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
                        isFavouriteVisible: false,
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
