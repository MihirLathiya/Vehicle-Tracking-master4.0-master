import 'dart:convert';
import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/pages/payment/order_summary_screen.dart';
import 'package:vehicletracking/pages/subscribed/slot_details_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/access_controller_view_model.dart';
import 'package:vehicletracking/view_model/cancle_sub_view_model.dart';
import 'package:vehicletracking/view_model/edit_slot_detail_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';
import 'package:vehicletracking/widgets/app_text_form_field.dart';

class SubscriptionDetailsScreen extends StatefulWidget {
  final id;
  final placeId;
  final accessx;
  const SubscriptionDetailsScreen(
      {Key key, this.id, this.placeId, this.accessx})
      : super(key: key);

  @override
  State<SubscriptionDetailsScreen> createState() =>
      _SubscriptionDetailsScreenState();
}

class _SubscriptionDetailsScreenState extends State<SubscriptionDetailsScreen> {
  // TextEditingController parkingTypeController = TextEditingController();
  // TextEditingController parkingNumberController = TextEditingController();
  // TextEditingController startingDateController = TextEditingController();
  // TextEditingController endDateController = TextEditingController();
  // TextEditingController autoRenewwal = TextEditingController();
  // TextEditingController accessControlsController = TextEditingController();

  List accessData = ['Select'];
  List data1 = ['Select'];
  // List<String> items = ["Camera", "Phone", "Image", "Video"];
  List selectedItem = [];
  AccessController accessController = Get.put(AccessController());

  RxBool isReserved = true.obs;
  RxBool isYearly = true.obs;
  RxBool isAutoRenewal = true.obs;
  RxBool isTermAgree = false.obs;
  List<String> accesControll = [];
  List accesControllName = [];
  List accesControllPrice = [];
  TextEditingController header = TextEditingController();
  TextEditingController des = TextEditingController();

  RxList commonCheckboxValue = [
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs,
    false.obs
  ].obs;
  List changeAccessControlList = [];
  List changeAccessControlId = [];
  List changeAccessControlPrice = [];

  // SubscriptionDetailsViewModel subscriptionDetailsViewModel =
  //     Get.put(SubscriptionDetailsViewModel());
  dynamic data;
  bool isLoading = false;
  EditSlotDetailViewModel editSlotDetailViewModel =
      Get.put(EditSlotDetailViewModel());

  CancleSubViewModel cancleSubViewModel = Get.put(CancleSubViewModel());

