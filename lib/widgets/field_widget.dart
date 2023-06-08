 import 'package:flutter/material.dart';
 
 Widget field(

     type, Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        keyboardType: type,
        //autofocus: true,
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey , ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
