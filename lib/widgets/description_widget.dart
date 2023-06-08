 import 'package:flutter/material.dart';
 
 Widget description_field(

     type, Size size, String hintText, TextEditingController cont) {
    final maxLines = 5;
    return Container(
      
      height: size.height / 5,
      width: size.width / 1.1,
      child: TextField(
        keyboardType: type,
        //autofocus: true,
        controller: cont,
        maxLines: maxLines,
        // style: TextStyle(height: size.height / 6),
        decoration: InputDecoration(
          hintText: hintText,
          
          hintStyle: TextStyle(color: Colors.grey , ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
