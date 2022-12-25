import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/get_parking_slot_repo.dart';
import 'package:vehicletracking/models/response_model/get_parking_slot_res_model.dart';
import 'package:vehicletracking/pages/auth/sign_in.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';

class GetParkingSlotViewModel extends GetxController {
  TextEditingController des = TextEditingController();

  updateText(value) {
    des.text = value;
    // update();
  }

  ApiResponse _getParkingSlotApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getParkingSlotApiResponse => _getParkingSlotApiResponse;

  Future<void> getParkingSlotViewModel(
      {bool loading = true, accountNo, placeId = '1'}) async {
    if (loading) {
      _getParkingSlotApiResponse = ApiResponse.loading(message: 'Loading');
    }
    update();
    try {
      GetParkingSlotResponseModel response = await GetParkingSlotRepo()
          .getParkingSlotRepo(accountNo: accountNo, placeId: placeId);
      print("getParkingSlotResponseModel=response==>$response");

      _getParkingSlotApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("getParkingSlotResponseModel=e==>$e");

      Get.offAll(() => SignInScreen());
      PreferenceManager.getClear();
      _getParkingSlotApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
