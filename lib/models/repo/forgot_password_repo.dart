import 'package:vehicletracking/models/response_model/forgot_password_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class ForgotPasswordPasswordRepo extends BaseService {
  Future<ForgotPasswordResponseModel> forgotPasswordPasswordRepo(
      {Map<String, dynamic> body}) async {
    var response = await APIService()
        .getResponse(url: forgotPassword, body: body, apitype: APIType.aPost);

    ForgotPasswordResponseModel forgotPasswordResponseModel =
        await ForgotPasswordResponseModel.fromJson(response);
    print('ForgotPasswordResponseModel $response');
    return forgotPasswordResponseModel;
  }
}
