import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  TextEditingController? controller;
  bool? obscureText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  String? hintText;
  CommonTextField({super.key,required this.hintText,required this.controller,this.obscureText=false,required this.prefixIcon,this.suffixIcon});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // enabled: false,
      // value halnai mildaina enable false bahysi
      // texteditorcontoller type ho data type
      controller: widget.controller,
      // text field ko data visible hudaina
      obscureText: widget.obscureText!,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        // gesturedetector rakna ni mil
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                color: Colors.grey,width: 2
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
                color: Colors.green,width: 2
            )
        ),




      ),

    );
  }
}
