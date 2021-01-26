import 'package:flutter/material.dart';

class AreaButtonWidget extends StatelessWidget {
  final String svgSrc;
  final String title;
  
  const AreaButtonWidget(
    {
      Key key,
      this.svgSrc,
      this.title
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26
          ),
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: Colors.transparent
            )
          ]
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (){},
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Image.asset(svgSrc, height: 50,color: Theme.of(context).bottomAppBarColor,),
                  Spacer(),
                  Text(
                    title, 
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: 13, ),
                  )
                ]
              ),
            ),
          ),
        ),
      );
  }
}