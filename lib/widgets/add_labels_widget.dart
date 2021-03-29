import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:code_munnity/utils/label.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class AddLabelsWidget extends StatefulWidget {
  final Article article;
  AddLabelsWidget({
    Key key,
    this.article
    }) : super(key: key);

  @override
  _AddLabelsWidgetState createState() => _AddLabelsWidgetState();
}

class _AddLabelsWidgetState extends State<AddLabelsWidget> {
  static List<Widget> _labelsWidgets;
  String labelText = "";
  @override
  void initState() {
    super.initState();
    _labelsWidgets = new List<Widget>();
    loadLabel();
  }
  @override
  Widget build(BuildContext context) {
    final maxElements = 4;
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0)),
      ),
      height: size.height*.5,
      width: size.width*.8,
      child: ListView(
        children: [
          
          // This container will show the label creation box 
          Container(  
            padding: colElementsPadding(),

            child: TextField(
              maxLength: 20,
              onChanged: (value) => labelText=value,
              decoration: InputDecoration(
                labelText: "Etiqueta"
              ),
            ),
          ),
          Container(
            child: FlatButton(
              onPressed: widget.article.labels.items.length > maxElements?null: (){setState(() {
                _addLabel(labelText);
              });}, 
              child: Row(
                children: [
                  Icon(Icons.add),
                  Text("Agregar")
                ],
              )
            )
          ),
          // This container will show the labels 
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _labelsWidgets,
               ),
          ),
        ],
      ),
    );
  }

  _addLabel(String lblName){
      final lengthLabels = widget.article.labels.items.length; 
      widget.article.labels.items.add(Label(name:lblName));
    setState(() {
      _labelsWidgets.add(
        Container(
          padding: EdgeInsets.all(10),
          child: Container(
          decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 0.5
          ),
          color: RandomColor().randomColor(colorHue: ColorHue.blue, colorBrightness: ColorBrightness.light)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(widget.article.labels.items[lengthLabels].name),
              ),
              
              IconButton(
                icon: Icon(Icons.delete_forever), 
                onPressed: ()=>{
                  deleteLabel(lblName)
                }
              )
            ],
          ),
        ) 
        )
      );
      
    });
  }
  
  deleteLabel(String name){
    
    var index = widget.article.labels.items.indexWhere((element) => element.name == name);
    print(index);
    setState(() {
      _labelsWidgets.removeAt(index);
      widget.article.labels.items.removeAt(index);
    });
  }

  loadLabel(){
    widget.article.labels.items.forEach((element) { 
      setState(() {
       
        _labelsWidgets.add(
        Container(
          padding: EdgeInsets.all(10),
          child: Container(
          decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 0.5
          ),
          color: RandomColor().randomColor(colorHue: ColorHue.blue, colorBrightness: ColorBrightness.light)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(element.name),
              ),
              
              IconButton(
                icon: Icon(Icons.delete_forever), 
                onPressed: ()=>{
                  deleteLabel(element.name)
                }
              )
            ],
          ),
        ) 
        )
      );
      });
    });
  }

  



}


