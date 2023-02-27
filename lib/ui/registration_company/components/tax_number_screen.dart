import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/registration_company/registration_company_controller.dart';
import 'package:find_me/ui/utils/utils.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TaxRegisterCompany extends StatelessWidget {
  const TaxRegisterCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegCompanyController>(
      init: RegCompanyController(),
      builder: (rCC) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: SvgPicture.asset(icButtonBack, color: kTextMainColor),
              onPressed: () => Get.back(),
            ),
          ),
          backgroundColor: kTextWhiteColor,
          body: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 31.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 8.0),
                    RichText(
                      text: TextSpan(
                          text: 'Enter your company’s tax number ',
                          style: text(kCommonXXXXLarge,
                              isDisplayFont: true,
                              color: kTextMainColor,
                              fw: kBold),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' (Steuernummer)',
                                style: text(kCommonXXXLarge,
                                    color: kTextMainColor, fw: kBold)),
                          ]),
                    ),
                    SizedBox(height: 16),
                    Text(
                        "You can usually find a business\' Steuernummer on your company’s website, in the Impressum.",
                        style: text(kCommonXMedium, color: kTextMainColor)),
                    Form(
                      key: rCC.formKeyTaxNumber,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 42.0, left: 60.0, right: 60.0),
                        child: TextFormField(
                          controller: rCC.taxNumberCController,
                          inputFormatters: [rCC.maskFormatter],
                          validator: (value) {
                            if (!rCC.isTaxNumberValid()) {
                              return "Incorrect tax number";
                            }
                            return null;
                          },
                          style: text(kCommonXXLarge, color: kTextMainColor),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: '0 0 / 0 0 0 / 0 0 0 0 0',
                            labelStyle:
                                text(kCommonXTiny, color: kTextGrayColor),
                            hintStyle: text(kCommonXXLarge,
                                color: kTextGrayColor, isDisplayFont: true),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: kTextGrayColor)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: kTextGrayColor)),
                          ),
                          onChanged: (v) {
                            v = rCC.taxNumberCController.text;
                            rCC.update();
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    AppButton(
                      type: AppButtonType.GradientBtn,
                      name: 'CONTINUE',
                      onPressed: rCC.taxNumberCController.text.isNotEmpty
                          ? () async {
                              rCC.formKeyTaxNumber.currentState!.validate();
                              if (rCC.isTaxNumberValid()) {
                                if (await rCC.checkTaxNumber()) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Get.toNamed(RoutePaths.RegCompanyContent);
                                } else {
                                  showToast('Incorrect tax number');
                                }
                              } else {
                                showToast('Incorrect tax number');
                              }
                            }
                          : null,
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
