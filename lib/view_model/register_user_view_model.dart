import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/register_repo.dart';
import 'package:vehicletracking/models/response_model/register_user_res_model.dart';

class RegisterUserViewModel extends GetxController {
  ApiResponse _registerUserApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get registerUserApiResponse => _registerUserApiResponse;
  bool isLoading = false;
  void updateLoading(bool v) {
    isLoading = v;
    update();
  }

  Future<void> registerUserViewModel({Map<String, dynamic> model}) async {
    _registerUserApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      updateLoading(true);
      RegisterUserResponseModel response =
          await RegisterRepo().registerRepo(body: model);
      print("RegisterUserResponseModel=response==>$response");

      _registerUserApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("RegisterUserResponseModel=e==>$e");
      _registerUserApiResponse = ApiResponse.error(message: 'error');
      updateLoading(false);
    }
    update();
  }
}
