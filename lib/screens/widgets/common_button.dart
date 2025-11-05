import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class CommonButton extends StatefulWidget {
  final Size size;
  final String title;
  final Function onclick;
  final Color? buttonColor;
  final Color? textColor;

  const CommonButton(
      {super.key,
      required this.size,
      required this.title,
      required this.onclick,
      this.buttonColor,
      this.textColor});

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => widget.onclick(),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            widget.buttonColor ?? AppColors().primaryColor(context),
        fixedSize: widget.size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        widget.title,
        style: TextStyle(color: widget.textColor ?? AppColors().white(context)),
      ),
    );
  }
}
