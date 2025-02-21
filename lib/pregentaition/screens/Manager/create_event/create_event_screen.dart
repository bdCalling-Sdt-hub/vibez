import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:seth/controllers/auth_controller.dart';
import 'package:seth/core/utils/app_colors.dart';
import 'package:seth/core/widgets/custom_button.dart';
import 'package:seth/global/custom_assets/assets.gen.dart';
import 'package:seth/pregentaition/screens/auth/log_in/log_in_screen.dart';

import '../../../../controllers/manager/create_event_controller.dart';
import '../../../../controllers/user/user_event_controller.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../helpers/toast_message_helper.dart';
import '../../../../models/cetegory_model.dart';
import 'inner_widget/upload_progress_widget.dart';

class CreateEventScreen extends StatefulWidget {
  final String title;
  const CreateEventScreen({super.key, required this.title});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {

  UserEventController userEventController = Get.put(UserEventController());
  CreateEventController createEventController = Get.put(CreateEventController());

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController describeYourEventCtrl = TextEditingController();
  final TextEditingController locationCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController timeCtrl = TextEditingController();
  final TextEditingController linkOfTicketCtrl = TextEditingController();
  final TextEditingController musicTypeCtrl = TextEditingController();
  final TextEditingController energyCtrl = TextEditingController();
  final TextEditingController expectedCrowdCtrl = TextEditingController();
  String? lat;
  String? log;


  @override
  void initState() {
    if(widget.title == "concert"){}else{
      userEventController.getCategory(search: widget.title);
    }
    super.initState();
  }

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
                maxLine: 5,
                controller: describeYourEventCtrl,
                hinText: "Describe your event",
                laval: "Enter Event Details",
              ),



              CustomTextFieldWithLavel(
                readOnly: true,
                onTap: () async{
                  var mapData =await  context.pushNamed(AppRoutes.eventsInYourAreScreen, extra: "Select you location");
                  if(mapData is Map){
                    setState(() {
                      locationCtrl.text = mapData["address"];
                      lat = mapData["lat"];
                      log = mapData["log"];
                    });
                  }


                },
                controller: locationCtrl,
                hinText: "Enter the location",
                laval: "Enter Location",
                leadingIcon: Assets.icons.location.svg(color: AppColors.textColor808080),
              ),



              CustomTextFieldWithLavel(
                readOnly: true,
                onTap: () {
                _selectDate(context);
                },
                controller: dateCtrl,
                hinText: "Select Event Date",
                laval: "Event Date",
                leadingIcon: Assets.icons.calander1.svg(color: AppColors.textColor808080),
              ),



              CustomTextFieldWithLavel(
                readOnly: true,
                onTap: () {
                  _selectTime(context);
                },
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




              CustomText(text: "Filters", fontsize: 16.h, fontWeight: FontWeight.w600, top: 20.h),


              ListView.builder(
                itemCount: userEventController.category.first.filters?.length, // widget.filter?.length ?? 0,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var filter = userEventController.category.first.filters?[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text: filter?.name.toString() ?? "",
                          fontsize: 17.h,
                          top: 20.h,
                          bottom: 12.h),
                      // ✅ Filter Name
                      _buttons(
                          "${filter?.id}",
                          filter?.subfilters ?? []),
                      // ✅ Sending subfilters to _buttons
                    ],
                  );
                },
              ),



              //
              // _dropDown(
              //   list: musicGenres,
              //   selected: selectedMusic,
              //   title: "Select Music Type"
              // ),


              // _dropDown(
              //     list: ["Chill", "High"],
              //     selected: selectedEnergy,
              //   title: "Select Energy Level"
              // ),
              //
              //
              // _dropDown(
              //     list: ["Full-House", "Moderate", "Free-Flow"],
              //     selected: selectedSize,
              //   title: "Select Size of Crowd"
              // ),


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


              CustomButton(title: "Create Event", onpress: (){
                createEventController.createEvent(
                    coverImage: selectedImage as File,
                    photos: photos,
                    name: nameCtrl.text,
                    details: describeYourEventCtrl.text,
                    lat: lat.toString(),
                    log: log.toString(),
                    date: dateCtrl.text,
                    time: timeCtrl.text,
                    category: widget.title,
                    address: locationCtrl.text,
                    ticketLink: linkOfTicketCtrl.text,
                    filterIdArray: selectedFilters,
                    context: context
                );
              }),


              SizedBox(height: 100.h)


            ],
          ),
        ),
      ),

    );
  }


  // List<String> selectedMusic = [];
  // List<String> selectedEnergy = [];
  // List<String> selectedSize = [];
  // final List<String> musicGenres = [
  //   "EDM",
  //   "Hip-Hop",
  //   "Jazz",
  //   "House",
  //   "Middle Eastern",
  //   "Latin",
  //   "Country",
  //   "Classical",
  //   "R&B",
  //   "Rock",
  //   "Reggae",
  // ];


  bool progressShow = false;
  double progressValue = 0.0;
  Uint8List? _image;
  File? selectedImage;

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


  List<Map<String, dynamic>> selectedFilters = [];


  void toggleId(String filterId, String subfilterId) {
    int filterIndex = selectedFilters.indexWhere((element) => element["filterId"] == filterId);

    if (filterIndex != -1) {
      List<String> subFilterList = List<String>.from(selectedFilters[filterIndex]["subfilterId"]);

      if (subFilterList.contains(subfilterId)) {
        subFilterList.remove(subfilterId);
      } else {
        subFilterList.add(subfilterId);
      }

      selectedFilters[filterIndex]["subfilterId"] = subFilterList;
    } else {
      selectedFilters.add({
        "filterId": filterId,
        "subfilterId": [subfilterId]
      });
    }
  }



  Widget _buttons(String filterId, List<Subfilter> list) {
    List<dynamic> selectedSubFilters = selectedFilters
        .firstWhere((element) => element["filterId"] == filterId, orElse: () => {"subfilterId": []})["subfilterId"];

    return Wrap(
      spacing: 12.r,
      runSpacing: 12.r,
      children: list.map((x) {
        bool isSelected = selectedSubFilters.contains(x.id);

        return GestureDetector(
          onTap: () {
            setState(() {
              toggleId(filterId, x.id.toString());
              print("========================================================$selectedFilters");
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomText(
              text: "${x.value}",
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        );
      }).toList(),
    );
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



  /// 🗓️ Date Picker Function
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3001),
    );
    if (picked != null) {
      setState(() {
        dateCtrl.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  /// ⏰ Time Picker Function
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        timeCtrl.text = picked.format(context);
      });
    }
  }


}


