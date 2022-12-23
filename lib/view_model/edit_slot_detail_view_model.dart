import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/edit_slot_detail_repo.dart';
import 'package:vehicletracking/models/response_model/edit_slot_detail_res_model.dart';

class EditSlotDetailViewModel extends GetxController {
  ApiResponse _editSlotDetailApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get editSlotDetailApiResponse => _editSlotDetailApiResponse;

  bool isLoading = false;
  void updateLoading(bool v) {
    isLoading = v;
    update();
  }

  Future<void> editSlotDetailViewModel({
    Map<String, dynamic> model,
  }) async {
    _editSlotDetailApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      updateLoading(true);
      EditSlotDetailsResponseModel response =
          await EditSlotDetailRepo().editSlotDetailRepo(
        body: model,
      );
      print("EditSlotDetailsResponseModel=response==>$response");

      _editSlotDetailApiResponse = ApiResponse.complete(response);
    } catch (e) {
      updateLoading(false);
      print("EditSlotDetailsResponseModel=e==>$e");
      _editSlotDetailApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
