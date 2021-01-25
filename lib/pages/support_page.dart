import 'dart:io';

import 'package:code_munnity/models/support_message.dart';
import 'package:code_munnity/providers/support_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class SupporPage extends StatefulWidget {
  SupporPage({Key key}) : super(key: key);

  @override
  _SupporPageState createState() => _SupporPageState();
}

class _SupporPageState extends State<SupporPage> {
  SupportMessage _supportMessage = new SupportMessage();
  SupportService _service = new SupportService();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  var _size;
  File _img ;
  
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {

     _size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text('Soporte'),
        ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white
        ),
        padding: EdgeInsets.all(40),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Form(
            key:formKey,
            child: ListView(
              children: <Widget>[
                Center(child: Text("Escríbenos", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                _getTitleInput(),
                _getTextInput(),
                _getImgBox(),
                _getSubmitButton()
              ],
            )
          ),
        )
      ),
    );
  }
  
  Widget _getTitleInput(){
    return TextFormField(
              decoration: InputDecoration(
                labelText: "Title"
              ),
              maxLength: 100,
              initialValue: _supportMessage.title,
              onSaved: (value){
                setState(() {
                  _supportMessage.title = value;
                });
              },
            );
  }

  Widget _getTextInput(){
    return TextFormField(
          decoration: InputDecoration(
                labelText: "Content"
          ),
          maxLength: 200,
          maxLines: 10,
          initialValue: _supportMessage.text,
          onSaved: (value){
            setState(() {
              _supportMessage.text = value;
            });
          },
        );
  }
   
  Widget _getSubmitButton(){
    return GestureDetector(
      onTap: _submitForm,
      child: Container(
        child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _size*.7,
                    child: TextButton(onPressed: _submitForm, child: Container(
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
      ),
    );
  }

  _getImgBox(){
    return  Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black12,
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
                      onTap: (){
                        _selectImg();
                      },
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

  _submitForm() async {
    if( !formKey.currentState.validate() ) return;

    formKey.currentState.save();
    print(_supportMessage);
    if (_img != null) {
      _supportMessage.screenshot = await _service.uploadImage(_img);
    }

    _service.post(_supportMessage).then((value){
      scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("No enviado")),
        );
     if (value != null) {
        formKey.currentState.reset();
        scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(value.text)),
        );
      }
    });

  }
}