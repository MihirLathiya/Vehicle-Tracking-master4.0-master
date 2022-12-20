import 'package:vehicletracking/models/response_model/login_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class LogInRepo extends BaseService {
  Future<LogInResponseModel> logInRepo({Map<String, dynamic> body}) async {
    var response = await APIService()
        .getResponse(url: logIn, body: body, apitype: APIType.aPost);

    LogInResponseModel logInResponseModel =
        await LogInResponseModel.fromJson(response);
    print('LogInResponseModel $response');
    return logInResponseModel;
  }
}
