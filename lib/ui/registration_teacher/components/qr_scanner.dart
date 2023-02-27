import 'package:find_me/constants/app_colors.dart';
import 'package:find_me/constants/app_images.dart';
import 'package:find_me/constants/app_styles.dart';
import 'package:find_me/ui/registration_teacher/registration_teacher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<RegTeacherController>(
        builder: (rTC) {
          return Stack(
            children: [
              Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Stack(
                      children: [
                        QRView(
                            key: rTC.qrKey,
                            onQRViewCreated: rTC.onQRViewCreated),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Scan QR code',
                                style: text(kCommonXXXXXLarge,
                                    color: kTextWhiteColor,
                                    isDisplayFont: true,
                                    fw: kBold)),
                            SizedBox(height: 41.0),
                            Center(
                              child: Container(
                                width: 281,
                                height: 276,
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.3)),
              Positioned(
                  top: 55.0,
                  left: 16.0,
                  child: GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(icButtonBack))),
            ],
          );
        },
      ),
    );
  }
}
