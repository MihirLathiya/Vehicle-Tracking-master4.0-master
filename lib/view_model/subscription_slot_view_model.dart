import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/access_control_repo.dart';
import 'package:vehicletracking/models/repo/sub_slot_repo.dart';
import 'package:vehicletracking/models/response_model/access_controll_res_model.dart';
import 'package:vehicletracking/models/response_model/sub_slot_res_model.dart';

class SubscriptionSlotDetailsViewModel extends GetxController {
  ApiResponse _subscriptionSlotDetailApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get subscriptionSlotDetailApiResponse =>
      _subscriptionSlotDetailApiResponse;

  Future<void> subscriptionSlotDetailsViewModel({String id}) async {
    _subscriptionSlotDetailApiResponse =
        ApiResponse.loading(message: 'Loading');
    update();
    try {
      SubscriptionSlotResponseModel response =
          await SubscriptionSlotDetailsRepo()
              .subscriptionSlotDetailsRepo(id: id);
      print("SubscriptionSlotResponseModel=response==>$response");

      _subscriptionSlotDetailApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("SubscriptionSlotResponseModel=e==>$e");
      _subscriptionSlotDetailApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  ///    ACCESS CONTROLLERS REPO
  ///
  ///
  ///
  ///

  ApiResponse _accessApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get accessApiResponse => _accessApiResponse;

  Future<void> accessControllerViewModel({String placeId}) async {
    _accessApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AccessControlResponseModel responses =
          await AccessControlRepo().accessControlRepo(placeId: placeId);
      print("AccessControlResponseModel=response==>$responses");

      _accessApiResponse = ApiResponse.complete(responses);
    } catch (e) {
      print("AccessControlResponseModel=e==>$e");
      _accessApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
