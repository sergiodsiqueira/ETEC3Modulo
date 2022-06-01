import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Item {
  int id;
  String name;
  double price;
  
  RxBool
      inWishList; 
  Item(
      {required this.id,
      required this.name,
      required this.price,
      required this.inWishList});
}

//https://www.kindacode.com/article/using-getx-get-for-state-management-in-flutter/
//https://kauemurakami.github.io/getx_pattern/#home