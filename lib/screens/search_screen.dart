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
          child: Image.asset('assets/images/logo_black_letters.png'),
          padding: EdgeInsets.only(top:30, left: 70, right:70),
        ),
        Container(
          padding: EdgeInsets.only(top:130, bottom: 20, left: 50, right:50),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Buscar...",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35.0),
                borderSide: BorderSide()
              )
              

            ),
            
          )
        ),
        Container(
          padding: EdgeInsets.only(top:220, bottom: 20, left: 80, right:80),
          child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: .85,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 10,
                        children: <Widget>[
                          
                          AreaButtonWidget(
                            title: "Medicina",
                            svgSrc: 'assets/images/stethoscope-solid.png',
                          ),
                          AreaButtonWidget(
                            title: "Mecánica",
                            svgSrc: 'assets/images/cogs-solid.png',
                          ),
                          AreaButtonWidget(
                            title: "Software",
                            svgSrc: 'assets/images/code-solid.png',
                          ),
                          AreaButtonWidget(
                            title: "Electricidad",
                            svgSrc: 'assets/images/plug-solid.png',
                          ),
                          AreaButtonWidget(
                            title: "Matemáticas",
                            svgSrc: 'assets/images/square-root-alt-solid.png',
                          ),
                          AreaButtonWidget(
                            title: "Electrónica",
                            svgSrc: 'assets/images/robot-solid.png',
                          )
                        ],
                      ),
        ),
        
        
      ]
      

          
      
    );
    
  }

}