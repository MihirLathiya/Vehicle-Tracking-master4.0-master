// ignore_for_file: avoid_renaming_method_parameters

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/pages/subscribed/slot_details_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/text_form_field.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/edit_slot_detail_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';

class PaymentScreen extends StatefulWidget {
  final duration, location, vehicleType, slotType, slotQuntity, placeId;
  final vehicleNumber, accessController;
  final price;
  final total;
  final subId;
  final slotList;
  final renuea;

  const PaymentScreen(
      {Key key,
      this.duration,
      this.location,
      this.vehicleType,
      this.slotType,
      this.slotQuntity,
      this.vehicleNumber,
      this.accessController,
      this.price,
      this.placeId,
      this.total,
      this.subId,
      this.slotList,
      this.renuea})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameOnCardController = TextEditingController();
  bool isCardSave = false;
  bool cardLoad = false;
  EditSlotDetailViewModel editSlotDetailViewModel =
      Get.put(EditSlotDetailViewModel());
  dynamic getCards;
  loadSaveCard() async {
    setState(() {
      cardLoad = false;
    });
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var response = await http.get(
        Uri.parse('https://i.invoiceapi.ml/api/customer/getCardDetail'),
        headers: headers);

    if (response.statusCode == 200) {
      getCards = await jsonDecode(response.body);
      log('GET CARDS :- $getCards');
      setState(() {
        cardLoad = true;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        cardLoad = false;
      });
    }
  }

  List selected = [];
  List controllers = [];

  Map<String, dynamic> selected1 = {};
  Map<String, dynamic> controllers1 = {};

