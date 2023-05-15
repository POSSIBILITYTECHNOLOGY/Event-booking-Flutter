// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../res/appImages.dart';
// import '../../res/colors.dart';
//
// class CommonTextFormFiiled extends StatelessWidget {
//   List<TextInputFormatter>? inputFormatter;
//   int? maxLength;
//   bool? isObscureText;
//   TextInputAction? textInputAction;
//   TextInputType? keyboardType;
//   AutovalidateMode? autovalidateMode;
//   FocusNode? focusNode;
//   FormFieldValidator<String>? validator;
//   TextEditingController? controller;
//   Widget? prefixIcon;
//   String? hint;
//   Widget? suffixIcon;
//
//   CommonTextFormFiiled(
//       {Key? key,
//       this.hint,
//       this.prefixIcon,
//       this.suffixIcon,
//       this.keyboardType,
//       this.controller,
//       this.validator,
//       this.focusNode,
//       this.autovalidateMode,
//       this.textInputAction,
//       this.isObscureText = false,
//         this.inputFormatter,
//       this.maxLength})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//        inputFormatters: inputFormatter,
//        // [FilteringTextInputFormatter.allow("^\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\$")],
//       maxLength: maxLength,
//       obscureText: isObscureText!,
//       textInputAction: textInputAction,
//       autovalidateMode: autovalidateMode,
//       focusNode: focusNode,
//       validator: validator,
//       controller: controller,
//       keyboardType: keyboardType,
//       style: const TextStyle(color: AppColor.white_Color),
//       decoration: InputDecoration(
//           errorStyle: TextStyle(fontSize: 14),
//           counterText: " ",
//           focusedErrorBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: AppColor.light_grey)),
//           errorBorder: const OutlineInputBorder(
//               borderSide: BorderSide(color: AppColor.light_grey)),
//           errorMaxLines: 2,
//           contentPadding: const EdgeInsets.only(bottom: 8),
//           prefixIcon: prefixIcon,
//           hintStyle: const TextStyle(
//               overflow: TextOverflow.clip,
//               color: AppColor.grey,
//               fontFamily: "Sora",
//               fontSize: 14),
//           hintText: hint,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
//           suffixIcon: suffixIcon),
//     );
//   }
// }
//
// class CommonTextFormFilled2 extends StatelessWidget {
//   bool? isObscureText;
//   List<TextInputFormatter>? inputFormatter;
//   int? maxLength;
//   AutovalidateMode? autovalidateMode;
//   TextInputAction? textInputAction;
//   FormFieldValidator<String>? validator;
//   TextEditingController? controller;
//   TextInputType? keyboardType;
//   Widget? prefixIcon;
//   String? hint;
//   Widget? suffixIcon;
//   FocusNode? focusNode;
//
//   CommonTextFormFilled2(
//       {Key? key,
//         this.isObscureText = false,
//         this.inputFormatter,
//         this.maxLength,
//         this.autovalidateMode,
//         this.textInputAction,
//       this.hint,
//       this.prefixIcon,
//       this.suffixIcon,
//       this.keyboardType,
//         this.focusNode,
//       this.controller,
//       this.validator})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 10,bottom: 10),
//       child: TextFormField(
//         obscureText: isObscureText!,
//         inputFormatters: inputFormatter,
//         maxLength: maxLength,
//         focusNode: focusNode,
//         autovalidateMode: autovalidateMode,
//         textInputAction: textInputAction,
//         validator: validator,
//         controller: controller,
//         keyboardType: keyboardType,
//
//         style: const TextStyle(color: AppColor.white_Color),
//         decoration: InputDecoration(
//             focusedErrorBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColor.light_grey)),
//             errorBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColor.light_grey)),
//           errorStyle: TextStyle(fontSize: 14),
//           counterText: " ",
//             contentPadding: const EdgeInsets.only(bottom: 8, left: 20),
//              prefixIcon: prefixIcon,
//             errorMaxLines: 3,
//
//
//          // Container(
//          //        padding: const EdgeInsets.only(top: 12,bottom: 12,left: 5),
//          //        child: Image.asset(AppImages.login_lock_Icon,height: 2)),
//             hintStyle: const TextStyle(
//
//                 color: AppColor.grey, fontFamily: "Sora", fontSize: 14),
//             hintText: hint,
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(5),
//                 borderSide: const BorderSide(color: AppColor.white_Color,width: 0.2)),
//             suffixIcon: suffixIcon
//             // Icon(Icons.remove_red_eye_outlined,color: AppColor.grey,),
//             ),
//       ),
//     );
//     ;
//   }
// }

// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../res/colors.dart';

class CommonTextFormFiiled extends StatelessWidget {
  List<TextInputFormatter>? inputFormatter;
  int? maxLength;
  bool? isObscureText;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  AutovalidateMode? autovalidateMode;
  FocusNode? focusNode;
  FormFieldValidator<String>? validator;
  TextEditingController? controller;
  Widget? prefixIcon;
  String? hint;
  Widget? suffixIcon;

  CommonTextFormFiiled(
      {Key? key,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.controller,
      this.validator,
      this.focusNode,
      this.autovalidateMode,
      this.textInputAction,
      this.isObscureText = false,
      this.inputFormatter,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatter,
      // [FilteringTextInputFormatter.allow("^\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\$")],
      maxLength: maxLength,
      obscureText: isObscureText!,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: AppColor.white_Color),
      decoration: InputDecoration(
          errorStyle: const TextStyle(fontSize: 14, color: AppColor.white_Color),
          counterText: " ",
          focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.light_grey)),
          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.light_grey)),
          errorMaxLines: 3,
          contentPadding: const EdgeInsets.only(bottom: 8),
          prefixIcon: prefixIcon,
          hintStyle: const TextStyle(overflow: TextOverflow.clip, color: AppColor.grey, fontFamily: "Sora", fontSize: 14),
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          suffixIcon: suffixIcon),
    );
  }
}

class CommonTextFormFilled2 extends StatelessWidget {
  bool? isObscureText;
  List<TextInputFormatter>? inputFormatter;
  int? maxLength;
  AutovalidateMode? autovalidateMode;
  TextInputAction? textInputAction;
  FormFieldValidator<String>? validator;
  TextEditingController? controller;
  TextInputType? keyboardType;
  Widget? prefixIcon;
  String? hint, counterText;
  Widget? suffixIcon;
  FocusNode? focusNode;
  double? top, outlineInputBorder;
  Color? fillColor, errorColor;
  bool? filled, enabled;
  void Function(String)? onChanged;
  CommonTextFormFilled2(
      {Key? key,
      this.isObscureText = false,
      this.inputFormatter,
      this.counterText,
      this.fillColor,
      this.filled,
      this.maxLength,
      this.top,
      this.errorColor,
      this.autovalidateMode,
      this.textInputAction,
      this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.keyboardType,
      this.focusNode,
      this.controller,
      this.outlineInputBorder,
      this.onChanged,
      this.enabled,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: top ?? 10, bottom: 10),
      child: TextFormField(
        onChanged: onChanged,
        obscureText: isObscureText!,
        inputFormatters: inputFormatter,
        maxLength: maxLength,
        enabled: enabled,
        focusNode: focusNode,
        autovalidateMode: autovalidateMode,
        textInputAction: textInputAction,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: AppColor.white_Color),
        decoration: InputDecoration(
            filled: filled ?? false,
            fillColor: fillColor,
            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.light_grey)),
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.light_grey)),
            disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.light_grey)),
            errorStyle: TextStyle(fontSize: 14, color: errorColor ?? Colors.white),
            counterText: counterText ?? " ",
            contentPadding: const EdgeInsets.only(bottom: 8, left: 20),
            prefixIcon: prefixIcon,
            errorMaxLines: 3,
            counterStyle: const TextStyle(color: Colors.white),

            // Container(
            //        padding: const EdgeInsets.only(top: 12,bottom: 12,left: 5),
            //        child: Image.asset(AppImages.login_lock_Icon,height: 2)),
            hintStyle: const TextStyle(color: AppColor.grey, fontFamily: "Sora", fontSize: 14),
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(outlineInputBorder ?? 5),
                borderSide: const BorderSide(color: AppColor.white_Color, width: 0.2)),
            suffixIcon: suffixIcon
            // Icon(Icons.remove_red_eye_outlined,color: AppColor.grey,),
            ),
      ),
    );
  }
}
