import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/forgot_password_repo.dart';
import 'package:vehicletracking/models/response_model/forgot_password_res_model.dart';

class ForgotPasswordViewViewModel extends GetxController {
  ApiResponse _forgotPasswordApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get forgotPasswordApiResponse => _forgotPasswordApiResponse;
  bool isLoading = false;
  void updateLoading(bool v) {
    isLoading = v;
    update();
  }

  Future<void> forgotPasswordViewViewModel({Map<String, dynamic> model}) async {
    _forgotPasswordApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      updateLoading(true);
      ForgotPasswordResponseModel response = await ForgotPasswordPasswordRepo()
          .forgotPasswordPasswordRepo(body: model);
      print("ForgotPasswordResponseModel=response==>$response");

      _forgotPasswordApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("ForgotPasswordResponseModel=e==>$e");
      _forgotPasswordApiResponse = ApiResponse.error(message: 'error');
      updateLoading(false);
    }
    update();
  }
}
