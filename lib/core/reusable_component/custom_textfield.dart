// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class CustomTextFormField extends StatelessWidget {
//   final String? label;
//   final int? maxLength;
//   final TextStyle? textStyle;
//   final String? hintText;
//   final TextStyle? hintStyle;
//   final double borderRadius;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final bool obscureText;
//   final TextInputType? keyboardType;
//   final String? obscuringCharacter;
//   final Widget? suffixIcon;
//   final Color fillColor;
//   final FloatingLabelBehavior? floatingLabelBehavior;
//
//   const CustomTextFormField({
//     super.key,
//     this.label,
//     this.maxLength,
//     this.textStyle,
//     this.hintStyle,
//     this.controller,
//     this.obscureText = false,
//     this.keyboardType,
//     this.borderRadius = 0.0,
//     this.obscuringCharacter,
//     this.hintText,
//     this.validator,
//     this.fillColor = Colors.white,
//     this.suffixIcon,
//     this.floatingLabelBehavior,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       cursorColor: Colors.blue,
//       style: textStyle,
//       inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
//       validator: validator,
//       controller: controller,
//       obscureText: obscureText,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         fillColor: fillColor,
//         filled: true,
//         labelText: label,
//         hintText: hintText,
//         hintStyle: hintStyle,
//         suffixIcon: suffixIcon,
//         floatingLabelBehavior: floatingLabelBehavior,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.red),
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//       ),
//     );
//   }
// }
