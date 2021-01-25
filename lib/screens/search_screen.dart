import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/widgets/area_btn_widget.dart';
import 'package:flutter/material.dart';

class SearcScreen extends StatefulWidget {
  SearcScreen({Key key}) : super(key: key);

  @override
  _SearcScreenState createState() => _SearcScreenState();
}

class _SearcScreenState extends State<SearcScreen> {
  ArticleService _service;
  Articles _list;
  @override
  void initState() {
    _service = new ArticleService();
    super.initState();
    
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size;
    return Stack(
      children: [
        Container(
          child: Image.asset('assets/images/logo_black_letters.png')
        ),
        Container(
          child: TextField(
            
          )
        ),
        Container(
          padding: EdgeInsets.all(80),
          child: Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      AreaButtonWidget(
                        title: "Medicina",
                        svgSrc: 'assets/images/no-image.png',
                      ),
                      AreaButtonWidget(
                        title: "Mecánica",
                        svgSrc: 'assets/images/no-image.png',
                      ),
                      AreaButtonWidget(
                        title: "Software",
                        svgSrc: 'assets/images/no-image.png',
                      ),
                      AreaButtonWidget(
                        title: "Biología",
                        svgSrc: 'assets/images/no-image.png',
                      )
                    ],
                  )

            
          )
        )
      ]
      

          
      
    );
    
  }

}