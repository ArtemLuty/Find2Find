import 'package:find_me/constants/app_styles.dart';
import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  double buttonSize = 60.0;
  final TextEditingController? pinController;
  final Function? onChange;
  final Function? onSubmit;
  final bool? isPinLogin;

  KeyPad({this.onChange, this.onSubmit, this.pinController, this.isPinLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('1'),
              buttonWidget('2'),
              buttonWidget('3'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('4'),
              buttonWidget('5'),
              buttonWidget('6'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('7'),
              buttonWidget('8'),
              buttonWidget('9'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
              ),
              buttonWidget('0'),
              InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: () {
                    if (pinController!.text.length > 0) {
                      pinController!.text = pinController!.text
                          .substring(0, pinController!.text.length - 1);
                    }
                    if (pinController!.text.length > 5) {
                      pinController!.text = pinController!.text.substring(0, 3);
                    }
                    onChange!(pinController!.text);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.backspace_outlined,
                        color: Colors.black,
                      ))),
            ],
          ),
        ],
      ),
    );
  }

  buttonWidget(String buttonText) {
    return InkWell(
      borderRadius: BorderRadius.circular(45),
      onTap: () {
        if (pinController!.text.length <= 3) {
          pinController!.text = pinController!.text + buttonText;
          onChange!(pinController!.text);
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 50,
        height: 50,
        child: Text(
          buttonText,
          style:
          text(kCommonXXXXLarge, isDisplayFont: true, color: Colors.black),
        ),
      ),
    );
  }
}
