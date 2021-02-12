
import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/models/category.dart';
import 'package:code_munnity/providers/categories_service.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:flutter/material.dart';

class SelectCategoryWidget extends StatefulWidget {
  
  final Article article;
  SelectCategoryWidget({Key key, this.article}) : super(key: key);

  @override
  _SelectCategoryWidgetState createState() => _SelectCategoryWidgetState();
}

class _SelectCategoryWidgetState extends State<SelectCategoryWidget> {
  List<bool> _selectionFlags;
  CategoriesService _ctgsService;
  Categories _categories;
  //String _selection;
  bool _buttonModalFlag;
  @override
  void initState() {
    super.initState();
    
    setState(() {
      //_selection ="";
    _ctgsService = new CategoriesService();
    _categories = new Categories();
    _getCategories();
    _buttonModalFlag = false;
    });
   
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    
    return Container(
       child: _categories == null? CircularProgressIndicator():
       ListView(
         children: [
           Container(
            color: _buttonModalFlag==false?Theme.of(context).backgroundColor:Theme.of(context).accentColor,
            padding: EdgeInsets.all(15),
            child: GestureDetector(
              onTap:(_buttonModalFlag==true)? () {
                Navigator.of(context).pop();
                _buttonModalFlag=false;
              }:(){},
              child: Container(
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Aceptar"),
                    Icon(Icons.done)
                  ],
                  ),
                ),
              ),
          ),
           Container(
             padding: topElementsPadding(),
             child: Text("Categoriza tu publicación:"),
           ),
           Container(
             padding: colElementsPadding(),
             child: Column(
               
               children: _categories.items.map((e) {
                return GestureDetector(
                    onTap: () {
                              setState(() {
                                _activateButton(_categories.items.indexWhere((element) => e==element));
                              });
                            },
                          child: Card(
                            color: _selectionFlags[_categories.items.indexWhere((element) => e==element)]==true?Theme.of(context).backgroundColor:Theme.of(context).focusColor,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(e.name, style: TextStyle(color: Colors.black),),
                                      (_selectionFlags[_categories.items.indexWhere((element) => e==element)]==true)?Icon(Icons.check):Icon(Icons.circle)
                                    ]
                                  ),
                              ),
                          )
                        );
              }).toList(),
             ),
           ),
           

         ]
       )
    );
  }

  _getCategories() async {
    await _ctgsService.getCategories().then((value){
      _categories = value;
       if(mounted){
         setState(() {
         _selectionFlags = List(_categories.items.length);
         _buttonModalFlag = true;
       });
       }
    });
  }

  _activateButton(int activeButton){
    setState(() {
      for(int i=0; i<_selectionFlags.length;i++){
        _selectionFlags[i] = false;
      }
      _selectionFlags[activeButton] = true;
      widget.article.idcategory = _categories.items[activeButton].id;
    });
    
  }


}