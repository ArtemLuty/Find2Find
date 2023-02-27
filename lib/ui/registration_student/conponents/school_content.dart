import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/enums/register_enum.dart';
import 'package:find_me/ui/utils/utils.dart';
import 'package:find_me/ui/registration_student/registration_student_controller.dart';
import 'package:find_me/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Widget buildSchoolContent() {
  return GetBuilder<RegStudentController>(
      init: RegStudentController(),
      builder: (rC) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () async {
                      rC.schools = await rC.getSchoolsByPostcode();
                      Get.dialog(
                          Material(
                            type: MaterialType.transparency,
                            child: Center(
                              child: Container(
                                height: 429.0,
                                width: 310.0,
                                decoration: BoxDecoration(
                                  color: kTextWhiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 46.0),
                                      child: IconButton(
                                          icon: SvgPicture.asset(icButtonCancel,
                                              color: kTextLightGrayColor),
                                          onPressed: () => Get.back()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 49.0,
                                          right: 43.0,
                                          bottom: 10.0),
                                      child: TextField(
                                          decoration: InputDecoration(
                                        hintText: 'My School’s Name',
                                        labelText: null,
                                        labelStyle: text(kCommonXTiny,
                                            color: kTextGrayColor),
                                        hintStyle: text(kCommonXXLarge,
                                            color: kTextGrayColor,
                                            isDisplayFont: true),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kTextGrayColor, width: 2),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kTextGrayColor, width: 2),
                                        ),
                                      )),
                                    ),
                                    SizedBox(height: 27),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: rC.schools.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 10.0,
                                              left: 49.0,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                rC.schoolSController.text = rC
                                                    .schools[index].schoolName!;
                                                rC.selectedSchool =
                                                    rC.schools[index];
                                                rC.update();
                                                Get.back();
                                              },
                                              child: Text(
                                                  rC.schools[index].schoolName!,
                                                  style: text(kCommonXMedium,
                                                      color: kTextMainColor)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          barrierDismissible: true,
                          useSafeArea: true);
                    },
                    child: AbsorbPointer(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 50.0, left: 60.0, right: 60.0),
                        child: Form(
                          key: rC.formKeySchool,
                          child: TextFormField(
                            controller: rC.schoolSController,
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return "Incorrect school";
                              }
                              return null;
                            },
                            style: text(kCommonXXLarge, color: kTextMainColor),
                            decoration: InputDecoration(
                              hintText: 'My School',
                              labelText: rC.schoolSController.text.isNotEmpty
                                  ? 'My School'
                                  : null,
                              labelStyle:
                                  text(kCommonXTiny, color: kTextGrayColor),
                              hintStyle: text(kCommonXXLarge,
                                  color: kTextGrayColor, isDisplayFont: true),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: kTextGrayColor, width: 2),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: kTextGrayColor, width: 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 38.0, top: 4.0),
                  child: AppButton(
                    type: AppButtonType.GradientBtn,
                    name: 'CONTINUE',
                    onPressed: rC.schoolSController.text.isNotEmpty
                        ? () {
                            rC.formKeySchool.currentState!.validate();
                            if (rC.isSchoolValid()) {
                              final updated =
                                  ((rC.progressPercent + 0.1).clamp(0.0, 1.0) *
                                      100);
                              rC.progressPercent = updated.round() / 100;
                              rC.update();
                              FocusManager.instance.primaryFocus?.unfocus();
                              rC.changePage(ScreenRegStudentType.phoneNumber);
                            } else {
                              showToast("Incorrect school");
                            }
                          }
                        : null,
                  ),
                )
              ],
            ),
          ),
        );
      });
}
