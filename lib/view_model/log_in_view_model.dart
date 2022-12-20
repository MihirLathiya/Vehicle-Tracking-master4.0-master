import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/repo/log_in_repo.dart';
import 'package:vehicletracking/models/response_model/login_res_model.dart';

class LogInViewViewModel extends GetxController {
  ApiResponse _logInApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get logInApiResponse => _logInApiResponse;
  bool isLoading = false;
  void updateLoading(bool v) {
    isLoading = v;
    update();
  }

  Future<void> logInViewViewModel({Map<String, dynamic> model}) async {
    _logInApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      updateLoading(true);
      LogInResponseModel response = await LogInRepo().logInRepo(body: model);
      print("LogInResponseModel=response==>$response");

      _logInApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LogInResponseModel=e==>$e");
      _logInApiResponse = ApiResponse.error(message: 'error');
      updateLoading(false);
    }
    update();
  }
}
