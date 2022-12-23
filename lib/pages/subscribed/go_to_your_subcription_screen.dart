import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/pages/not_subscribed/choose_plan_screen.dart';
import 'package:vehicletracking/pages/not_subscribed/parking_slot_screen.dart';
import 'package:vehicletracking/pages/subscribed/subscription_details.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/add_number_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';
import 'package:vehicletracking/widgets/app_text_form_field.dart';

class GotoYourSubscriptionScreen extends StatefulWidget {
  const GotoYourSubscriptionScreen({Key key}) : super(key: key);

  @override
  State<GotoYourSubscriptionScreen> createState() =>
      _GotoYourSubscriptionScreenState();
}

class _GotoYourSubscriptionScreenState
    extends State<GotoYourSubscriptionScreen> {
  RxBool isTermAgree = false.obs;
  RxBool isAutoRenewal = true.obs;
  bool isLoading = false;
  dynamic accessx;

  TextEditingController remove = TextEditingController();
  List<String> items = ["Camera", "Phone", "Image", "Video"];
  String selectedItem = "Camera";
  dynamic data;
  TextEditingController vehicleNumber = TextEditingController();

  AddNumberViewModel addNumberViewModel = Get.put(AddNumberViewModel());
  bool isAvailable = false;
  List vehicleNumberList = [];
  List vehicleNumberList1 = [];
  int Counter = 1;
  List slotName = [];
  int x = 0;
  List slots = ['Yes', 'No'];
  @override
  void initState() {
    vehicleNumberList.insert(Counter - 1, vehicleNumber);
    getSubDetails();
    super.initState();
  }

  getSubDetails() async {
    setState(() {
      isLoading = false;
    });
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = await http.get(
        Uri.parse('https://i.invoiceapi.ml/api/customer/subscriptionDetails'),
        headers: headers);

    if (request.statusCode == 200) {
      data = jsonDecode(request.body);
      log('SUBSCRIPTION DETAILS :- ${data}');

      setState(() {
        isLoading = true;
      });
    } else {
      print(request.reasonPhrase);
      setState(() {
        isLoading = false;
      });
    }
  }

  dynamic slotNames;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            AppAsset.bgGroundTop,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Image.asset(
                      AppAsset.subscriptionTopImage,
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 310.0, left: 15, right: 15),
                  child: isLoading == true
                      ? Column(
                          children: <Widget>[
                            const Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Subscription Details',
                                style: AppTextStyle.bold20,
                              ),
                            ),
                            height15,
                            subscriptionDetailsWidget(),
                            height15,
                            if ((data['data'] as List).length > 0)
                              bottomButtons(),
                            if ((data['data'] as List).length == 0)
                              Text('Buy Subscription first'),
                            height15,
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget subscriptionDetailsWidget() {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: (data['data'] as List).length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 15),
          width: Get.width,
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(
              color: borderGreyColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    height10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: Text(
                            'Contract Date',
                            style: AppTextStyle.normalSemiBold16.copyWith(
                              color: greyColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 3,
                          child: TextField(
                            enabled: false,
                            style: AppTextStyle.normalRegular14,
                            controller: TextEditingController(
                                text:
                                    '${data['data'][index]['strt_date'].toString().split(' ').first}'),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    height25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: Text(
                            'Amount',
                            style: AppTextStyle.normalSemiBold16.copyWith(
                              color: greyColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 3,
                          child: TextField(
                            enabled: false,
                            style: AppTextStyle.normalRegular14,
                            controller: TextEditingController(
                                text:
                                    '${data['data'][index]['subscription_amount']}/-'),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    height25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: Text(
                            'Parking Number',
                            style: AppTextStyle.normalSemiBold16.copyWith(
                              color: greyColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 3,
                          child: TextField(
                            enabled: false,
                            style: AppTextStyle.normalRegular14,
                            controller: TextEditingController(text: 'B1-02'),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    height25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: Text(
                            'Slot Quantity',
                            style: AppTextStyle.normalSemiBold16.copyWith(
                              color: greyColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 3,
                          child: TextField(
                            enabled: false,
                            style: AppTextStyle.normalRegular14,
                            controller: TextEditingController(
                                text:
                                    '${data['data'][index]['slot_quantity']}'),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    height25,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: Text(
                            'Location',
                            style: AppTextStyle.normalSemiBold16.copyWith(
                              color: greyColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width / 3,
                          child: TextField(
                            enabled: false,
                            style: AppTextStyle.normalRegular14,
                            controller: TextEditingController(
                                text:
                                    '${data['data'][index]['parking_location']}'),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                    height25,
                    slotAddOrRemoveButtons(data['data'][index]['id'], index),
                    height10,
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  log('DATA ID :- ${data['data'][index]['id']}');
                  PreferenceManager.setPlaceId(
                      data['data'][index]['place_id'].toString());
                  await getAccessData(
                      data['data'][index]['place_id'].toString());
                  Get.to(() => SubscriptionDetailsScreen(
                      accessx: accessx,
                      id: data['data'][index]['id'].toString(),
                      placeId: data['data'][index]['place_id'].toString()));
                },
                child: Container(
                  height: 50,
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: AppTextStyle.normalRegular16.copyWith(
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget slotAddOrRemoveButtons(slotId, index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            if (data['data'][index]['parking_type'] == 'Open') {
              var headers = {
                'Authorization': 'Bearer ${PreferenceManager.getBariear()}'
              };
              var request = http.MultipartRequest('POST',
                  Uri.parse('https://i.invoiceapi.ml/api/customer/removeSlot'));
              request.fields.addAll({'slot_id': slotId.toString()});

              request.headers.addAll(headers);

              http.StreamedResponse response = await request.send();

              if (response.statusCode == 200) {
                print(await response.stream.bytesToString());
                CommonSnackBar.commonSnackBar(
                    message: 'slot remove Request send');
              } else {
                print(response.reasonPhrase);
              }
            } else {
              getSubDetails1(data['data'][index]['id']);
              renewalPopup1(slotId.toString());
              setState(() {});

              // Get.to(
              //   () => ParkingSlotScreen(
              //     duration: PreferenceManager.getDuration(),
              //     location: PreferenceManager.getName1(),
              //     placeId: data['data'][index]['parking_type'],
              //     slotQuntity: data['data'][index]['parking_type'],
              //     slotType: 'reserved',
              //     vehicleType: 'Two wheel',
              //   ),
              // );
            }
          },
          child: Container(
            width: Get.width / 2.5,
            padding: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: blackColor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Icon(
                  Icons.remove,
                ),
                // const SizedBox(
                //   width: 15,
                // ),
                Text(
                  'Remove Slot',
                  style: AppTextStyle.normalRegular16.copyWith(
                      // fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            renewalPopup(index, data['data'][index]['parking_type'],
                data['data'][index]['id']);
          },
          child: Container(
            width: Get.width / 2.5,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: blackColor,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Icon(
                  Icons.add,
                ),
                Text(
                  'Add Slot',
                  style: AppTextStyle.normalRegular16.copyWith(
                      // fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomButtons() {
    return Row(
      children: [
        Expanded(
          child: AppFillButton(
            title: 'Renew',
            radius: 15,
            height: 50,
            onTap: () {
              renewalPopup(0, '', '');
            },
          ),
        ),
        width15,
        Expanded(
          child: AppBorderButton(
            title: 'Cancel',
            height: 50,
            radius: 15,
            onTap: () {
              cancelPopup();
            },
          ),
        ),
      ],
    );
  }

  getAccessData(placeId) async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = await http.get(
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/getAccessControls?place_id=${placeId == null ? PreferenceManager.getPlaceId() : placeId}'),
        headers: headers);

    if (request.statusCode == 200) {
      accessx = jsonDecode(await request.body);
      print('GET DATA :- $accessx');
      setState(() {});
    } else {
      print(request.reasonPhrase);
    }
  }

  void cancelPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            children: <Widget>[
              const Text(
                'Are you sure you want to Cancel your Current Subscription?',
                textAlign: TextAlign.center,
                style: AppTextStyle.normalSemiBold16,
              ),
              height20,
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      value: isTermAgree.value,
                      fillColor: MaterialStateProperty.all(appColor),
                      activeColor: appColor,
                      onChanged: (bool value) {
                        isTermAgree.value = value ?? false;
                      },
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'I Agree to the ',
                          style: AppTextStyle.normalRegular16.copyWith(
                            color: greyColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: AppTextStyle.normalRegular16.copyWith(
                            color: appColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height20,
              Row(
                children: [
                  Expanded(
                    child: AppBorderButton(
                      title: 'No, Go Back',
                      radius: 10,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                  width05,
                  Expanded(
                    child: AppFillButton(
                      title: 'Yes, I’m Sure',
                      radius: 10,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
              height10,
            ],
          ),
        );
      },
    );
  }

  void renewalPopup(index, type, subId) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        FocusNode passFocus = FocusNode();

        return StatefulBuilder(
          builder: (context, state) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 16,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: remove,
                      focusNode: passFocus,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      onEditingComplete: () async {
                        log('VEHICLE TYPE :- ${data['data'][index]['vehicle_type']}');
                        passFocus.unfocus();
                      },
                      decoration: InputDecoration(
                        label: const Text('Slot*'),
                        contentPadding: const EdgeInsets.all(
                          20,
                        ),
                        hintText: 'Slot*',
                        hintStyle: AppTextStyle.normalRegular14
                            .copyWith(color: greyColor),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  height20,
                  // const Text(
                  //   'Auto Renewal',
                  //   style: AppTextStyle.normalSemiBold16,
                  // ),
                  // const Divider(
                  //   color: borderGreyColor,
                  // ),
                  // Row(
                  //   children: [
                  //     ...List.generate(
                  //       2,
                  //       (index) => Row(
                  //         children: [
                  //           Text('${slots[index]}'),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           GestureDetector(
                  //             onTap: () {
                  //               state(() {
                  //                 x = index;
                  //               });
                  //               remove.clear();
                  //             },
                  //             child: Container(
                  //               height: 20,
                  //               width: 20,
                  //               padding: EdgeInsets.all(2),
                  //               decoration: BoxDecoration(
                  //                 shape: BoxShape.circle,
                  //                 border: Border.all(color: Colors.red),
                  //               ),
                  //               child: CircleAvatar(
                  //                   backgroundColor: x == index
                  //                       ? Colors.red
                  //                       : Colors.transparent),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 30,
                  //           )
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                  height20,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          isTermAgree.value = !isTermAgree.value;
                        },
                        child: Obx(
                          () => isTermAgree.value
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: appColor),
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: whiteColor,
                                    size: 18,
                                  ),
                                )
                              : Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: appColor),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'I Agree to the ',
                                style: AppTextStyle.normalRegular16.copyWith(
                                  color: greyColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: AppTextStyle.normalRegular16.copyWith(
                                  color: appColor,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  height20,
                  Row(
                    children: [
                      Expanded(
                        child: AppBorderButton(
                          title: 'Cancel',
                          height: 45,
                          radius: 10,
                          onTap: () {
                            remove.clear();
                            Get.back();
                          },
                        ),
                      ),
                      width15,
                      Expanded(
                        child: AppFillButton(
                          title: 'Proceed',
                          radius: 10,
                          height: 45,
                          onTap: () async {
                            // Get.to(() => const PaymentScreen());
                            if (remove.text.isNotEmpty) {
                              if (isTermAgree.value) {
                                var headers = {
                                  'Authorization':
                                      'Bearer ${PreferenceManager.getBariear()}'
                                };
                                var request = await http.post(
                                    Uri.parse(
                                        'https://i.invoiceapi.ml/api/customer/chackSlotAvailability'),
                                    body: {
                                      'subscription_id': '${subId}',
                                      'parking_type':
                                          type == 'Open' ? 'Open' : 'reserved',
                                      'slot_quantity': '${remove.text}'
                                    },
                                    headers: headers);

                                if (request.statusCode == 200) {
                                  log('AVAIBLITY :- ${await request.body}');
                                  var x = jsonDecode(await request.body);
                                  if (x['status'] == true) {
                                    if (type == 'Open' || type == 'open') {
                                      log('TYPE IS OPEN');
                                      showAddDialog(index);
                                      // var headers = {
                                      //   'Authorization':
                                      //       'Bearer ${PreferenceManager.getBariear()}'
                                      // };
                                      // var request = http.MultipartRequest(
                                      //     'POST',
                                      //     Uri.parse(
                                      //         'https://i.invoiceapi.ml/api/customer/addSlot'));
                                      // request.fields.addAll({
                                      //   'subscription_id': '${subId}',
                                      //   'parking_type': 'Open',
                                      //   'slot_quantity': '${remove.text}',
                                      // });
                                      //
                                      // request.headers.addAll(headers);
                                      //
                                      // http.StreamedResponse response =
                                      //     await request.send();
                                      //
                                      // if (response.statusCode == 200) {
                                      //   print(await response.stream
                                      //       .bytesToString());
                                      //   CommonSnackBar.commonSnackBar(
                                      //       message: 'Successfully added');
                                      //
                                      //   Get.offAll(() => SlotDetailsScreen());
                                      // } else {
                                      //   Get.back();
                                      //   log('ERROR:- ${response.reasonPhrase}');
                                      //   CommonSnackBar.commonSnackBar(
                                      //       message: 'Something went wrong');
                                      // }
                                    } else {
                                      PreferenceManager.setPlaceId(data['data']
                                              [index]['place_id']
                                          .toString());
                                      PreferenceManager.setDuration(data['data']
                                                  [index]['paln_duration'] ==
                                              null
                                          ? '1 month'
                                          : '${data['data'][index]['paln_duration']}');
                                      Get.back();
                                      Get.to(
                                        () => ParkingSlotScreen(
                                          dataVehicle: data['data'][index]
                                              ['vehicle_type'],
                                          subId: data['data'][index]['id'],
                                          vehicleType: data['data'][index]
                                              ['vehicle_type'],
                                          slotType: data['data'][index]
                                              ['parking_type'],
                                          slotQuntity: remove.text,
                                          placeId: data['data'][index]
                                              ['place_id'],
                                          location: data['data'][index]
                                              ['parking_location'],
                                          duration: data['data'][index]
                                              ['paln_duration'],
                                        ),
                                      );
                                      // remove.clear();
                                    }
                                  }

                                  passFocus.unfocus();
                                  log('AVAIBLITY :- $isAvailable');
                                } else {
                                  print(request.reasonPhrase);
                                  CommonSnackBar.commonSnackBar(
                                      message: 'Slot not available');
                                }
                              } else {
                                CommonSnackBar.commonSnackBar(
                                    message: 'Accept condition');
                              }
                            } else {
                              CommonSnackBar.commonSnackBar(
                                  message: 'Add slot count');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  height10,
                ],
              ),
            );
          },
        );
      },
    );
  }

  void renewalPopup1(slotId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, state) {
            Future.delayed(Duration.zero, () {
              state(() {});
            });
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 16,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                children: <Widget>[
                  DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Slot*',
                              style: AppTextStyle.normalRegular14
                                  .copyWith(color: greyColor, fontSize: 16),
                            ),
                          ),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: blackColor,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                        iconSize: 0.0,
                        hint: slotNames == null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text('Slot',
                                    style: AppTextStyle.normalRegular14
                                        .copyWith(color: greyColor)),
                              )
                            : Text(
                                slotNames
                                    .toString()
                                    .split('..')
                                    .first
                                    .toString(),
                                style: const TextStyle(color: blackColor),
                              ),
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(30),
                        style: const TextStyle(color: blackColor),
                        items: slotName.map(
                          (val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child:
                                    Text('${val.toString().split('..').first}'),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              slotNames = val.toString();
                            },
                          );
                          print(
                              'SlotNAMES VALUE :- ${slotNames.toString().split('..').last}');
                        },
                      ),
                    ),
                  ),
                  height10,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          isTermAgree.value = !isTermAgree.value;
                        },
                        child: Obx(
                          () => isTermAgree.value
                              ? Container(
                                  height: 20,
                                  width: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: appColor),
                                  ),
                                  child: const Icon(
                                    Icons.check_rounded,
                                    color: whiteColor,
                                    size: 18,
                                  ),
                                )
                              : Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: appColor),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'I Agree to the ',
                                style: AppTextStyle.normalRegular16.copyWith(
                                  color: greyColor,
                                ),
                              ),
                              TextSpan(
                                text: 'Terms & Conditions',
                                style: AppTextStyle.normalRegular16.copyWith(
                                  color: appColor,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  height20,
                  Row(
                    children: [
                      Expanded(
                        child: AppBorderButton(
                          title: 'Cancel',
                          height: 45,
                          radius: 10,
                          onTap: () {
                            Get.back();
                          },
                        ),
                      ),
                      width15,
                      Expanded(
                        child: AppFillButton(
                          title: 'Proceed',
                          radius: 10,
                          height: 45,
                          onTap: () async {
                            if (isTermAgree.value == true) {
                              var headers = {
                                'Authorization':
                                    'Bearer ${PreferenceManager.getBariear()}'
                              };
                              var request = http.MultipartRequest(
                                  'POST',
                                  Uri.parse(
                                      'https://i.invoiceapi.ml/api/customer/removeSlot'));
                              request.fields.addAll({
                                'slot_id':
                                    '${slotNames.toString().split('..').last}'
                              });

                              request.headers.addAll(headers);

                              http.StreamedResponse response =
                                  await request.send();

                              if (response.statusCode == 200) {
                                Get.back();
                                remove.clear();
                                print(await response.stream.bytesToString());
                                CommonSnackBar.commonSnackBar(
                                    message: 'slot remove Request send');
                              } else {
                                print(response.reasonPhrase);
                              }
                            } else {
                              CommonSnackBar.commonSnackBar(
                                  message: 'Accept Condition first');
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  height10,
                ],
              ),
            );
          },
        );
      },
    );
  }

  getSubDetails1(id) async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = await http.get(
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/subscriptionSlotDetails?subscription_id=$id'),
        headers: headers);

    if (request.statusCode == 200) {
      var data = jsonDecode(request.body);
      log('Slot data :- ${data}');
      slotName.clear();
      for (int i = 0; i < (data['data'] as List).length; i++) {
        slotName.insert(
            i, '${data['data'][i]['parking_name']}..${data['data'][i]['id']}');
      }
      slotNames = slotName[0].toString().split('..').first;

      log('HELLO $slotName');
      setState(() {});
    } else {
      print(request.reasonPhrase);
    }
  }

  void showAddDialog(index) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState1) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 16,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: Counter,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          AppTextField(
                            labelText: 'Vehicle Number',
                            controller: vehicleNumberList[index],
                          ),
                          height15,
                        ],
                      );
                    },
                  ),
                  height15,
                  GestureDetector(
                    onTap: () {
                      setState1(() {
                        Counter++;
                        vehicleNumberList.insert(
                            Counter - 1, TextEditingController());
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Icon(
                          Icons.add,
                          color: appColor,
                        ),
                        Text(
                          'Add More',
                          style: AppTextStyle.normalSemiBold16.copyWith(
                            color: appColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  height15,
                  Row(
                    children: [
                      Expanded(
                        child: AppBorderButton(
                          onTap: () {
                            Get.back();
                          },
                          title: 'Back',
                          height: 45,
                          radius: 10,
                        ),
                      ),
                      width10,
                      Expanded(
                        child: AppFillButton(
                          onTap: () async {
                            if (vehicleNumber.text.isNotEmpty) {
                              vehicleNumberList1.clear();
                              for (int i = 0;
                                  i < vehicleNumberList.length;
                                  i++) {
                                vehicleNumberList1.insert(
                                    i, vehicleNumberList[i].text);
                              }
                              log('HELLO LISTS :- ${vehicleNumberList1}');
                              await addNumberViewModel.addNumberViewModel(
                                  model: {
                                    'vehicle_number': '$vehicleNumberList1'
                                  });
                              if (addNumberViewModel
                                      .addNumberApiResponse.status ==
                                  Status.COMPLETE) {
                                // PreferenceManager.setDuration(duration);

                                PreferenceManager.setDuration(data['data']
                                            [index]['paln_duration'] ==
                                        null
                                    ? '1 month'
                                    : '${data['data'][index]['paln_duration']}');
                                Get.to(() => ChoosePlanScreen(
                                      subId:
                                          data['data'][index]['id'].toString(),
                                      placeId: data['data'][index]['place_id']
                                          .toString(),
                                      duration:
                                          '${data['data'][index]['paln_duration'].toString() ?? '1 month'}',
                                      location: data['data'][index]
                                              ['parking_location']
                                          .toString(),
                                      vehicleType: data['data'][index]
                                              ['vehicle_type'] ??
                                          'Two wheel',
                                      vehicleNumber: vehicleNumberList1,
                                      slotType: x == 0 ? 'open' : 'reserved',
                                      slotQuntity: remove.text.toString(),
                                      // slotList: ,
                                    ));

                                // remove.clear();
                              } else {
                                CommonSnackBar.commonSnackBar(
                                    message: 'Try Again...');
                              }
                            } else {
                              log('ENTER NO');
                            }
                          },
                          title: 'Next',
                          height: 45,
                          radius: 10,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
