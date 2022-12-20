import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/request_model/update_profile_req_model.dart';
import 'package:vehicletracking/models/response_model/profile_res_model.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/text_form_field.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/update_profile_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UpdateProfileViewModel updateProfileViewModel =
      Get.put(UpdateProfileViewModel());

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController trnController = TextEditingController();
  apiCalling() async {
    var headers = {'Authorization': 'Bearer ${PreferenceManager.getBariear()}'};
    var response = await http.get(
        Uri.parse(
            'https://i.invoiceapi.ml/api/customer/getUserDetail/${PreferenceManager.getAccountNo()}'),
        headers: headers);

    if (response.statusCode == 200) {
      print(" RESPONSE ${await response}");
      var data = jsonDecode(response.body);
      ProfileResponseModel model = await ProfileResponseModel.fromJson(data);
      firstNameController.text = model.data.firstName.toString();
      lastNameController.text = model.data.lastName.toString();
      companyNameController.text = model.data.companyName.toString();
      companyAddressController.text = model.data.companyAddress.toString();
      mobileNumberController.text = model.data.mobileNumber.toString();
      whatsappNumberController.text = model.data.whatappNumber.toString();
      emailAddressController.text = model.data.email.toString();
      trnController.text = model.data.trn.toString();
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    apiCalling();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image.asset(
              AppAsset.editProfile,
              width: Get.width,
              height: Get.height,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 290.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Edit Profile',
                            style: AppTextStyle.normalSemiBold8
                                .copyWith(fontSize: 20),
                          ),
                        ),
                        height10,
                        newTextFormFiled(
                          controller: firstNameController,
                          labelText: 'First Name*',
                        ),
                        height25,
                        newTextFormFiled(
                          controller: lastNameController,
                          labelText: 'Last Name*',
                        ),
                        height25,
                        newTextFormFiled(
                          controller: companyNameController,
                          labelText: 'Company Name*',
                        ),
                        height25,
                        newTextFormFiled(
                          controller: companyAddressController,
                          labelText: 'Company Address*',
                        ),
                        height25,
                        newTextFormFiled(
                          controller: mobileNumberController,
                          labelText: 'Mobile Number*',
                        ),
                        height25,
                        newTextFormFiled(
                          controller: whatsappNumberController,
                          labelText: 'Whatsapp Number*',
                        ),
                        height25,
                        newTextFormFiled(
                          controller: emailAddressController,
                          labelText: 'E-mail Address*',
                        ),
                        height25,
                        newTextFormFiled(
                          controller: trnController,
                          labelText: 'TRN (Not Mandatory)',
                        ),
                        customHeight(50),
                        GetBuilder<UpdateProfileViewModel>(
                          builder: (controller) {
                            return controller.isLoading == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : AppFillButton(
                                    title: "Save",
                                    onTap: () async {
                                      controller.updateLoading(true);

                                      UpdateProfileRequestModel req =
                                          UpdateProfileRequestModel();
                                      req.accountNumber =
                                          PreferenceManager.getAccountNo()
                                              .toString();
                                      req.firstName = firstNameController.text
                                          .toString()
                                          .trim();
                                      req.lastName = lastNameController.text
                                          .toString()
                                          .trim();
                                      req.companyName = companyNameController
                                          .text
                                          .toString()
                                          .trim();
                                      req.companyAddress =
                                          companyAddressController.text
                                              .toString()
                                              .trim();
                                      req.mobileNumber = mobileNumberController
                                          .text
                                          .toString()
                                          .trim();
                                      req.whatappNumber =
                                          whatsappNumberController.text
                                              .toString()
                                              .trim();
                                      req.email = emailAddressController.text
                                          .toString()
                                          .trim();
                                      req.tRN =
                                          trnController.text.toString().trim();
                                      await updateProfileViewModel
                                          .updateProfileViewModel(
                                              model: req.toJson());

                                      if (updateProfileViewModel
                                              .updateProfileApiResponse
                                              .status ==
                                          Status.COMPLETE) {
                                        PreferenceManager.setCompanyAddress(
                                            companyAddressController.text
                                                .trim());
                                        PreferenceManager.setCompanyName(
                                            companyNameController.text.trim());
                                        PreferenceManager.setEmail(
                                            emailAddressController.text.trim());
                                        PreferenceManager.setName(
                                            firstNameController.text.trim());
                                        PreferenceManager.setWhatsApp(
                                            whatsappNumberController.text
                                                .trim());
                                        PreferenceManager.setNumber(
                                            mobileNumberController.text.trim());
                                        controller.updateLoading(false);

                                        CommonSnackBar.commonSnackBar(
                                            message:
                                                '"Record Successfully Updated!"');
                                      }
                                      if (updateProfileViewModel
                                              .updateProfileApiResponse
                                              .status ==
                                          Status.ERROR) {
                                        controller.updateLoading(false);
                                        CommonSnackBar.commonSnackBar(
                                            message: 'Try Again');
                                      }
                                    },
                                    radius: 10,
                                  );
                          },
                        ),
                        height15,
                      ],
                    ),
                  ),
                ],
              ),
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
}
