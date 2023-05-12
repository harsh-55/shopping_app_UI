

import 'package:advance_notification/advance_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/data/app_data.dart';
import 'package:shopping_app/model/base_model.dart';

class AddToCart {
  static void addToCart(BaseModel data,BuildContext context) {
    bool contains = itemsOnCart.contains(data);

    if(contains == true) {
       AdvanceSnackBar(
        textSize: 14,
         bgColor: Colors.red,
         message: 'You have added this item to cart before',
         mode: Mode.ADVANCE,
         duration: Duration(seconds: 5)
      ).show(context);
    }
    else {
      itemsOnCart.add(data);
      AdvanceSnackBar(
          textSize: 14,
          bgColor: Colors.green ,
          message: 'Successfully added to your cart',
          mode: Mode.ADVANCE,
          duration: Duration(seconds: 5)
      ).show(context);
    }

  }

}