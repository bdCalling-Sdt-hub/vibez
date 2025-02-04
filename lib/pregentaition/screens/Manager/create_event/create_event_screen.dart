import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_text.dart';

class CreateEventScreen extends StatelessWidget {
  final String title;
  const CreateEventScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///=====================App Bar ==================>>>>
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: CustomText(text: title, fontsize: 20.h),
      ),



      body: Column(
        children: [

        ],
      ),

    );
  }
}
