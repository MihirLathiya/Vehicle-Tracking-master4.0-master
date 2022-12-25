import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/view_model/access_controller_view_model.dart';

class DropDownDemo extends StatefulWidget {
  const DropDownDemo({Key key}) : super(key: key);

  @override
  State<DropDownDemo> createState() => _DropDownDemoState();
}

class _DropDownDemoState extends State<DropDownDemo> {
  dynamic data;
  List defaultList = [];

  getSubDetails(id) async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = await http.get(
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/subscriptionSlotDetails?subscription_id=$id'),
        headers: headers);

    if (request.statusCode == 200) {
      data = jsonDecode(request.body);
      for (int i = 0; i < (data['data'] as List).length; i++) {
        defaultList.insert(i, data['data'][i]['access_control'][0]);
      }

      log('SUBSCRIBE SLOT DATA :- $data');
    } else {
      print(request.reasonPhrase);
    }
  }

  AccessController accessController = Get.put(AccessController());

  @override
  void initState() {
    getSubDetails(2);
    accessController.accessControllerViewModel(id: '1');
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: (data['data'] as List).length,
              itemBuilder: (context, index) {
                return GetBuilder<AccessController>(builder: (controller) {
                  if (controller.accessApiResponse.status == Status.LOADING) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.accessApiResponse.status == Status.COMPLETE) {
                    return SizedBox(
                      width: Get.width / 3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            DropdownButton(
                              hint: Text('${defaultList[index]}'),
                              isExpanded: false,
                              isDense: true,
                              underline: const SizedBox(),
                              onChanged: (value) {
                                setState(() {
                                  defaultList[index] = value;
                                });
                              },
                              items: data['data'][index]['access_control']
                                  .map<DropdownMenuItem>(
                                (value) {
                                  print('value----${value}');
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      '$value',
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                });
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 20,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
