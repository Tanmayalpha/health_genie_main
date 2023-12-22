import 'package:flutter/material.dart';

void setSnackbar (BuildContext context, String? msg){
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       content: Text(msg ?? ''),

   )) ;
}