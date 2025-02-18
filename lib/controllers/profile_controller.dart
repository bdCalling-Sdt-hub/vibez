import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:seth/controllers/auth_controller.dart';
import 'package:seth/core/app_routes/app_routes.dart';
import '../core/utils/app_constants.dart';
import '../helpers/prefs_helper.dart';
import '../helpers/toast_message_helper.dart';
import '../services/api_client.dart';
import '../services/api_constants.dart';



class ProfileController extends GetxController {

  // RxBool profileLoading = false.obs;
  //
  // Rx<ProfileModel> profileData = ProfileModel().obs;
  //
  // getProfileData() async {
  //   profileLoading(true);
  //   var response = await ApiClient.getData(ApiConstants.profileEndPoint);
  //
  //   print('--------------------------------------------${response.body}');
  //   if (response.statusCode == 200) {
  //     var responseData = response.body;
  //     await PrefsHelper.setString(
  //         AppConstants.image, response.body["data"]['image']["publicFileURL"]);
  //     profileData.value = ProfileModel.fromJson(responseData['data']);
  //     profileLoading(false);
  //   } else if (response.statusCode == 404) {
  //     profileLoading(false);
  //   }
  // }

  ///===============profile update================<>
  RxBool updateProfileLoading = false.obs;

  profileUpdate({File? image, String? name, required BuildContext context}) async {
    updateProfileLoading(true);
    List<MultipartBody> multipartBody =
        image == null ? [] : [MultipartBody("image", image)];

    var body = {
      "name": '$name',
    };
    var response = await ApiClient.patchMultipartData(
        ApiConstants.updateProfile, body,
        multipartBody: multipartBody);

    print("=======> ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(AppConstants.name, name);
      await PrefsHelper.setString(AppConstants.image, response.body["data"]['image']);
      context.pop();
      context.pop();
      ToastMessageHelper.showToastMessage('Profile Updated Successful');
      update();
      updateProfileLoading(false);
    }else{
      updateProfileLoading(false);
    }
  }

  // ///===============account delete================<>
  // RxBool deleteLoading = false.obs;
  // accountDelete({
  //   String? password,
  // }) async {
  //   deleteLoading(true);
  //   var body = {
  //     "password": '$password',
  //   };
  //   var response = await ApiClient.postData(ApiConstants.accountDelete, jsonEncode(body));
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     ToastMessageHelper.showToastMessage('Your Account Information Deleted!');
  //     Get.offAllNamed(AppRoutes.loginScreen);
  //
  //     deleteLoading(false);
  //   } else {
  //     ToastMessageHelper.showToastMessage('${response.body["message"]}');
  //     deleteLoading(false);
  //   }
  // }
}
