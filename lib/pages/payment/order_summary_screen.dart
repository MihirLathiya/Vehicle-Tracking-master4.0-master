import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/pages/payment/payment_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/widgets/app_button.dart';

class OrderSummaryScreen extends StatefulWidget {
  final duration,
      location,
      vehicleType,
      slotType,
      slotQuntity,
      placeId,
      planPrice,
      subId;
  final totalCount;
  final totalAccessPrice;
  final slotList;
  final access;
  final renual;

  final vehicleNumber, accessController, accessPrice;
  final price;
  final planSubId;
  const OrderSummaryScreen(
      {Key key,
      this.duration,
      this.location,
      this.vehicleType,
      this.slotType,
      this.slotQuntity,
      this.placeId,
      this.vehicleNumber,
      this.accessController,
      this.price,
      this.accessPrice,
      this.planPrice,
      this.totalCount,
      this.totalAccessPrice,
      this.subId,
      this.slotList,
      this.access,
      this.renual,
      this.planSubId})
      : super(key: key);

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  bool loading = false;
  dynamic paymentData;
  List controllers = [];
  List controllers1 = [];
  getAccountPayAmmount() async {
    setState(() {
      loading = true;
    });

    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/getPaymentAmount?subscription_id=${widget.subId}&slot_quantity=${widget.slotQuntity}&access_control=${widget.accessController}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      paymentData = jsonDecode(await response.stream.bytesToString());
      setState(() {});
      print('PAYMENT :- ${paymentData}');
      setState(() {
        loading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        loading = true;
      });
    }
  }

  getAccessControlePayAmount() async {
    setState(() {
      loading = true;
    });
    controllers1.clear();
    String aaa = '';
    for (int i = 0; i < controllers.length; i++) {
      controllers1.add({'&access_control[$i]': '${controllers[i]}'});
      aaa = '${aaa}&access_control[$i]=${controllers[i]}';
    }
    print('aaaaaaaaa====> ${aaa}');

    //
    // link.
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/getPaymentAmountAccesscontrol?subscription_id=${widget.planSubId}$aaa'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      paymentData = jsonDecode(await response.stream.bytesToString());
      setState(() {});
      print('PAYMENT ADD SLOT :- ${paymentData}');
      setState(() {
        loading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        loading = true;
      });
    }
  }

  @override
  void initState() {
    controllers = widget.accessController;
    if (widget.renual != null &&
        widget.planSubId != null &&
        widget.subId != null) {
      getAccessControlePayAmount();
    } else {
      getAccountPayAmmount();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('DATA ${widget.subId}');
    log('DATA ${widget.access}');
    log('SLOT DATA ${widget.renual} ${widget.planSubId}');
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Order Summary',
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
      body: widget.subId != null && widget.renual == null
          ? loading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              :

              /// ADD SLOT
              Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      padding: const EdgeInsets.only(bottom: 70),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAsset.paymentbackground),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              membershipPlan(),
                              height10,
                              totalControls(),
                              height10,
                              // priceDetails(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        color: blackColor.withOpacity(0.20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${paymentData['data']['amount']}/-',
                              style: AppTextStyle.bold16
                                  .copyWith(color: whiteColor),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 130,
                              height: 40,
                              child: AppFillButton(
                                radius: 10,
                                onTap: () {
                                  log('DURATION ${widget.duration}');
                                  log('location ${widget.location}');
                                  log('vehicleType ${widget.vehicleType}');
                                  log('slotType ${widget.slotType}');
                                  log('slotQuntity ${widget.slotQuntity}');
                                  log('vehicleNumber ${widget.vehicleNumber}');
                                  log('price ${widget.price}');
                                  log('access Controller ${widget.accessController}');
                                  log(' slotList: selectedSlot, ${widget.slotList}');
                                  Get.to(() => PaymentScreen(
                                      renuea: widget.renual,
                                      slotList: widget.slotList,
                                      subId: widget.subId,
                                      total: paymentData['data']['amount'],
                                      placeId: widget.placeId,
                                      accessController: widget.accessController,
                                      slotQuntity: widget.slotQuntity,
                                      slotType: widget.slotType,
                                      vehicleNumber: widget.vehicleNumber,
                                      vehicleType: widget.vehicleType,
                                      location: widget.location,
                                      duration: widget.duration,
                                      price: widget.price));
                                },
                                title: 'Continue',
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
          : widget.renual != null &&
                  widget.planSubId != null &&
                  widget.subId != null
              ?

              /// EDIT SLOT
              Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      padding: const EdgeInsets.only(bottom: 70),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAsset.paymentbackground),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              membershipPlan(),
                              height10,
                              totalControls(),
                              height10,
                              // priceDetails(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        color: blackColor.withOpacity(0.20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${paymentData['data']['total_prize']}/-',
                              style: AppTextStyle.bold16
                                  .copyWith(color: whiteColor),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 130,
                              height: 40,
                              child: AppFillButton(
                                radius: 10,
                                onTap: () {
                                  log('DURATION ${widget.duration}');
                                  log('location ${widget.location}');
                                  log('vehicleType ${widget.vehicleType}');
                                  log('slotType ${widget.slotType}');
                                  log('slotQuntity ${widget.slotQuntity}');
                                  log('vehicleNumber ${widget.vehicleNumber}');
                                  log('price ${widget.price}');
                                  log('access Controller ${widget.accessController}');
                                  log(' slotList: selectedSlot, ${widget.slotList}');
                                  Get.to(
                                    () => PaymentScreen(
                                      renuea: widget.renual,
                                      slotList: widget.slotList,
                                      subId: widget.subId,
                                      total: paymentData['data']['amount'],
                                      placeId: widget.placeId,
                                      accessController: widget.accessController,
                                      slotQuntity: widget.slotQuntity,
                                      slotType: widget.slotType,
                                      vehicleNumber: widget.vehicleNumber,
                                      vehicleType: widget.vehicleType,
                                      location: widget.location,
                                      duration: widget.duration,
                                      price: widget.price,
                                    ),
                                  );
                                },
                                title: 'Continue',
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              :

              /// CREATE SUBSCRIPTION
              Stack(
                  children: [
                    Container(
                      height: Get.height,
                      width: Get.width,
                      padding: const EdgeInsets.only(bottom: 70),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppAsset.paymentbackground),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              membershipPlan(),
                              height10,
                              totalControls(),
                              height10,
                              priceDetails(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        color: blackColor.withOpacity(0.20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${widget.totalCount}/-',
                              style: AppTextStyle.bold16
                                  .copyWith(color: whiteColor),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 130,
                              height: 40,
                              child: AppFillButton(
                                radius: 10,
                                onTap: () {
                                  log('DURATION ${widget.duration}');
                                  log('location ${widget.location}');
                                  log('vehicleType ${widget.vehicleType}');
                                  log('slotType ${widget.slotType}');
                                  log('slotQuntity ${widget.slotQuntity}');
                                  log('vehicleNumber ${widget.vehicleNumber}');
                                  log('price ${widget.price}');
                                  log('access Controller ${widget.accessController}');
                                  log(' slotList: selectedSlot, ${widget.slotList}');
                                  Get.to(() => PaymentScreen(
                                      slotList: widget.slotList,
                                      subId: widget.subId,
                                      total: widget.totalCount,
                                      placeId: widget.placeId,
                                      accessController: widget.accessController,
                                      slotQuntity: widget.slotQuntity,
                                      slotType: widget.slotType,
                                      vehicleNumber: widget.vehicleNumber,
                                      vehicleType: widget.vehicleType,
                                      location: widget.location,
                                      duration: widget.duration,
                                      price: widget.price));
                                },
                                title: 'Continue',
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget membershipPlan() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: containerGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            'Membership',
            style: AppTextStyle.normalRegular14.copyWith(color: whiteColor),
          ),
          const Spacer(),
          Text(
            '${widget.planPrice}/-',
            style: AppTextStyle.bold16.copyWith(color: whiteColor),
          ),
        ],
      ),
    );
  }

  Widget totalControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: containerGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${(widget.accessController as List).length} Access Controls',
                style: AppTextStyle.normalRegular14.copyWith(color: whiteColor),
              ),
              const Spacer(),
              Text(
                '${widget.totalAccessPrice}/-',
                style: AppTextStyle.bold16.copyWith(color: whiteColor),
              ),
            ],
          ),
          height10,
          Column(
            children: List.generate(
              (widget.accessController as List).length,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAsset.cameraIcon,
                      color: whiteColor,
                      height: 16,
                    ),
                    width15,
                    Text(
                      '${widget.access[index]}',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: whiteColor),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.accessPrice[index]}/-',
                      style: AppTextStyle.normalSemiBold12
                          .copyWith(color: whiteColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priceDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: containerGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Price Details (2 items)',
            style: AppTextStyle.bold14.copyWith(color: whiteColor),
          ),
          height20,
          Row(
            children: [
              Text(
                'Membership',
                style: AppTextStyle.normalRegular14.copyWith(color: whiteColor),
              ),
              const Spacer(),
              Text(
                '${widget.planPrice}/-',
                style:
                    AppTextStyle.normalSemiBold12.copyWith(color: whiteColor),
              ),
            ],
          ),
          Column(
            children: List.generate(
              (widget.accessController as List).length,
              (index) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppAsset.cameraIcon,
                      color: whiteColor,
                      height: 16,
                    ),
                    width15,
                    Text(
                      '${widget.access[index]}',
                      style: AppTextStyle.normalRegular14
                          .copyWith(color: whiteColor),
                    ),
                    const Spacer(),
                    Text(
                      '${widget.accessPrice[index]}/-',
                      style: AppTextStyle.normalSemiBold12
                          .copyWith(color: whiteColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
