import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_munnity/bloc/login_bloc.dart';
import 'package:code_munnity/models/author.dart';
import 'package:code_munnity/pages/main_page.dart';
import 'package:code_munnity/providers/auth.dart';
import 'package:code_munnity/providers/provider_bloc.dart';
import 'package:code_munnity/providers/storage_service.dart';
import 'package:code_munnity/providers/user_provider.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class AuthorRegisterPage extends StatefulWidget {
  AuthorRegisterPage({Key key}) : super(key: key);

  @override
  _AuthorRegisterPageState createState() => _AuthorRegisterPageState();
}

class _AuthorRegisterPageState extends State<AuthorRegisterPage> {
  CollectionReference _authorCollection = FirebaseFirestore.instance.collection('authors');
  int currentStep = 0;
  File _img ;
  bool onSaving = false;
  StorageService _service = new StorageService();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final picker = ImagePicker();
  final UserProvider userProvider = UserProvider(); 
  final AuthService _auth = AuthService();
  Author _author;
  final _formKey = GlobalKey<FormState>();
  bool formFlag = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _author = new Author();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
       child: Scaffold(
         key: scaffoldKey,
      body: Container(
        child: SafeArea(
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation){
              switch (orientation) {
              case Orientation.portrait:
                return _buildStepper(StepperType.vertical);
              case Orientation.landscape:
                return _buildStepper(StepperType.horizontal);
              default:
                throw UnimplementedError(orientation.toString());
            }
            }
          ),
        ),
      ),  
    )
    );
  }
  CupertinoStepper _buildStepper(StepperType type) {
    final canCancel = currentStep > 0;
    final canContinue = currentStep < 4;
    
    return CupertinoStepper(
      type: type,
      currentStep: currentStep,
      onStepTapped: (step) => setState(() => currentStep = step),
      onStepCancel: canCancel ? () => setState(() => --currentStep) : null,
      onStepContinue: canContinue ? () => setState(() => ++currentStep) : null,
      steps: [
        

        _buildStep(
            title: Text('Step 1'),
            subtitle: Text('Credenciales'),
            isActive: 0 == currentStep,
            content: _getRegisterForm(context),
            state: 0 == currentStep
                ? StepState.editing
                : 0 < currentStep ? StepState.complete : StepState.indexed,
          ),
          _buildStep(
            title: Text('Step 2'),
            content: _getAuthorForm(),
            subtitle: Text('Hablanos más de ti'),
            isActive: 1 == currentStep,
            state: 1 == currentStep
                ? StepState.editing
                : 1 < currentStep ? StepState.complete : StepState.indexed,
          ),
          _buildStep(
            title: Text('Step 3'),
            subtitle: Text('Sube una foto'),
            isActive: 2 == currentStep,
            content: Container(
              child: _getImageContainer(),
            ),
            state: 2 == currentStep
                ? StepState.editing
                : 2 < currentStep ? StepState.complete : StepState.indexed,
          ),
          _buildStep(
            title: Text('Step 4'),
            subtitle: Text('Finalizar'),
            isActive: 3 == currentStep,
            state: 3 == currentStep
                ? StepState.editing
                : 3 < currentStep ? StepState.complete : StepState.indexed,
            content: _getSubmit(context)
          ),
      ],
    );
  }
  Step _buildStep({
    Widget title,
    Widget subtitle,
    StepState state = StepState.indexed,
    bool isActive = false,
    Widget content
  }) {
    return Step(
      title: title,
      subtitle: subtitle,
      state: state,
      isActive: isActive,
      content: LimitedBox(
        maxWidth: 300,
        maxHeight: 400,
        child: content
          ),
    );
  }
  Widget _getRegisterForm(BuildContext context){
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;
    final bloc = LoginProvider.of(context);
    return Column(
        children: [
        
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            width: size.width * .80,
         
            child: Column(
              children: [
  
                SizedBox(
                  height: 25.0,
                ),
                _getEmail(bloc),
                SizedBox(
                  height: 25.0,
                ),
                _getPassword(bloc),
                SizedBox(
                  height: 25.0,
                ),
                
               
                
              ],
            ),
          )
        ],
      );
  }

  Widget _getEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          decoration: InputDecoration(
              icon:
                  Icon(Icons.email, color: Theme.of(context).primaryColorDark),
              hintText: 'usuario@mashcabus.com',
              labelText: 'Correo electrónico',
              errorText: snapshot.error),
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget _getPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
              icon: Icon(Icons.lock_outline,
                  color: Theme.of(context).primaryColorDark),
              labelText: 'Contraseña',
              errorText: snapshot.error),
          onChanged: bloc.changePassword,
        );
      },
    );
  }

  Widget _getSubmit(BuildContext context) {
    final bloc = LoginProvider.of(context);
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              child: Text('Registrar'),
            ),
            textColor: Theme.of(context).primaryColorDark,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: (snapshot.hasData && formFlag) ? () => _submit(bloc, context) : null);
      },
    );
  }

  _submit(LoginBloc bloc, BuildContext context) async {
    if( !_formKey.currentState.validate() ) return;
    setState(() {
      onSaving = true;
    });
    _formKey.currentState.save();
    if (_img != null) {
      _author.avatarimgurl = await _service.uploadImg(_img);
    }else{
      _author.avatarimgurl = 'https://firebasestorage.googleapis.com/v0/b/consultoriovet-eb010.appspot.com/o/unknown_user.png?alt=media&token=a18973b1-50d7-41cc-a4cd-d836ff4f94f8';
    }
    dynamic result = await  _auth.createUserWithEmailAndPassword(bloc.email, bloc.password);
    if(result==null){
      print("Error al registrar");
    }else{
      print('Success register');
      print(result.toString());
      
      User currentUser = await _auth.user.first;


      _author.mail = currentUser.email;
      _author.uid = currentUser.uid;
      print(_author.toJson());
      _authorCollection.add(_author.toJson()).then((value) {
        if(value!=null){
        _formKey.currentState.reset();
        _img = null;
        scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Usuario creado con éxito."))
        );
        setState(() {
          onSaving = false;
        });
      }
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
      });
      
      
      
    }
  }

  Widget _getAuthorForm(){
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _getNameTextField(),
          _getSurnameTextField(),
          _getKnowledgeAreaTextField(),
          _getAboutTextField()
        ],
      ),
    );
  }

  Widget _getNameTextField(){
    return TextFormField(
            initialValue: _author.name,
            onChanged: (value) {
              _author.name = value;
              formFlag = _formKey.currentState.validate();
              print(formFlag);
              print(FirebaseAuth.instance.currentUser);
            },
            focusNode: new FocusNode(),
            decoration: InputDecoration(
              
              labelText: 'Nombre',
              prefixIcon: Icon(Icons.text_fields)
            ),
            maxLength: 100,
            onSaved: (newValue) {
              _author.name = newValue;
            },
            validator: (value) {
              if (value.length > 0){
                return null;
              }else{
                return "Llene el campo";
              }
            },
          ); 
  }

  Widget _getSurnameTextField(){
    return TextFormField(
      initialValue: _author.surname,
      onChanged: (value) {
        _author.surname = value;
        formFlag = _formKey.currentState.validate();
              print(formFlag);
      },
      focusNode: new FocusNode(),
      decoration: InputDecoration(
        labelText: 'Apellido',
        prefixIcon: Icon(Icons.text_format)
      ),
      maxLength: 100,
      onSaved: (newValue) {
        _author.surname = newValue;
      },
      validator: (value) {
        if (value.length > 0){
          return null;
        }else{
          return "Llene el campo";
        }
      },
    );
  }

  Widget _getKnowledgeAreaTextField(){
    return TextFormField(
      initialValue: _author.knowledgearea,
      onChanged: (value) {
        _author.knowledgearea = value;
        formFlag = _formKey.currentState.validate();
              print(formFlag);
      },
      focusNode: new FocusNode(),
      decoration: InputDecoration(
        labelText: 'Área de conocimiento',
        prefixIcon: Icon(Icons.text_fields_outlined)
      ),
      maxLength: 150,
      onSaved: (newValue) {
        _author.knowledgearea = newValue;
      },
      validator: (value) {
        if (value.length > 0){
          return null;
        }else{
          return "Llene el campo";
        }
      },
    );
  }

  Widget _getAboutTextField(){
    return TextFormField(
      initialValue: _author.about,
      onChanged: (value) {
        _author.about = value;
        formFlag = _formKey.currentState.validate();
              print(formFlag);
      },
      focusNode: new FocusNode(),
      decoration: InputDecoration(
        labelText: 'Acerca de mi',
        prefixIcon: Icon(Icons.info)
      ),
      maxLength: 200,
      maxLines: 3,
      onSaved: (newValue) {
        _author.about = newValue;
      },
      validator: (value) {
        if (value.length > 0){
          return null;
        }else{
          return "Llene el campo";
        }
      },
    );
  }

  Widget _getImageContainer(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: _img!=null?Icon(Icons.check):Image.asset('assets/images/unknown_user.png'),

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

}