  getSubDetails(id) async {
    setState(() {
      isLoading = false;
    });
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = await http.get(
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/subscriptionSlotDetails?subscription_id=$id'),
        headers: headers);

    if (request.statusCode == 200) {
      data = jsonDecode(request.body);

      log('SUBSCRIBE SLOT DATA :- $data');
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

  getAccessControlle() async {
    log('GET PLACE ID:- ${widget.placeId}');
    await accessController.accessControllerViewModel(
        id: widget.placeId == null
            ? PreferenceManager.getPlaceId()
            : widget.placeId);
  }

  dynamic accessx;
  getAccessData() async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = await http.get(
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/getAccessControls?place_id=${widget.placeId == null ? PreferenceManager.getPlaceId() : widget.placeId}'),
        headers: headers);

    if (request.statusCode == 200) {
      accessx = jsonDecode(await request.body);
      print('GET DATA :- $accessx');
      setState(() {});
    } else {
      print(request.reasonPhrase);
    }
  }

  @override
  void initState() {
    accessx = widget.accessx;
    getAccessData();
    getSubDetails(widget.id);
    getAccessControlle();
    // subscriptionDetailsViewModel.subscriptionDetailsViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  AppAsset.subscriptionDetails,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 300.0, left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Details',
                          style: AppTextStyle.bold20,
                        ),
                      ),
                      isLoading == true
                          ? ListView.separated(
                              itemCount: (data['data'] as List).length,
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                        height: 15,
                                      ),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                log('DATAS :- ${data['data'][index]['access_control'].toString().replaceFirst('[', '').replaceAll(']', '')}');
                                fetchData(index);
                                return subscriptionDetailsWidget(
                                    index: index,
                                    parking_name: data['data'][index]
                                        ['parking_name'],
                                    parkingtype: data['data'][index]
                                        ['parking_type'],
                                    autoRenue:
                                        data['data'][index]['auto_renewal'] == 1
                                            ? 'Yes'
                                            : 'No',
                                    createdDate: data['data'][index]
                                            ['strt_date']
                                        .toString()
                                        .split(' ')
                                        .first,
                                    accessControllerList: data1,
                                    id: data['data'][index]['id'],
                                    slot_quantity: data['data'][index]
                                        ['slot_quantity'],
                                    subscriptionAmount: data['data'][index]
                                        ['subscription_amount'],
                                    placeId: data['data'][index]['place_id'],
                                    parking_number: data['data'][index]
                                        ['strt_date'],
                                    endDate: data['data'][index]['end_date']
                                        .toString()
                                        .split(' ')
                                        .first);
                              })
                          : CircularProgressIndicator(),
                    ],
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
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget subscriptionDetailsWidget(
      {createdDate,
      index,
      endDate,
      parking_number,
      id,
      placeId,
      List accessControllerList,
      slot_quantity,
      autoRenue,
      parkingtype,
      parking_name,
      subscriptionAmount}) {
    print(';--selectedItem--${selectedItem}');
    return Container(
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
          Container(
            height: 50,
            width: Get.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: greyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${index + 1}',
                  style: AppTextStyle.normalRegular16.copyWith(
                    color: whiteColor,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    bool x = autoRenue == 'Yes' ? true : false;
                    // setState(() {
                    isAutoRenewal.value = x;
                    // });
                    fetchData(index);

                    showEditDialog(id: id, renue: autoRenue);
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(AppAsset.editIcon),
                      width05,
                      Text(
                        'Edit',
                        style: AppTextStyle.normalSemiBold16.copyWith(
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                height10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Get.width / 3,
                      child: Text(
                        'Parking Type',
                        style: AppTextStyle.normalSemiBold16.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 3,
                      child: TextField(
                        textAlign: TextAlign.end,
                        enabled: false,
                        style: AppTextStyle.normalRegular14,
                        controller:
                            TextEditingController(text: '${parkingtype}'),
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
                        'Parking Name',
                        style: AppTextStyle.normalSemiBold16.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 3,
                      child: TextField(
                        textAlign: TextAlign.end,
                        enabled: false,
                        style: AppTextStyle.normalRegular14,
                        controller:
                            TextEditingController(text: '$parking_name'),
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
                        'Starting Date',
                        style: AppTextStyle.normalSemiBold16.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 3,
                      child: TextField(
                        textAlign: TextAlign.end,
                        enabled: false,
                        style: AppTextStyle.normalRegular14,
                        controller: TextEditingController(text: '$createdDate'),
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
                        'Ending Date',
                        style: AppTextStyle.normalSemiBold16.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 3,
                      child: TextField(
                        textAlign: TextAlign.end,
                        enabled: false,
                        style: AppTextStyle.normalRegular14,
                        controller: TextEditingController(text: '$endDate'),
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
                        'Auto Renewal',
                        style: AppTextStyle.normalSemiBold16.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 3,
                      child: TextField(
                        textAlign: TextAlign.end,
                        enabled: false,
                        style: AppTextStyle.normalRegular14,
                        controller: TextEditingController(text: autoRenue),
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
                        'Access Controls',
                        style: AppTextStyle.normalSemiBold16.copyWith(
                          color: greyColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            DropdownButton(
                              value: selectedItem[index],
                              isExpanded: false,
                              isDense: true,
                              underline: const SizedBox(),
                              onChanged: (value) {
                                setState(() {
                                  selectedItem[index] = value;
                                });
                              },
                              items: accessControllerList.map<DropdownMenuItem>(
                                (value) {
                                  print('value----${value}');
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          height10,
        ],
      ),
    );
  }

  void showEditDialog({id, renue}) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
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
                  // parkingType(),
                  // customHeight(30),
                  // changeContractPeriod(),
                  // customHeight(30),
                  changeAutoRenewal(renue),
                  customHeight(30),
                  const Text(
                    'Add Access Control',
                    style: AppTextStyle.normalSemiBold16,
                  ),
                  const Divider(
                    color: borderGreyColor,
                  ),
                  changeAccessControl(),
                  customHeight(30),
                  feedBack(setStateDialog),
                  customHeight(30),
                  bottomButtons(id: id),
                  height10,
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget parkingType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Change Parking Type',
          style: AppTextStyle.normalSemiBold16,
        ),
        const Divider(
          color: borderGreyColor,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reserved Parking',
              style: AppTextStyle.normalRegular14.copyWith(color: greyColor),
            ),
            Obx(
              () => Radio(
                value: true,
                groupValue: isReserved.value,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                fillColor: MaterialStateProperty.all(appColor),
                activeColor: appColor,
                onChanged: (value) {
                  setState(() {
                    isReserved.value = value as bool;
                  });
                  log('IS VALUR ${isReserved.value}');
                },
              ),
            ),
          ],
        ),
        height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Open Parking',
              style: AppTextStyle.normalRegular14.copyWith(color: greyColor),
            ),
            Obx(
              () => Radio(
                value: false,
                groupValue: isReserved.value,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                fillColor: MaterialStateProperty.all(appColor),
                activeColor: appColor,
                onChanged: (value) {
                  setState(() {
                    isReserved.value = value as bool;
                  });
                  log('IS VALUR1 ${isReserved.value}');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget changeContractPeriod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Change Contract Period',
          style: AppTextStyle.normalSemiBold16,
        ),
        const Divider(
          color: borderGreyColor,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Yearly',
              style: AppTextStyle.normalRegular14.copyWith(color: greyColor),
            ),
            Obx(
              () => Radio(
                value: true,
                groupValue: isYearly.value,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                fillColor: MaterialStateProperty.all(appColor),
                activeColor: appColor,
                onChanged: (value) {
                  setState(() {
                    isYearly.value = value as bool;
                  });
                  log('YEARLY ${isYearly.value}');
                },
              ),
            ),
          ],
        ),
        height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Montly',
              style: AppTextStyle.normalRegular14.copyWith(color: greyColor),
            ),
            Obx(
              () => Radio(
                value: false,
                groupValue: isYearly.value,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                fillColor: MaterialStateProperty.all(appColor),
                activeColor: appColor,
                onChanged: (value) {
                  setState(() {
                    isYearly.value = value as bool;
                  });
                  log('MONT ${isYearly.value}');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget changeAutoRenewal(renue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Change Auto Renewal',
          style: AppTextStyle.normalSemiBold16,
        ),
        const Divider(
          color: borderGreyColor,
        ),
        height10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Yes',
              style: AppTextStyle.normalRegular14.copyWith(color: greyColor),
            ),
            Obx(
              () => Radio(
                value: true,
                groupValue: isAutoRenewal.value,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                fillColor: MaterialStateProperty.all(appColor),
                activeColor: appColor,
                onChanged: (value) {
                  setState(() {
                    isAutoRenewal.value = value as bool;
                  });
                },
              ),
            ),
          ],
        ),
        height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'No',
              style: AppTextStyle.normalRegular14.copyWith(color: greyColor),
            ),
            Obx(
              () => Radio(
                value: false,
                groupValue: isAutoRenewal.value,
                visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                fillColor: MaterialStateProperty.all(appColor),
                activeColor: appColor,
                onChanged: (value) {
                  setState(() {
                    isAutoRenewal.value = value as bool;
                  });
                },
              ),
            ),
          ],
        ),
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
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: appColor,
                          border: Border.all(color: appColor),
                          borderRadius: BorderRadius.circular(5),
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
                          border: Border.all(color: appColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'I Agree to the ',
                    style: AppTextStyle.normalRegular14.copyWith(
                      color: greyColor,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: AppTextStyle.normalRegular14.copyWith(
                      color: appColor,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget changeAccessControl() {
    return GetBuilder<AccessController>(
      builder: (controller) {
        if (controller.accessApiResponse.status == Status.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.accessApiResponse.status == Status.COMPLETE) {
          dynamic accessData1 = controller.accessApiResponse.data;
          log('ACCESS PRICE :- $accessData1');
          changeAccessControlList.clear();

          for (int i = 0; i < (accessData1['data'] as List).length; i++) {
            print('SELECT ::: |${accessData1['data'][i]['control_name']}|');

            if (accessData
                .contains('${accessData1['data'][i]['controls_id']}')) {
              print('contain----${accessData1['data'][i]['control_name']}');
            } else {
              changeAccessControlList
                  .add('${accessData1['data'][i]['control_name']}');
              changeAccessControlId.add('${accessData1['data'][i]['id']}');
              changeAccessControlPrice
                  .add('${accessData1['data'][i]['controls_prize']}');
              print('-not contain--${accessData1['data'][i]['control_name']}');
            }
          }
          // changeAccessControlList.add('hello');

          return Wrap(
            runAlignment: WrapAlignment.spaceBetween,
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(
              changeAccessControlList.length,
              (index) => SizedBox(
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        changeAccessControlList[index],
                        style: AppTextStyle.normalRegular14
                            .copyWith(color: greyColor),
                      ),
                      Obx(
                        () => Checkbox(
                          value: commonCheckboxValue[index].value,
                          activeColor: appColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (states) {
                            return appColor;
                          }),
                          onChanged: (bool value) {
                            commonCheckboxValue[index].value = value ?? false;
                            if (commonCheckboxValue[index].value == true) {
                              accesControll
                                  .add('${changeAccessControlId[index]}');
                              accesControllName
                                  .add('${changeAccessControlList[index]}');
                              accesControllPrice
                                  .add('${changeAccessControlPrice[index]}');
                            } else {
                              accesControll
                                  .remove('${changeAccessControlId[index]}');
                              accesControllName
                                  .remove('${changeAccessControlList[index]}');
                              accesControllPrice
                                  .remove('${changeAccessControlPrice[index]}');
                            }

                            if (accesControll.contains('NA') ||
                                accesControllName.contains('NA') ||
                                accesControllPrice.contains('NA')) {
                              accesControll.remove('NA');
                              accesControllName.remove('NA');
                              accesControllPrice.remove('NA');
                            }
                            log('ACCES LIST :- $accesControll');
                            log('ACCES LIST :- $accesControllName');
                            log('ACCES LIST :- $accesControllPrice');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Center(
          child: Text('Someething wrong'),
        );
      },
    );
  }

  Widget feedBack(dynamic setStateDialog) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderGreyColor,
        ),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Column(
        children: [
          Container(
            color: const Color(0xffF3F3F3),
            padding: const EdgeInsets.all(15),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Feedback/Suggestion/Complaint',
                  style: AppTextStyle.normalSemiBold16,
                ),
                height10,
                Text(
                  'Complaint/Suggestions about this parking. Report a lost/damage/manifactioning of this access control.',
                  style:
                      AppTextStyle.normalRegular16.copyWith(color: greyColor),
                ),
              ],
            ),
          ),
          ExpansionTile(
            title: GestureDetector(
              onTap: () {
                submitPopup(setStateDialog);
              },
              child: Text(
                'Give Suggestion',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  '${des.text.toString()}',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomButtons({id}) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppBorderButton(
                title: 'No, Go Back',
                radius: 10,
                fontSize: 16,
                height: 55,
                onTap: () {
                  Get.back();
                },
              ),
            ),
            width05,
            Expanded(
              child: AppFillButton(
                title: 'Save Changes',
                radius: 10,
                fontSize: 16,
                height: 55,
                onTap: () async {
                  log('ACCESS LIST :- ${accesControll}');
                  log('ACCESS LIST :- ${id}');
                  if (isTermAgree.value == true) {
                    var x = 0;
                    for (int i = 0; i < accesControllPrice.length; i++) {
                      x += int.parse(accesControllPrice[i]);
                    }

                    if (accesControll.isEmpty) {
                      var headers = {
                        'Authorization':
                            'Bearer ${PreferenceManager.getBariear()}'
                      };
                      var request = http.MultipartRequest(
                          'POST',
                          Uri.parse(
                              'https://i.invoiceapi.ml/api/customer/editSlotDetails'));
                      request.fields.addAll({
                        'id': '${id}',
                        'auto_renewal': isAutoRenewal.value == true ? '1' : '0'
                      });

                      request.headers.addAll(headers);

                      http.StreamedResponse response = await request.send();

                      if (response.statusCode == 200) {
                        print(
                            ' SUCCESSFULL DATA :- ${await response.stream.bytesToString()}');
                        Get.back();
                        Get.back();
                      } else {
                        print(response.reasonPhrase);
                      }
                    } else {
                      Get.to(
                        () => OrderSummaryScreen(
                          subId: id,
                          planPrice: 'NA',
                          slotQuntity: 1,
                          totalAccessPrice: x,
                          accessController: accesControll,
                          accessPrice: accesControllPrice,
                          access: accesControllName,
                          renual: isAutoRenewal.value == true ? '1' : '0',
                        ),
                      );
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
        height15,
        AppBorderButton(
          title: 'Cancel this Parking',
          radius: 10,
          fontSize: 16,
          height: 55,
          onTap: () {
            cancelPopup(id);
          },
        ),
      ],
    );
  }

  void submitPopup(dynamic setStateDialog, {id}) {
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
              AppTextField(
                controller: header,
                hintText: 'Subject',
                hintStyle:
                    AppTextStyle.normalRegular16.copyWith(color: greyColor),
              ),
              height20,
              AppTextField(
                controller: des,
                hintText: 'Write your meesage here....',
                hintStyle:
                    AppTextStyle.normalRegular16.copyWith(color: greyColor),
                maxLines: 5,
                textAlign: TextAlign.start,
              ),
              height20,
              AppFillButton(
                title: 'Submit',
                radius: 10,
                height: 50,
                onTap: () async {
                  await feedBackSubmit();
                },
              ),
              height10,
            ],
          ),
        );
      },
    ).then((value) => setStateDialog(() {}));
  }

  feedBackSubmit() async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://i.invoiceapi.ml/api/customer/storeFeedback'));
    request.fields
        .addAll({'subject': '${header.text}', 'message': '${des.text}'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.back();

      log('Update');
      CommonSnackBar.commonSnackBar(message: 'Feedback submitted');
    } else {
      print(response.reasonPhrase);
      CommonSnackBar.commonSnackBar(message: '${response.reasonPhrase}');
    }
  }

  void cancelPopup(id) {
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
                    child: GetBuilder<CancleSubViewModel>(
                      builder: (controller) {
                        return controller.isLoading == true
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : AppFillButton(
                                title: 'Yes, I’m Sure',
                                radius: 10,
                                onTap: () async {
                                  controller.updateLoading(true);
                                  await cancleSubViewModel.cancleSubViewModel(
                                      id: '$id');
                                  if (cancleSubViewModel
                                          .cancleSubApiResponse.status ==
                                      Status.COMPLETE) {
                                    CommonSnackBar.commonSnackBar(
                                        message:
                                            'Subscription cancel Request send');
                                    controller.updateLoading(false);

                                    Get.offAll(() => SlotDetailsScreen());
                                  } else {
                                    controller.updateLoading(false);

                                    CommonSnackBar.commonSnackBar(
                                        message: 'Try Again...');
                                  }
                                },
                              );
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

  fetchData(index) {
    try {
      accessData.clear();

      if ((data['data'] as List).length != selectedItem.length) {
        print('ohh no bar bar andar');
        selectedItem.add('Select');
      }

      accessData = ['Select'];
      data['data'][index]['access_control']
          .toString()
          .replaceFirst('[', '')
          .replaceAll(']', '')
          .split(',')
          .forEach((element) {
        accessData.add(element.toString().trim().toString());
      });
      data1.clear();
      data1 = ['Select'];

      for (int i = 0; i < (accessx['data'] as List).length; i++) {
        if (accessData.contains('${accessx['data'][i]['controls_id']}')) {
          data1.add(accessx['data'][i]['control_name']);
        }
      }
    } catch (e) {
      isLoading = false;
    }
  }
}
