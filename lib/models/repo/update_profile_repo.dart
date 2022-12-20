import 'package:vehicletracking/models/response_model/update_profile_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class UpdateProfileRepo extends BaseService {
  Future<UpdateProfileResponseModel> updateProfileRepo(
      {Map<String, dynamic> body}) async {
    var response = await APIService()
        .getResponse(url: updateProfile, body: body, apitype: APIType.aPost);

    UpdateProfileResponseModel updateProfileResponseModel =
        await UpdateProfileResponseModel.fromJson(response);
    print('UpdateProfileResponseModel $response');
    return updateProfileResponseModel;
  }
}
