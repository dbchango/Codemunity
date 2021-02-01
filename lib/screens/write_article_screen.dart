import 'dart:io';

import 'package:code_munnity/models/article.dart';
import 'package:code_munnity/providers/articles_service.dart';
import 'package:code_munnity/providers/storage_service.dart';
import 'package:code_munnity/screens/collection_screen.dart';
import 'package:code_munnity/screens/edit_widget.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:code_munnity/utils/label.dart';
import 'package:code_munnity/widgets/add_labels_widget.dart';
import 'package:code_munnity/widgets/label_widget.dart';
import 'package:code_munnity/widgets/select_category_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:zefyr/zefyr.dart';

class WriteArticleScreen extends StatefulWidget {
  WriteArticleScreen({Key key}) : super(key: key);

  @override
  _WriteArticleScreenState createState() => _WriteArticleScreenState();
}

class _WriteArticleScreenState extends State<WriteArticleScreen> {
  bool _buttonModalFlag = false;
  ZefyrController _editorController;
  FocusNode _editorFocusNode;
  Article _article;
  List<Widget> elements = new List<Widget>();
  static List<Widget> _references = <Widget>[];
  static List<String> _referencesNames = <String>[];
  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ArticleService _service = new ArticleService();
  StorageService _storageService = StorageService();
  var _showEditor = false;
  var _size;
  File _img ;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _article = new Article();
    _article.labels = new Labels();
    _article.idauthor = 'skdJALV391eE5p1EVItb';
    _article.idcategory = 'e1fCPgEuHNB00w3ktHnL';
    _article.references = new References();
    final document = _loadDocument();
    _editorController = ZefyrController(document);
    _editorFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: ZefyrScaffold(
        
        child: Form(
          key: formKey,
          child: _getFormContent()
        ),
      ),
    );
  }

  /// This function returns the form 
  Widget _getFormContent(){
    final _size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Padding(
          padding: topElementsPadding(),
          child: Container(
            child: Text("Nueva Publicación" ,
            maxLines: 1,
            style: titleStyles(),)
          ),
        ),
        _getTitleInput(),
        _getAbstractInput(),
        _getLabelsWidgets(),
        _getReferencesBox(),
        _getImageContainer(),
        _getSaveButton(),
        
        TextButton(
          onPressed: (){
            Navigator.push(context,  MaterialPageRoute(builder: (context)=> EditWidget(article: _article,)));
          }, 
          child: Container(
          child: Row(
            children: <Widget>[
              Icon(Icons.description_outlined),
              Text("Edit article")
            ],
          ),
          )
        ),
        TextButton(
          onPressed: (){
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddLabelsWidget(article: _article,);
              },

            ).then((value) {
              _getLabels();
              print(_article.toJson());
            });
          }, 
          child: Container(
          child: Row(
            children: <Widget>[
              Icon(Icons.description_outlined),
              Text("Add labels")
              
            ],
          ),
          )
        ),
        TextButton(
          onPressed: (){
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return SelectCategoryWidget(article: _article,);
              },

            ).then((value) {
              print("Modal cerrado");
              print(_article.toJson());
            });
          }, 
          child: Container(
          child: Row(
            children: <Widget>[
              Icon(Icons.description_outlined),
              Text("Seleccionar categoria")
            ],
          ),
          )
        ),
        
      ],
    );
  }

  Widget _getLabelsWidgets(){
    return Container(
      padding: colElementsPadding(),
      child: Row(
        children: elements,
      )
    );
  }

  _getLabels(){
    setState(() {
      elements.clear();
      _article.labels.items.forEach((element) { 
      elements.add(
        LabelWidget(text: element.name,)
      );
    });
    });
  }

  /// This function returns reference box content
  Widget _getReferencesBox(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1
        ),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text("Referencias"),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(              
                    borderRadius: BorderRadius.circular(5)
                  ),            
                  child: IconButton(
                    onPressed: _onTapAddRef, 
                    icon: Icon(Icons.add, color: Theme.of(context).accentColor,),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
                  child: Text("Agregar referencia"),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5)
              ),
              
              child: Column(
                children: _references,
              ),
            ),
          ),            
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5)
                ),  
                child: TextButton(onPressed: _onTapDeleteRef, child: Icon(Icons.remove, color: Theme.of(context).accentColor))
              ),
            ],
          )
        ],
      ),
    );
  }

  /// This function returns the container for upload an image
  Widget _getImageContainer(){
    return Padding(
      padding: colElementsPadding(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1.0
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: _img!=null?Image.file(_img):Image.asset('assets/images/no-image.png'),

            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text("Subir una imágen"),
            ),
            GestureDetector(
              onTap: _selectImg,
              child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Icons.upload_file),

            ) 
            )
          ],
        )
      ),
    );
  }

  /// Function that add references spaces
  _onTapAddRef(){
    final arrayLength = _article.references.references.length;
      final String newTitle = "Referencia "+(arrayLength+1).toString(); 
      //_referencesNames.add(newTitle);
      _article.references.references.add(Reference(reference: newTitle));
      setState(() {
          _references.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical:8.0),
            child: TextFormField(
              onChanged: (value) {
                print(value);
                _article.references.references[arrayLength].reference = value;
              },
              decoration: InputDecoration(        
                border: OutlineInputBorder(),
                labelText: _article.references.references[arrayLength].reference,
                alignLabelWithHint: true 
              ),
              onSaved: (newValue) {
                _article.references.references[arrayLength].reference = newValue;
              },
            ),
          )
        );
      });
  }

  /// This function that return the save button widget
  Widget _getSaveButton(){
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: _size*.7,
          
            child: TextButton(onPressed: _onSave, child: Container(
              decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(5)
            ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Publicar"),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(Icons.send),
                  ),
                  
                ],
              ),
            ))
          ),
          
        ],
      )
    );
  }

  /// This function return title input widget
  Widget _getTitleInput(){
    
    return TextFormField(
      onChanged: (value) => _article.title = value,
      focusNode: new FocusNode(),
      decoration: InputDecoration(
        //border: InputBorder.none,
        labelText: "Título",
        //alignLabelWithHint: true,
          
      ),
      maxLength: 40,
      onSaved: (newValue) => _article.title = newValue,
      validator: (value) {
          if (value.length > 0){
            return null;
          }else{
            return "Llene el campo";
          }
        },
      );
  }

  /// This function return the abstract input
  Widget _getAbstractInput(){
    return TextFormField(
      onChanged: (value) => _article.abstract = value,
      focusNode: new FocusNode(),
      decoration: InputDecoration(
        //border: InputBorder.none,
        labelText: "Resúmen",
        //alignLabelWithHint: true,
          
      ),
      maxLength: 200,
      maxLines: 5,
      onSaved: (newValue) => _article.abstract = newValue,
      validator: (value) {
          if (value.length > 0){
            return null;
          }else{
            return "Llene el campo";
          }
        },
      );
  }

  /// This function removes the last reference from the list
  _onTapDeleteRef(){
   setState(() {
      _article.references.references.removeLast();
      _references.removeLast();
   });
  }

  /// Function that POST the article
  _onSave() {
    _getLabels();
    print(_article.toJson());
    //if( !formKey.currentState.validate() ) return;
    //formKey.currentState.save();
    //print(_article.title);
    //print(_article.abstract);
    //print(_article.content);
  _article.references.references.forEach((element) {
    print(element.reference);
  });
    /*
    if(!_formKey.currentState.validate())return;
    _formKey.currentState.save();
    /*if (_img != null) {
      _article.imgurl = await _storageService.uploadImg(_img);
    }*/

    print(_article.toJson());
    print(_article.title);
    print(_article.content);
    _article.references.references.forEach(
      (element) {
        print(element.reference);
      }
    );

    await _service.creatArticle(_article).then(
      (value) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text("${value.title}\n${value.text}"),
            action:SnackBarAction(
            label: 'Regresar a inicio', 
            onPressed: (){
              print('Ok lets return to home');
              Navigator.of(context).pop();
            }
          ),
          )
        );
      }
    );
    */

  }

  /// This function executes the method to upload to select and upload an image
  _selectImg() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedFile!=null){
        _img = File(pickedFile.path);
      }else{
        print("No ha seleccionado una imagen");
      }
    });
  }

  /// This function return the document for the Zefyr text editor 
  NotusDocument _loadDocument(){
    final Delta delta = Delta()..insert("Contenido ... \n");
    return NotusDocument.fromDelta(delta); 
  }

  

}