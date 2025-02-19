import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/core/widgets/custom_text.dart';
import 'package:seth/core/widgets/custom_text_field.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';

import '../../../controllers/profile_controller.dart';
import '../../../core/widgets/custom_network_image.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> profileData;
  EditProfileScreen({super.key, required this.profileData});

  @override
  State<EditProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneNoCtrl = TextEditingController();

  ProfileController profileController = Get.put(ProfileController());


  @override
  void initState() {
    emailCtrl.text = widget.profileData["email"]?.toString() ?? "";
    nameCtrl.text = widget.profileData["name"]?.toString() ?? "";
    phoneNoCtrl.text = widget.profileData["phone"]?.toString() ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(text: "Personal Data", fontsize: 20.h),
      ),


      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
        
        
              GestureDetector(
                onTap: (){
                  showImagePickerOption(context);
                },
                child: Stack(
                  children: [
                    _image != null ? Container(
                        height: 120.h, width: 120.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.memory(_image!, fit: BoxFit.cover)) : CustomNetworkImage(
                        boxShape: BoxShape.circle,
                        imageUrl: widget.profileData["image"].toString(),
                        height: 120.h, width: 120.w
                    ),
        
                   const Positioned(
                      bottom: 0,
                        right: 0,
                        child: Icon(Icons.image_outlined, color: AppColors.primaryColor)
                    )
                  ],
                ),
              ),
        
        
              CustomText(text: "Upload New Photo", fontsize: 20.h, top: 16.h, color: AppColors.primaryColor),
        
        
        
              ///==================Name -==============>>>
        
              SizedBox(height: 16.h),
              CustomTextField(
                  prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                    child: Assets.icons.person.svg(),
                  ),
                  controller: nameCtrl),
        
        
        
        
              ///==================Email -==============>>>
        
              SizedBox(height: 16.h),
              CustomTextField(
                  prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                    child: Assets.icons.email.svg(),
                  ),
                  readOnly: true,
                  controller: emailCtrl),
        
        
        
              ///==================Phone -==============>>>
        
              SizedBox(height: 16.h),
              CustomTextField(
                  prefixIcon: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w),
                    child: Assets.icons.call.svg(),
                  ),
                  readOnly: true,
                  controller: phoneNoCtrl),
        
        
        
              SizedBox(height: 150.h),
        
              CustomButton(
                  title: "Done", onpress: (){
                    profileController.profileUpdate(
                      name: nameCtrl.text,
                      image: selectedIMage,
                      context: context
                    );
              })
        
        
            ],
          ),
        ),
      ),
    );
  }


  Uint8List? _image;
  File? selectedIMage;



  //==================================> ShowImagePickerOption Function <===============================
  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(.5),
        elevation: 3,
        context: context,
        builder: (builder) {
          return Container(
            decoration: BoxDecoration(
              border: const Border(top: BorderSide(color: AppColors.primaryColor, width: 0.25)),
              borderRadius: BorderRadius.circular(20.r),

            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 9.2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImageFromGallery();
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Icon(
                                Icons.image,
                                size: 50.w,
                              ),
                              CustomText(text: 'Gallery')
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _pickImageFromCamera();
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 50.w,
                              ),
                              CustomText(text: 'Camera')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }



  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.pop(context);
  }

//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.pop(context);
  }


}
