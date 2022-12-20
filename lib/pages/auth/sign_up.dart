import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/request_model/register_user_req_model.dart';
import 'package:vehicletracking/models/response_model/register_user_res_model.dart';
import 'package:vehicletracking/pages/auth/set_password.dart';
import 'package:vehicletracking/pages/auth/sign_in.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/register_user_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';
import 'package:vehicletracking/widgets/app_comman_widget.dart';
import 'package:vehicletracking/widgets/app_text_form_field.dart';

import '../../utils/app_assets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  RegisterUserViewModel registerUserViewModel =
      Get.put(RegisterUserViewModel());
  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController companyAddress = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController whatsappNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: blackColor,
            size: 20.0,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppAsset.bgGroundTop,
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      height15,
                      const Text(
                        "Let’s Get Started",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      customHeight(3.0),
                      const Text(
                        "Create an account to get all features ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      height20,
                      AppTextField(
                        labelText: "First Name",
                        controller: firstName,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "First Name Can't be Empty";
                          } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Enter Correct First Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      height15,
                      AppTextField(
                        labelText: "Last Name",
                        controller: lastName,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Last Name Can't be Empty";
                          } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Enter Correct Last Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      height15,
                      AppTextField(
                        labelText: "Company Name",
                        controller: companyName,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Last Name Can't be Empty";
                          } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Enter Correct Last Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                      height15,
                      AppTextField(
                        labelText: "Company Address",
                        controller: companyAddress,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Company Address Can't be Empty";
                          }
                          // else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          //   return "Enter Correct Company Address";
                          // } else {
                          //   return null;
                          // }
                        },
                      ),
                      height15,
                      AppTextField(
                        labelText: "Mobile Number",
                        controller: mobileNumber,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Mobile Number Can't be Empty";
                          } else if (!RegExp(r"^^[0-9]*$").hasMatch(value)) {
                            return "Enter Correct Mobile Number";
                          } else if (value.length != 10) {
                            return 'Enter Valid Mobile Number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      height15,
                      AppTextField(
                        labelText: "Whatsapp Number",
                        controller: whatsappNumber,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Whatsapp Number Can't be Empty";
                          } else if (!RegExp(r"^^[0-9]*$").hasMatch(value)) {
                            return "Enter Correct Whatsapp Number";
                          } else if (value.length != 10) {
                            return 'Enter Valid Whatsapp Number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      height15,
                      AppTextField(
                        labelText: "Email Address",
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Email Can't be Empty";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Enter Correct Email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      height15,
                      const AppTextField(
                        labelText: "TRN (Tax Registration Number)",
                      ),
                      height15,
                      GetBuilder<RegisterUserViewModel>(
                        builder: (controller) {
                          return controller.isLoading == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : AppFillButton(
                                  title: "Next".toUpperCase(),
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      controller.updateLoading(true);
                                      RegisterUserRequestModel reqModel =
                                          RegisterUserRequestModel();
                                      reqModel.firstName =
                                          firstName.text.trim();
                                      reqModel.lastName = lastName.text.trim();
                                      reqModel.companyName =
                                          companyName.text.trim();
                                      reqModel.companyAddress =
                                          companyAddress.text.trim();
                                      reqModel.mobileNumber =
                                          mobileNumber.text.trim();
                                      reqModel.whatappNumber =
                                          whatsappNumber.text.trim();
                                      reqModel.email = email.text.trim();
                                      await registerUserViewModel
                                          .registerUserViewModel(
                                              model: reqModel.toJson());

                                      if (registerUserViewModel
                                              .registerUserApiResponse.status
                                              .toString() ==
                                          Status.COMPLETE.toString()) {
                                        RegisterUserResponseModel register =
                                            registerUserViewModel
                                                .registerUserApiResponse.data;
                                        CommonSnackBar.commonSnackBar(
                                            message: '${register.message}');
                                        PreferenceManager.setAccountNo(
                                            '${register.user.accountNumber}');
                                        PreferenceManager.setCompanyAddress(
                                            '${register.user.companyAddress}');
                                        PreferenceManager.setCompanyName(
                                            '${register.user.companyName}');
                                        PreferenceManager.setEmail(
                                            '${register.user.email}');
                                        PreferenceManager.setName(
                                            '${register.user.firstName}');
                                        PreferenceManager.setWhatsApp(
                                            '${register.user.whatappNumber}');
                                        PreferenceManager.setNumber(
                                            '${register.user.mobileNumber}');

                                        Get.to(() => SetPassword());
                                        controller.updateLoading(false);
                                      } else if (registerUserViewModel
                                              .registerUserApiResponse.status
                                              .toString() ==
                                          Status.ERROR.toString()) {
                                        CommonSnackBar.commonSnackBar(
                                            message: 'Something went wrong');
                                        controller.updateLoading(false);
                                      }
                                    }
                                  },
                                );
                        },
                      ),
                      height15,
                      appRichText(
                        "Already have an account?  ",
                        "LogIn",
                        onTap: () {
                          Get.offAll(() => const SignInScreen());
                        },
                      ),
                      height20,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
