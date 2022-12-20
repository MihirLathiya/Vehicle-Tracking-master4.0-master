import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/update_profile_repo.dart';
import 'package:vehicletracking/models/response_model/update_profile_res_model.dart';

class UpdateProfileViewModel extends GetxController {
  ApiResponse _updateProfileApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get updateProfileApiResponse => _updateProfileApiResponse;
  bool isLoading = false;
  void updateLoading(bool v) {
    isLoading = v;
    update();
  }

  Future<void> updateProfileViewModel({Map<String, dynamic> model}) async {
    _updateProfileApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      updateLoading(true);

      UpdateProfileResponseModel response =
          await UpdateProfileRepo().updateProfileRepo(body: model);
      print("UpdateProfileResponseModel=response==>$response");

      _updateProfileApiResponse = ApiResponse.complete(response);
    } catch (e) {
      updateLoading(false);

      print("UpdateProfileResponseModel=e==>$e");
      _updateProfileApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
