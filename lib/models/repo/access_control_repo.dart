import 'package:vehicletracking/models/response_model/access_controll_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class AccessControlRepo extends BaseService {
  Future<AccessControlResponseModel> accessControlRepo({String placeId}) async {
    var response = await APIService()
        .getResponse(url: '${accessControl}$placeId', apitype: APIType.aGet);

    AccessControlResponseModel accessControlResponseModel =
        await AccessControlResponseModel.fromJson(response);
    print('AccessControlResponseModel $response');
    return accessControlResponseModel;
  }
}
