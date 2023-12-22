import 'package:flutter/material.dart';
import 'package:health_genie/helper/colors.dart';

extension CustomDeoration on InputDecoration  {

  InputDecoration customDecoration(String hintText, Icon prifixIcon){
    return InputDecoration(
      counterText: "",
      isDense: true,
      hintText: hintText,
      hintStyle: const TextStyle(color: colors.textColor),
      prefixIcon: prifixIcon,
      focusColor: colors.primary,
      contentPadding: const EdgeInsets.all(18.0),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius:  BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
    );
  }

}

extension CustomBoxDeoration on BoxDecoration  {

  BoxDecoration customBoxDecoration(){
    return BoxDecoration(
      color: colors.whiteTemp,
      borderRadius:  BorderRadius.circular(5.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          spreadRadius: 1,
          blurRadius: 3,
        ),
      ],
    );
  }

}