  var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
  bool iaAdded = false;
  @override
  void initState() {
    loadSaveCard();
    selected = widget.slotList;
    controllers = widget.accessController;
    super.initState();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Payment Options',
          style: AppTextStyle.normalSemiBold16.copyWith(color: whiteColor),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          ),
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAsset.paymentbackground), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add a New Credit/Debit Card',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: whiteColor),
                ),
                height25,
                cardContainer(
                    icon: AppAsset.creditCard,
                    text: 'Credit Card',
                    onTap: () {
                      cardNumberController.clear();
                      cvvController.clear();
                      expiryController.clear();
                      nameOnCardController.clear();
                      setState(() {
                        iaAdded = false;
                      });
                      bottomSheet();
                    }),
                height25,
                cardContainer(
                    icon: AppAsset.debitCard,
                    text: 'Debit Card',
                    onTap: () {
                      cardNumberController.clear();
                      cvvController.clear();
                      expiryController.clear();
                      nameOnCardController.clear();
                      setState(() {
                        iaAdded = false;
                      });
                      bottomSheet();
                    }),
                customHeight(40),
                Text(
                  'Saved Cards',
                  style:
                      AppTextStyle.normalRegular14.copyWith(color: whiteColor),
                ),

                height25,
                cardLoad == true
                    ? getCards['data'].length == 0
                        ? Center(
                            child: Text(
                              'No save Card',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: getCards['data'].length,
                              itemBuilder: (context, index) {
                                return paymentContainer(
                                  icon: AppAsset.visa,
                                  text: 'VisaCard',
                                  onTap: () {
                                    // setState(() {
                                    cardNumberController.text =
                                        '${getCards['data'][index]['card_number']}';
                                    cvvController.text =
                                        '${getCards['data'][index]['cvv']}';
                                    expiryController.text =
                                        '${getCards['data'][index]['expiry_date']}';
                                    nameOnCardController.text =
                                        '${getCards['data'][index]['card_holder_name']}';
                                    // });
                                    setState(() {
                                      iaAdded = true;
                                    });
                                    bottomSheet();
                                  },
                                );
                              },
                            ),
                          )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),

                // height25,
                // paymentContainer(
                //   icon: AppAsset.masterCard,
                //   text: 'MasterCard',
                //   onTap: () {
                //     bottomSheet();
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future bottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // constraints: BoxConstraints(maxHeight: Get.height / 1.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    height25,
                    Text('Card Number',
                        style: AppTextStyle.normalRegular14
                            .copyWith(fontSize: 16)),
                    height10,
                    newTextFormFiled(
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          CardNumberFormatter(),
                        ],
                        maxLength: 19,
                        labelText: '',
                        controller: cardNumberController,
                        borderColor: containerGrey),
                    height15,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Expiry Date',
                                  style: AppTextStyle.normalRegular14
                                      .copyWith(fontSize: 16)),
                              height10,
                              newTextFormFiled(
                                  labelText: '',
                                  controller: expiryController,
                                  borderColor: containerGrey),
                            ],
                          ),
                        ),
                        width15,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CVV',
                                  style: AppTextStyle.normalRegular14
                                      .copyWith(fontSize: 16)),
                              height10,
                              newTextFormFiled(
                                  labelText: '',
                                  controller: cvvController,
                                  borderColor: containerGrey),
                            ],
                          ),
                        ),
                      ],
                    ),
                    height15,
                    Text('Name on Card',
                        style: AppTextStyle.normalRegular14
                            .copyWith(fontSize: 16)),
                    height10,
                    newTextFormFiled(
                        labelText: '',
                        controller: nameOnCardController,
                        borderColor: containerGrey),
                    height20,
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            isCardSave = !isCardSave;
                            setState(() {});
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCardSave == true
                                    ? containerGrey
                                    : whiteColor,
                                border: Border.all(color: containerGrey)),
                          ),
                        ),
                        width15,
                        const Text(
                          'Save this card for Future payments',
                          style: AppTextStyle.normalRegular14,
                        ),
                      ],
                    ),
                    height25,
                    AppFillButton(
                      onTap: () async {
                        /// CARD SAVE
                        if (isCardSave == true) {
                          var request = http.MultipartRequest(
                            'POST',
                            Uri.parse(
                                'https://i.invoiceapi.ml/api/customer/saveCardDetail'),
                          );
                          request.fields.addAll({
                            'card_number':
                                '${cardNumberController.text.trim()}',
                            'card_on_name':
                                '${nameOnCardController.text.trim()}',
                            'expiry_date': '${expiryController.text.trim()}',
                            'cvv': '${cvvController.text.trim()}',
                            'card_type': 'visa'
                          });

                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();

                          if (response.statusCode == 200) {
                            /// ADD SLOT
                            if (widget.subId != null && widget.renuea == null) {
                              log('messagesss ${widget.subId}');

                              await addSlot();
                            } else if (widget.subId != null &&
                                widget.renuea != null) {
                              await editSlot();
                            }

                            /// CREATE SUBSCRIPTION
                            else {
                              await createSub();
                            }
                          } else {
                            print(response.reasonPhrase);
                            CommonSnackBar.commonSnackBar(
                                message: '${response.reasonPhrase}');
                          }
                        }

                        /// CARD NOT SAVE
                        else {
                          /// ADD SLOT
                          if (widget.subId != null && widget.renuea == null) {
                            log('messagesss ${widget.subId}');
                            await addSlot();
                          } else if (widget.subId != null &&
                              widget.renuea != null) {
                            await editSlot();
                          }

                          /// CREATE SUBSCRIPTION
                          else {
                            log('messagesss11111223');
                            await createSub();
                          }
                        }
                        Get.back();
                      },
                      title: "Next",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  editSlot() async {
    controllers1.clear();

    for (int i = 0; i < controllers.length; i++) {
      controllers1.addAll({'access_control[$i]': '${controllers[i]}'});
    }
    var data = {'id': '${widget.subId}', 'auto_renewal': widget.renuea};
    data.addAll(controllers1);

    log('ALL BODY :- $data');
    await editSlotDetailViewModel.editSlotDetailViewModel(
      model: data,
    );
    if (editSlotDetailViewModel.editSlotDetailApiResponse.status.toString() ==
        Status.COMPLETE.toString()) {
      Get.offAll(() => SlotDetailsScreen());
      CommonSnackBar.commonSnackBar(message: 'Record Successfully Updated!');
    }
    if (editSlotDetailViewModel.editSlotDetailApiResponse.status.toString() ==
        Status.ERROR.toString()) {
      CommonSnackBar.commonSnackBar(message: 'Try Again');
    }
  }

  addSlot() async {
    if (widget.slotType == 'open' || widget.slotType == 'Open') {
      Map<String, dynamic> bodyy11 = {
        'subscription_id': '${widget.subId}',
        'parking_type': '${widget.slotType}',
        'slot_quantity': '${widget.slotQuntity}',
        'vehicle_number': '${widget.vehicleNumber}'
      };
      log('BODTYS :- $bodyy11');
      var request = await http.post(
          Uri.parse('https://i.invoiceapi.ml/api/customer/addSlot'),
          body: bodyy11,
          headers: headers);
      log('RESPONSE CODE :- ${request.statusCode}');
      if (request.statusCode == 200) {
        Get.offAll(() => SlotDetailsScreen());
        CommonSnackBar.commonSnackBar(message: 'Successfully added');
      } else {
        CommonSnackBar.commonSnackBar(message: '${request.reasonPhrase}');
      }
    } else {
      selected1.clear();
      controllers1.clear();

      for (int i = 0; i < selected.length; i++) {
        selected1.addAll({'sloat_list[$i]': '${selected[i]}'});
      }

      for (int i = 0; i < controllers.length; i++) {
        controllers1.addAll({'access_controls[$i]': '${controllers[i]}'});
      }
      Map<String, dynamic> bodyy11 = {
        'subscription_id': '${widget.subId}',
        'parking_type': 'reserved',
        'slot_quantity': '${widget.slotQuntity}',
        'vehicle_number': '${widget.vehicleNumber}'
      };
      bodyy11.addAll(selected1);
      bodyy11.addAll(controllers1);
      log('ADD SLOT BODY  :- $bodyy11');
      var request = await http.post(
          Uri.parse('https://i.invoiceapi.ml/api/customer/addSlot'),
          body: bodyy11,
          headers: headers);
      log('RESPONSE CODE :- ${request.statusCode}');
      if (request.statusCode == 200) {
        log('RESPONSE STATUS :- ${await jsonDecode(request.body)}');
        Get.offAll(() => SlotDetailsScreen());
        CommonSnackBar.commonSnackBar(message: 'Successfully added');
      } else {
        log('ERROR :- ${request.reasonPhrase}');
        CommonSnackBar.commonSnackBar(message: '${request.reasonPhrase}');
      }
    }
  }

  createSub() async {
    log('messagesss1111');
    selected1.clear();
    controllers1.clear();
    for (int i = 0; i < selected.length; i++) {
      selected1.addAll({'sloat_list[$i]': '${selected[i]}'});
    }
    for (int i = 0; i < controllers.length; i++) {
      controllers1.addAll({'access_controls[$i]': '${controllers[i]}'});
    }
    Map<String, dynamic> bodyy22 = {
      'place_id': '${widget.placeId}',
      'slot_quantity': '${widget.slotQuntity}',
      'subscription_amount': '${widget.total}',
      'parking_type': '${widget.slotType}',
      'vehicle_type': '${widget.vehicleType}',
      'paln_duration': '${widget.duration}',
      'vehicle_number': '${widget.vehicleNumber.toString()}'
    };

    bodyy22.addAll(selected1);
    bodyy22.addAll(controllers1);
    log('BODY OF ADD DATAS  :- $bodyy22');
    var request = await http.post(
        Uri.parse('https://i.invoiceapi.ml/api/customer/createSubscription'),
        headers: headers,
        body: bodyy22);

    if (request.statusCode == 200) {
      print('RESPONSE ${jsonDecode(await request.body)}');
      Get.offAll(() => SlotDetailsScreen());
    } else {
      CommonSnackBar.commonSnackBar(
          message: 'RESPONSE ERROR ${request.reasonPhrase}');
    }
  }

  Widget cardContainer({String icon, String text, void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 84,
        decoration: BoxDecoration(
            color: containerGrey, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              height: 41,
              width: 41,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(10),
              child: Image.asset(icon),
            ),
            width15,
            Text(
              text,
              style: AppTextStyle.normalRegular14.copyWith(color: whiteColor),
            ),
            const Spacer(),
            const Icon(
              Icons.keyboard_arrow_down,
              color: whiteColor,
            )
          ],
        ),
      ),
    );
  }

  Widget paymentContainer({String icon, String text, void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 84,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: containerGrey, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 65,
              width: 65,
            ),
            width15,
            text == 'VisaCard'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: AppTextStyle.normalRegular14
                            .copyWith(color: whiteColor),
                      ),
                      height05,
                      Text('***********',
                          style: AppTextStyle.normalRegular14
                              .copyWith(color: greyColor))
                    ],
                  )
                : Text(
                    text,
                    style: AppTextStyle.normalRegular14
                        .copyWith(color: whiteColor),
                  ),
            const Spacer(),
            const Icon(
              Icons.more_vert,
              color: whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
