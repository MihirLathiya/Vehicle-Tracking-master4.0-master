import 'package:vehicletracking/models/response_model/edit_slot_detail_res_model.dart';
import 'package:vehicletracking/models/services/api_service.dart';
import 'package:vehicletracking/models/services/base_service.dart';

class EditSlotDetailRepo extends BaseService {
  Future<EditSlotDetailsResponseModel> editSlotDetailRepo(
      {Map<String, dynamic> body, id}) async {
    var response = await APIService().getResponse(
        url: 'https://i.invoiceapi.ml/api/customer/editSlotDetails',
        body: body,
        apitype: APIType.aPost);

    EditSlotDetailsResponseModel editSlotDetailsResponseModel =
        await EditSlotDetailsResponseModel.fromJson(response);
    print('EditSlotDetailsResponseModel $response');
    return editSlotDetailsResponseModel;
  }
}
