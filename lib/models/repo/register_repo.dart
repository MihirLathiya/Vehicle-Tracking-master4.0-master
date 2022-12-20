import 'package:vehicletracking/models/response_model/register_user_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class RegisterRepo extends BaseService {
  Future<RegisterUserResponseModel> registerRepo(
      {Map<String, dynamic> body}) async {
    var response = await APIService()
        .getResponse(url: register, body: body, apitype: APIType.aPost);

    RegisterUserResponseModel registerUserResponseModel =
        await RegisterUserResponseModel.fromJson(response);
    print('RESPONSE $response');
    return registerUserResponseModel;
  }
}
