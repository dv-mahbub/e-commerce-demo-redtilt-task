import 'package:e_commerce_demo_redtilt_task/components/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function() onTap;
  final double? height;
  final Color? textColor;
  final Color? backgroundColor;
  final double? width;
  final bool? isBorderNeeded;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.icon,
      this.width,
      this.height,
      this.backgroundColor,
      this.isBorderNeeded,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 55,
        width: width ?? .82.sw,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(7),
          border: isBorderNeeded != null && isBorderNeeded!
              ? Border.all(
                  color: const Color(0xff979797).withOpacity(.6),
                  width: 1,
                )
              : null,
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : Text(
                  text,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  maxLines: 1,
                  softWrap: true,
                ),
        ),
      ),
    );
  }
}
