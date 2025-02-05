import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';
import 'package:seth/pregentaition/screens/auth/log_in/log_in_screen.dart';

import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../helpers/toast_message_helper.dart';
import 'inner_widget/upload_progress_widget.dart';

class CreateEventScreen extends StatefulWidget {
  final String title;
  const CreateEventScreen({super.key, required this.title});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController describeYourEventCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController timeCtrl = TextEditingController();
  final TextEditingController linkOfTicketCtrl = TextEditingController();
  final TextEditingController musicTypeCtrl = TextEditingController();
  final TextEditingController energyCtrl = TextEditingController();
  final TextEditingController expectedCrowdCtrl = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///=====================App Bar ==================>>>>
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: CustomText(text: widget.title, fontsize: 20.h),
      ),



      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              Row(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),

                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: const Icon(Icons.wb_cloudy_outlined, color: Colors.black54),
                      )),


                  CustomText(text: "Upload Cover Image", left: 12.w, color: AppColors.textColor808080)
                ],
              ),


              SizedBox(height: 20.h),



              GestureDetector(
                onTap: (){
                  _pickImageFromGallery();
                },
                child: Container(
                  height: 209.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(15.r),
                    dashPattern: const [10, 5],
                    color: const Color(0xffCBD0DC),
                    strokeWidth: 3,
                    child:

                    _image != null ? Container(
                      clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.r)
                        ),
                        child: Image.memory(_image!, fit: BoxFit.cover, width: double.infinity, height: double.infinity)) :
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 33.h),
                      child: Center(
                        child: Column(
                          children: [


                            const Icon(Icons.wb_cloudy_outlined, color: Colors.black54),

                            CustomText(text: "Choose a file or drag & drop it here", color: const Color(0xff666666)),
                            CustomText(text: "PNG, JPG & JPEG formats, up to 50MB",top: 4.h, bottom: 20.h, color: const Color(0xffA9ACB4),),

                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(8.r),
                                child: CustomText(text: "Browse File", color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),




              if (progressShow) ...[
                SizedBox(height: 20.h),
                     UploadProgressWidget(
                      fileName: "Sagor.pnd",
                      progress: progressValue.toDouble(),
                      status: "Uploading...",
                    ),
              ],




              CustomTextFieldWithLavel(
                  controller: nameCtrl,
                  hinText: "Enter your event name",
                 laval: "Enter Event Name",
              ),



              CustomTextFieldWithLavel(
                controller: describeYourEventCtrl,
                hinText: "Describe your event",
                laval: "Enter Event Details",
              ),





              CustomTextFieldWithLavel(
                controller: locationCtrl,
                hinText: "Enter the location",
                laval: "Enter Location",
                leadingIcon: Assets.icons.location.svg(color: AppColors.textColor808080),
              ),



              CustomTextFieldWithLavel(
                controller: dateCtrl,
                hinText: "Select Event Date",
                laval: "Event Date",
                leadingIcon: Assets.icons.calander1.svg(color: AppColors.textColor808080),
              ),



              CustomTextFieldWithLavel(
                controller: timeCtrl,
                hinText: "Select Event Time",
                laval: "Event Time",
                leadingIcon: Assets.icons.chock.svg(color: AppColors.textColor808080),
              ),



              CustomTextFieldWithLavel(
                controller: linkOfTicketCtrl,
                hinText: "Input ticket link",
                laval: "Ticket Link",
                leadingIcon: Assets.icons.link.svg(color: AppColors.textColor808080),
              ),




              CustomTextFieldWithLavel(
                controller: musicTypeCtrl,
                hinText: "Inpsdgtsdg link",
                laval: "Ticketsdgsdg Lsdggfsdink",
                leadingIcon: Assets.icons.link.svg(color: AppColors.textColor808080),

              ),


              CustomText(text: "Filters", fontsize: 16.h, fontWeight: FontWeight.w600, top: 20.h),

              _dropDown(
                list: musicGenres,
                selected: selectedMusic,
                title: "Select Music Type"
              ),


              _dropDown(
                  list: ["Chill", "High"],
                  selected: selectedEnergy,
                title: "Select Energy Level"
              ),


              _dropDown(
                  list: ["Full-House", "Moderate", "Free-Flow"],
                  selected: selectedSize,
                title: "Select Size of Crowd"
              ),


              CustomText(text: "Photos", fontsize: 16.h, fontWeight: FontWeight.w600, top: 20.h, bottom: 20.h),

              Row(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),

                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: const Icon(Icons.wb_cloudy_outlined, color: Colors.black54),
                      )),


                  CustomText(text: "Upload Party Photo (max 2)", left: 12.w, color: AppColors.textColor808080)
                ],
              ),


              const Divider(),

              SizedBox(height: 12.h),



              photos.length == 2 ? const SizedBox() :
              GestureDetector(
                onTap: (){
                  if (photos.length < 2) {
                    addPhoto();
                  } else {
                    ToastMessageHelper.showToastMessage('Upload Party Photo (max 2)');
                  }

                },
                child: Container(
                  height: 209.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.white),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(15.r),
                    dashPattern: const [10, 5],
                    color: const Color(0xffCBD0DC),
                    strokeWidth: 3,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 33.h),
                      child: Center(
                        child: Column(
                          children: [
                            const Icon(Icons.wb_cloudy_outlined, color: Colors.black54),

                            CustomText(text: "Choose a file here", color: const Color(0xff666666)),
                            CustomText(text: "PNG, JPG & JPEG formats, up to 50MB",top: 4.h, bottom: 20.h, color: const Color(0xffA9ACB4),),

                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Padding(
                                padding:  EdgeInsets.all(8.r),
                                child: CustomText(text: "Browse File", color: Colors.black),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              SizedBox(height: 20.h),


              if (progressShow) ...[
                SizedBox(height: 20.h),
                UploadProgressWidget(
                  fileName: "Sagor.pnd",
                  progress: progressValue.toDouble(),
                  status: "Uploading...",
                ),
                SizedBox(height: 20.h),
              ],


              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 1.536,
                ),
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  if (index == photos.length) {
                    return GestureDetector(
                      onTap: () => addPhoto(),
                      child: Stack(
                        children: [
                          /// ================================>  Add Button with Dashed Border ==================================>
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFFFB3F81),
                                  Color(0xFFB749BB),
                                  Color(0xFF8C4AEF),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds);
                            }
                          ),
                        ],
                      ),
                    );
                  }

                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          image: DecorationImage(
                            image: FileImage(photos[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: 24.h),


              CustomButton(title: "Edit Profile", onpress: (){}),


              SizedBox(height: 100.h)


            ],
          ),
        ),
      ),

    );
  }


  List<String> selectedMusic = [];
  List<String> selectedEnergy = [];
  List<String> selectedSize = [];
  final List<String> musicGenres = [
    "EDM",
    "Hip-Hop",
    "Jazz",
    "House",
    "Middle Eastern",
    "Latin",
    "Country",
    "Classical",
    "R&B",
    "Rock",
    "Reggae",
  ];


  bool progressShow = false;
  double progressValue = 0.0;
  Uint8List? _image;
  File? selectedImage;

  List <Uint8List>? coverImages = [];
  List <File>? coverSelectedImage = [];


  Future<void> _uploadImageSimulation() async {
    progressShow = true;
    progressValue = 0.0;
    const interval = Duration(milliseconds: 200);
    Timer.periodic(interval, (timer) {
      setState(() {
        progressValue += 0.1;
        if (progressValue >= 1.0) {
          timer.cancel();
          progressShow = false;
        }
      });
    });
  }



  Future<void> _pickImageFromGallery() async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    _uploadImageSimulation();
  }


  RxList<File> photos = <File>[].obs;

  Future<void> addPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
        photos.add(File(image.path));
    }
    _uploadImageSimulation();
  }



  _dropDown({required List<String> list, selected, required String title}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [



        CustomText(text: "$title", color: AppColors.textColor808080, bottom: 12.h, top: 18.h),

        DropDownMultiSelect(
          onChanged: (List<String> x) {
            setState(() {
              selected = x;
            });
          },
          options: list,
          selectedValues: selected,
          whenEmpty: 'Select Something',
          selectedValuesStyle: const TextStyle(color: Colors.transparent),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(16.r),
              ),

              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(16.r),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(16.r),
              )
          ),

          readOnly: true,
        ),
      ],
    );
  }

}


