
import 'package:flutter/material.dart';
import 'package:grove_and_move/Constants/Text_Styles.dart';

Widget gridItem(String image, double height, double width, String text) {
  return Container(
    height: 0.2 * height,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
          height: 0.13 * height,
          width: 0.35 * width,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            text,
            style:headingTextStyle
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    ),
  );
}

