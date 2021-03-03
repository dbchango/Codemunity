import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const double titleFontSize = 30.0; 
const double subtitleFontSize = 20.0; 
const double textFontSize = 14.0; 

TextStyle subtitleStyles(){
  return TextStyle(
    fontSize: subtitleFontSize,
    fontWeight: FontWeight.bold 
  );
}

TextStyle titleStyles(){
  return TextStyle(
    fontSize: titleFontSize,
    fontWeight: FontWeight.bold 
  );
}
TextStyle textStyles(){
  return TextStyle(
    fontSize: textFontSize,   
  );
}

 /// This function determines the padding of the column's elements
 /// It is used in article_page

EdgeInsetsGeometry colElementsPadding(){
  return EdgeInsets.only(left: 40, right: 40, top: 5, bottom: 5);
}

 /// This functions returns the padding for the elements of the top of a column
 /// the distance between the top and the element is more, meanwhile this configuration exists
 /// It is used in article_page 
 ///
EdgeInsetsGeometry topElementsPadding(){
  return EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 10);
}

 /// This is the padding for the image in the article page, the horizaontal padding in this case is less than the other elements
 /// it is used in article_page
 
EdgeInsetsGeometry imageNearBorder(){
  return EdgeInsets.symmetric(horizontal: 5);
}
/// Input border decotarion
OutlineInputBorder inputBorder(context){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(35.0),
    borderSide: BorderSide(
      color: Theme.of(context).accentColor,
      width: 1
    ),
  );
}


BoxDecoration boxDecForm(context){
  return BoxDecoration(
    
    border: Border.all(
      color: Theme.of(context).accentColor,
      width: 1
    ),
    borderRadius: BorderRadius.circular(35.0)
  );
}






