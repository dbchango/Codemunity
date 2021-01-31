import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class LabelWidget extends StatelessWidget {
  final String text;
    const LabelWidget({Key key, this.text}) : super(key: key);
  
    @override
    Widget build(BuildContext context) {
      return Container(
        child: Container(
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 0.5
        ),
        color: RandomColor().randomColor(colorHue: ColorHue.blue, colorBrightness: ColorBrightness.light)
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(text),
      ),
    )
      );
    }
  }