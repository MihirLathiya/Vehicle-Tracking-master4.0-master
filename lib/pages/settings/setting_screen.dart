import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vehicletracking/pages/auth/sign_in.dart';
import 'package:vehicletracking/pages/settings/change_password_screen.dart';
import 'package:vehicletracking/pages/settings/edit_profile_screen.dart';
import 'package:vehicletracking/pages/settings/history_screen.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/image_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  // String image;
  // apiCalling() async {
  //   var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
  //   var response = await http.get(
  //       Uri.parse(
  //           'https://i.invoiceapi.ml/api/customer/getUserDetail/${PreferenceManager.getAccountNo()}'),
  //       headers: headers);
  //
  //   if (response.statusCode == 200) {
  //     print(" RESPONSE ${await response}");
  //     setState(() {});
  //     var data = jsonDecode(response.body);
  //     ProfileResponseModel hello = await ProfileResponseModel.fromJson(data);
  //     log('HELLO :- ${hello.data.image}');
  //     image = hello.data.image;
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }
  ImageController imageController = Get.put(ImageController());

  logOutRepo() async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var request = await http.get(
        Uri.parse('https://i.invoiceapi.ml/api/customer/logout'),
        headers: headers);

    if (request.statusCode == 200) {
      print(await request.body);
      CommonSnackBar.commonSnackBar(message: 'User logOut');
      PreferenceManager.getClear();
      Get.offAll(() => const SignInScreen());
    } else {
      print(request.reasonPhrase);
    }
  }

  File userImage;
  final picker = ImagePicker();
  pickImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        userImage = File(pickedFile.path);
      });

      log('file path :- ${userImage.path}');

      var headers = {
        'Authorization': 'Bearer ${PreferenceManager.getBariear()}'
      };
      var request = http.MultipartRequest('POST',
          Uri.parse('https://i.invoiceapi.ml/api/customer/userProfileUpdate'));
      request.files
          .add(await http.MultipartFile.fromPath('image', userImage.path));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data = jsonDecode(await response.stream.bytesToString());
        imageController.updateUrl(imageUrl: '${data['user']['image']}');
        CommonSnackBar.commonSnackBar(message: 'Image Updated');
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  @override
  void initState() {
    // Future.delayed(
    //   Duration(seconds: 2),
    //   () {
    // apiCalling();
    // },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_rounded,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAsset.seetingBackground),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: whiteColor,
                        width: 5,
                      ),
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GetBuilder<ImageController>(
                          builder: (controller) {
                            if (controller.loading == true) {
                              return Shimmer.fromColors(
                                baseColor: Colors.white.withOpacity(0.4),
                                highlightColor: Colors.white.withOpacity(0.2),
                                enabled: true,
                                child: Container(
                                  height: 400,
                                  width: 40,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return Container(
                                height: 90,
                                width: 90,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.red, width: 4),
                                ),
                                child: userImage != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10000),
                                        child: Image.file(
                                          userImage,
                                          fit: BoxFit.cover,
                                        ))
                                    : controller.url != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1000),
                                            child: Image.network(
                                              '${controller.url}',
                                              height: 45,
                                              width: 45,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Get.to(
                                                      () => SettingScreen(),
                                                    );
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 20,
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.black,
                                                      size: 40,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10000),
                                            child: Icon(
                                              Icons.add_a_photo,
                                            ),
                                          ),
                              );
                            }
                          },
                        ),
                        // Container(
                        //   height: 90,
                        //   width: 90,
                        //   clipBehavior: Clip.antiAliasWithSaveLayer,
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     border: Border.all(color: Colors.red, width: 4),
                        //   ),
                        //   child: userImage != null
                        //       ? ClipRRect(
                        //           borderRadius: BorderRadius.circular(10000),
                        //           child: Image.file(
                        //             userImage,
                        //             fit: BoxFit.cover,
                        //           ))
                        //       : image != null
                        //           ? ClipRRect(
                        //               borderRadius:
                        //                   BorderRadius.circular(10000),
                        //               child: CachedNetworkImage(
                        //                 imageUrl: "${image}",
                        //                 fit: BoxFit.cover,
                        //                 progressIndicatorBuilder: (context, url,
                        //                         downloadProgress) =>
                        //                     CircularProgressIndicator(
                        //                         value:
                        //                             downloadProgress.progress),
                        //                 errorWidget: (context, url, error) =>
                        //                     Icon(Icons.error),
                        //               ),
                        //             )
                        //           : ClipRRect(
                        //               borderRadius:
                        //                   BorderRadius.circular(10000),
                        //               child: Icon(
                        //                 Icons.add_a_photo,
                        //               ),
                        //             ),
                        // ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: whiteColor),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  pickImage();
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  height10,
                  Text(
                    '${PreferenceManager.getName()}',
                    style: AppTextStyle.normalSemiBold16
                        .copyWith(color: whiteColor),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(top: 300, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  commonRow(
                      ontap: () {
                        Get.to(() => const EditProfileScreen());
                      },
                      icon: AppAsset.person,
                      text: 'Edit Profile'),
                  height15,
                  const Divider(
                    color: greyColor,
                  ),
                  height10,
                  commonRow(
                      ontap: () {
                        Get.to(() => const ChangePasswordScreen());
                      },
                      icon: AppAsset.password,
                      text: 'Change Password'),
                  height15,
                  const Divider(
                    color: greyColor,
                  ),
                  height10,
                  commonRow(
                      ontap: () {
                        Get.to(() => const HistoryScreen());
                      },
                      icon: AppAsset.history,
                      text: 'History'),
                  height15,
                  const Divider(
                    color: greyColor,
                  ),
                  height10,
                  commonRow(
                    ontap: () async {
                      await logOutRepo();
                    },
                    icon: AppAsset.logout,
                    text: 'Log Out',
                    isShowIcon: true,
                  ),
                  height15,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commonRow({
    Function() ontap,
    String icon,
    String text,
    bool isShowIcon,
  }) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: blackColor.withOpacity(0.25),
                  spreadRadius: -1,
                ),
              ],
              color: whiteColor,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Image.asset(icon),
              ),
            ),
          ),
          // Material(
          //   elevation: 5,
          //   shadowColor: greyColor,
          //   borderRadius: BorderRadius.circular(50),
          //   child: Container(
          //     height: 50,
          //     width: 50,
          //     decoration: const BoxDecoration(
          //         shape: BoxShape.circle, color: whiteColor),
          //     child: Center(
          //       child: Padding(
          //         padding: const EdgeInsets.all(13.0),
          //         child: Image.asset(icon),
          //       ),
          //     ),
          //   ),
          // ),
          width20,
          Text(
            text,
            style: AppTextStyle.normalRegular14,
          ),
          const Spacer(),
          if (isShowIcon != true)
            const Icon(
              Icons.arrow_forward_ios,
              color: greyColor,
              size: 20,
            )
        ],
      ),
    );
  }
}
