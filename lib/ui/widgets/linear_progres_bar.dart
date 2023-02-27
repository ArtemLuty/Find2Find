import 'package:find_me/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LinearProgressBar extends StatefulWidget {
  final Duration? animationDuration;
  final double? value;

  const LinearProgressBar({
    Key? key,
    this.animationDuration,
    @required this.value,
  }) : super(key: key);

  @override
  LinearProgressBarState createState() {
    return LinearProgressBarState();
  }
}

class LinearProgressBarState extends State<LinearProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? curve;
  Tween<double>? valueTween;

  @override
  void initState() {
    super.initState();

    this._controller = AnimationController(
      duration: this.widget.animationDuration ?? const Duration(seconds: 1),
      vsync: this,
    );

    this.curve = CurvedAnimation(
      parent: this._controller!,
      curve: Curves.easeInOut,
    );

    this.valueTween = Tween<double>(
      begin: 0,
      end: this.widget.value != null ? this.widget.value : 0,
    );

    this._controller!.forward();
  }

  @override
  void didUpdateWidget(LinearProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (this.widget.value != oldWidget.value) {
      double beginValue = this.valueTween?.evaluate(this.curve!) ?? oldWidget.value ?? 0;
      this.valueTween = Tween<double>(
        begin: beginValue,
        end: this.widget.value ?? 1,
      );
      this._controller!
        ..value = 0
        ..forward();
    }
  }

  @override
  void dispose() {
    this._controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: this.curve!,
      child: Container(),
      builder: (context, child) {
        return LinearProgressIndicator(
          value: this.valueTween!.evaluate(this.curve!),
          valueColor: AlwaysStoppedAnimation<Color>(kTextWhiteColor),
          backgroundColor: kTextWhiteColor.withOpacity(0.3),
        );
      },
    );
  }
}