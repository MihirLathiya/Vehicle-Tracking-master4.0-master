import 'package:vehicletracking/models/response_model/create_password_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class CreatePasswordRepo extends BaseService {
  Future<CreatePasswordResponseModel> createPasswordRepo(
      {Map<String, dynamic> body}) async {
    var response = await APIService()
        .getResponse(url: createPassword, body: body, apitype: APIType.aPost);

    CreatePasswordResponseModel createPasswordResponseModel =
        await CreatePasswordResponseModel.fromJson(response);
    print('CreatePasswordResponseModel $response');
    return createPasswordResponseModel;
  }
}
