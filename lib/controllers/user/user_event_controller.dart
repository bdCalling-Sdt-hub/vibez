import 'package:get/get.dart';
import 'package:seth/models/event_details_model.dart';
import 'package:seth/models/event_model.dart';

import '../../services/api_client.dart';
import '../../services/api_constants.dart';

class UserEventController extends GetxController{



  RxBool eventLoading = false.obs;
  RxList<EventModel> events = <EventModel>[].obs;
  fetchEvent({String? category})async{
    eventLoading(true);
    var response = await ApiClient.getData("${ApiConstants.eventEndPoint}?category=$category&radius=10");

    if(response.statusCode == 200){

      events.value = List<EventModel>.from(response.body["data"].map((x)=> EventModel.fromJson(x)));
      eventLoading(false);
    }else{
      eventLoading(false);
    }
  }



  RxBool eventDetailsLoading = false.obs;
  Rx<EventDetailsModel> eventDetails = EventDetailsModel().obs;

  getEventDetails({required String id}) async {
    eventDetailsLoading(true);
    var response = await ApiClient.getData(ApiConstants.eventDetailsEndPoint("67b2d22962dbb279c693355c"));

    print('--------------------------------------------${response.body}');
    if (response.statusCode == 200) {
      var responseData = response.body;
      eventDetails.value = EventDetailsModel.fromJson(responseData['data']);
      eventDetailsLoading(false);
    } else if (response.statusCode == 404) {
      eventDetailsLoading(false);
    }
  }

}