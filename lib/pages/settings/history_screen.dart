import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/view_model/history_view_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryViewModel historyViewModel = Get.put(HistoryViewModel());
  @override
  void initState() {
    historyViewModel.history();
    super.initState();
  }

  // List historyTransction = [
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  //   {
  //     'Date': '21/07/2022',
  //     'Time': '6 MOnth',
  //     'Price': '4000/-',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            color: blackColor,
          ),
        ),
        title: Text(
          'History',
          style: AppTextStyle.normalSemiBold8.copyWith(fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child: Image.asset(
              AppAsset.bgThemeTop,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: GetBuilder<HistoryViewModel>(
                  builder: (controller) {
                    if (controller.historyApiResponse.status ==
                        Status.LOADING) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (controller.historyApiResponse.status ==
                        Status.COMPLETE) {
                      dynamic historyData = controller.historyApiResponse.data;
                      return ListView.builder(
                        itemCount: (historyData as List).length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Get.to(() => const ChangePasswordScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${historyData[index]['subscription_start_date'].toString().split(' ').first}',
                                            style:
                                                AppTextStyle.normalSemiBold16,
                                          ),
                                          height05,
                                          Text(
                                            '${historyData[index]['subscription_end_date'].toString().split(' ').first}',
                                            style: AppTextStyle.normalRegular14
                                                .copyWith(color: greyColor),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '${historyData[index]['amount']} /-',
                                        style: AppTextStyle.normalSemiBold8
                                            .copyWith(fontSize: 16),
                                      )
                                    ],
                                  ),
                                  height10,
                                  const Divider(
                                    color: greyColor,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: Text('Something went wrong'),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
