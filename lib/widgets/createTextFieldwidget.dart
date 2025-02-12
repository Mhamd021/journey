// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../consts/dimensions.dart';

class Createtextfieldwidget extends StatelessWidget {

  final TextEditingController textController;
  final String hintText;
  final IconData icon;
  final bool isObs;
  
  const Createtextfieldwidget({

    super.key,
    required this.textController,
    required this.hintText,
    required this.icon,
    this.isObs = false,
    
  });

 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          boxShadow: [
            BoxShadow(
              blurRadius: 12,
              spreadRadius: 7,
              offset: Offset(1, 7),
              color: Colors.grey.withOpacity(0.2),
            )
          ]),
      child: TextFormField(
        obscureText: isObs ? true : false,
        controller: textController,
         validator: (value) {
              if (value == null || value.isEmpty) {
                return 'this field is required';
              }
              return null;
            },

        decoration: InputDecoration(
          hintText: hintText ,
          hintStyle: TextStyle
          (
            color: Colors.grey[350]
          ),
          prefixIcon: Icon(icon, color: Colors.blue),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,
              )),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius30),
          ),
        ),
      ),
    );
  }
}
