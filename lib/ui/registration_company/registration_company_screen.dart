import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_routes.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/registration_company/registration_company_controller.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegCompanyScreen extends StatefulWidget {
  const RegCompanyScreen({Key? key}) : super(key: key);

  @override
  _RegCompanyScreenState createState() => _RegCompanyScreenState();
}

class _RegCompanyScreenState extends State<RegCompanyScreen>
    with SingleTickerProviderStateMixin {
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
            padding: const EdgeInsets.only(left: 31.0, right: 31.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 19.0),
                    Container(
                        height: 100.0,
                        width: 100.0,
                        child: Image.asset(icRegCHeader)),
                    SizedBox(height: 60.0),
                    Text('Register a Company\'s Account',
                        style: text(kCommonXXXXXLarge,
                            isDisplayFont: true,
                            color: kTextMainColor,
                            fw: kBold)),
                    SizedBox(height: 16),
                    Text(
                        'To register your company, you will be asked for your company\'s tax number (Steuernummer).',
                        style: text(kCommonXMedium, color: kTextMainColor))
                  ],
                ),
                Column(
                  children: [
                    AppButton(
                      type: AppButtonType.GradientBtn,
                      name: 'CONTINUE',
                      onPressed: () => Get.toNamed(RoutePaths.RegCTaxNumber),
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
