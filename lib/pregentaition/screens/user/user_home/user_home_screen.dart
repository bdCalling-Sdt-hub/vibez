import 'package:flutter/material.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        leading: Assets.images.applogo.image(),

        actions: [

        ],
      ),

    );
  }
}
