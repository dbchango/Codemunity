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
  static List<Widget> _labelsWidgets = <Widget>[
    
  ];
  String labelText = "";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
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
              onChanged: (value) => labelText=value,
              decoration: InputDecoration(
                labelText: "Etiqueta"
              ),
            ),
          ),
          Container(
            child: FlatButton(
              onPressed: (){setState(() {
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
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _labelsWidgets,
               ),
          ),
        ],
      ),
    );
  }

  _addLabel(String lblName){
    print(lblName);
      print(widget.article.labels.items.length);
      final lengthLabels = widget.article.labels.items.length; 
      widget.article.labels.items.add(Label(name:lblName));
    setState(() {
      _labelsWidgets.add(
        Container(
          child: Container(
          decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            width: 0.5
          ),
          color: RandomColor().randomColor(colorHue: ColorHue.blue, colorBrightness: ColorBrightness.light)
          ),
          child: Row(
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
          
          /*LabelWidget(
            text:widget.article.labels.items[lengthLabels].name,
            delete: ()=>print("Delete"),
          ),*/
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

}

