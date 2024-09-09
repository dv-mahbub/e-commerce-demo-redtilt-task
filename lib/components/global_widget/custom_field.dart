import 'package:e_commerce_demo_redtilt_task/components/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomField extends StatefulWidget {
  final String? label;
  final String hintText;
  final double? width;
  final double? height;
  final void Function()? onSuffixIconTap;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isSized;
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? topLabel;
  final bool? enabled;
  final int? maxLine;
  final int? minLine;
  final FocusNode? focusNode;
  final bool? isMinimalDesign;
  final void Function(String searchItem)? onChange;

  const CustomField({
    this.onChange,
    this.maxLine,
    this.minLine,
    super.key,
    this.label,
    required this.hintText,
    this.onSuffixIconTap,
    this.suffixIcon,
    this.isSized,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.topLabel,
    this.enabled,
    this.prefixIcon,
    this.width,
    this.focusNode,
    this.height,
    this.isMinimalDesign = false,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? .82.sw,
      decoration: BoxDecoration(
        boxShadow: widget.isMinimalDesign!
            ? []
            : [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(.1),
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: TextFormField(
        textAlign: TextAlign.start,
        onChanged: widget.onChange,
        minLines: widget.minLine ?? 1,
        maxLines: widget.maxLine ?? 1,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText! && !showText,
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 7),
          border: widget.isMinimalDesign!
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: const Color(0xff263238).withOpacity(.02),
                      width: 1),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
          enabledBorder: widget.isMinimalDesign!
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: const Color(0xff263238).withOpacity(.12),
                      width: 1),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
          focusedBorder: widget.isMinimalDesign!
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xff263238), width: 1),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
          fillColor: Colors.white,
          filled: true,

          // labelText: widget.controller.text.isEmpty ? null : widget.hintText,
          hintText: widget.controller.text.isEmpty ? widget.hintText : null,
          hintStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w300,
              color: AppColors.blackText.withOpacity(.5)),
          suffixIcon: widget.obscureText!
              ? IconButton(
                  icon:
                      Icon(showText ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showText = !showText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
