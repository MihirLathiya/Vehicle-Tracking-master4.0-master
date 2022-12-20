import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicletracking/models/apis/api_response.dart';
import 'package:vehicletracking/models/response_model/create_password_res_model.dart';
import 'package:vehicletracking/pages/auth/sign_in.dart';
import 'package:vehicletracking/prefrence_manager/prefrence_manager.dart';
import 'package:vehicletracking/utils/app_assets.dart';
import 'package:vehicletracking/utils/app_colors.dart';
import 'package:vehicletracking/utils/app_static_decoration.dart';
import 'package:vehicletracking/utils/app_text_style.dart';
import 'package:vehicletracking/utils/validators.dart';
import 'package:vehicletracking/view_model/create_password_view_model.dart';
import 'package:vehicletracking/widgets/app_button.dart';
import 'package:vehicletracking/widgets/app_comman_widget.dart';
import 'package:vehicletracking/widgets/app_text_form_field.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({Key key}) : super(key: key);

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  final _formKey1 = GlobalKey<FormState>();

  TextEditingController createPassword = TextEditingController();
  TextEditingController reEnterPassword = TextEditingController();
  RxBool createObscureText = true.obs;
  RxBool reEnterObscureText = true.obs;
  RxBool agreeTerm = false.obs;

  CreatePasswordViewModel createPasswordViewModel =
      Get.put(CreatePasswordViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('ACCOUNT NO :- ${PreferenceManager.getAccountNo()}');
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
            color: blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey1,
          child: Stack(
            children: [
              Image.asset(
                AppAsset.setPassword,
                height: Get.height,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: <Widget>[
                    customHeight(300),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          const Text(
                            'Set Password',
                            textAlign: TextAlign.end,
                            style: AppTextStyle.bold20,
                          ),
                          Text(
                            'Create password to keep your account safe',
                            textAlign: TextAlign.end,
                            style: AppTextStyle.normalRegular14
                                .copyWith(color: greyColor),
                          ),
                          customHeight(40),
                          Obx(
                            () => AppTextField(
                              labelText: "Create Password",
                              controller: createPassword,
                              obscureText: createObscureText.value,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password Can't be Empty";
                                } else {
                                  return null;
                                }
                              },
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  createObscureText.value =
                                      !createObscureText.value;
                                },
                                child: Icon(
                                  createObscureText.value
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                          ),
                          height25,
                          Obx(
                            () => AppTextField(
                              labelText: 'Re-enter Password',
                              controller: reEnterPassword,
                              obscureText: reEnterObscureText.value,
                              validator: (value) {
                                if (value != createPassword.text) {
                                  return "Pass does not match !!";
                                } else {
                                  return null;
                                }
                              },
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  reEnterObscureText.value =
                                      !reEnterObscureText.value;
                                },
                                child: Icon(
                                  reEnterObscureText.value
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                          ),
                          height25,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Obx(() => Checkbox(
                                    value: agreeTerm.value,
                                    onChanged: (bool value) {
                                      agreeTerm.value = value ?? false;
                                    },
                                  )),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'By continuing, you agree to our ',
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(
                                          color: greyColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Terms and Conditions ',
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(
                                          color: appColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'and ',
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(
                                          color: greyColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: AppTextStyle.normalRegular14
                                            .copyWith(
                                          color: appColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          height25,
                          GetBuilder<CreatePasswordViewModel>(
                            builder: (controller) {
                              return controller.isLoading == true
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : AppFillButton(
                                      title: 'Create Account',
                                      radius: 15,
                                      onTap: () async {
                                        if (_formKey1.currentState.validate() &&
                                            agreeTerm.value == true) {
                                          await createPasswordViewModel
                                              .createPasswordViewModel(model: {
                                            'account_number':
                                                '${PreferenceManager.getAccountNo()}',
                                            'password':
                                                createPassword.text.trim(),
                                            'password_confirmation':
                                                reEnterPassword.text.trim()
                                          });

                                          if (createPasswordViewModel
                                                  .createPasswordApiResponse
                                                  .status ==
                                              Status.COMPLETE) {
                                            CreatePasswordResponseModel
                                                createPassword =
                                                createPasswordViewModel
                                                    .createPasswordApiResponse
                                                    .data;
                                            CommonSnackBar.commonSnackBar(
                                                message:
                                                    createPassword.message);
                                            Get.offAll(
                                                () => const SignInScreen());
                                            // controller.updateLoading(false);
                                          } else if (createPasswordViewModel
                                                  .createPasswordApiResponse
                                                  .status ==
                                              Status.ERROR) {
                                            CommonSnackBar.commonSnackBar(
                                                message:
                                                    'Something went wrong');
                                            // controller.updateLoading(false);
                                          }
                                        } else if (agreeTerm.value == false) {
                                          CommonSnackBar.commonSnackBar(
                                              message:
                                                  'Accept Terms & Condition');
                                        }
                                      },
                                    );
                            },
                          ),
                          height20,
                          Align(
                            alignment: Alignment.center,
                            child: appRichText(
                                "Already have an account?  ", "LogIn",
                                decoration: TextDecoration.underline,
                                onTap: () {
                              Get.offAll(
                                () => const SignInScreen(),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
