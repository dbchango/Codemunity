import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:code_munnity/bloc/login_bloc.dart';
import 'package:code_munnity/pages/author_register_page.dart';
import 'package:code_munnity/pages/main_page.dart';
import 'package:code_munnity/pages/register_page.dart';
import 'package:code_munnity/providers/auth.dart';
import 'package:code_munnity/providers/provider_bloc.dart';
import 'package:code_munnity/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:code_munnity/theme/constants.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserProvider userProvider = UserProvider(); 
  final AuthService auth = AuthService();
  @override
  void initState() {
    
    super.initState();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp
      ]
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Scaffold(
        body: Stack(
          children: [
            _getBackground(context),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              width: MediaQuery.of(context).size.width,
              child: _getFormLogin(context),
            )
          ],
        ),
      )
    );
  }

  Widget _getBackground(BuildContext context){
    final size = MediaQuery.of(context).size;
    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Theme.of(context).primaryColorDark.withAlpha(100)
      ),
    );
    return Stack(
      children: [
        Container(
          height: size.height * 0.4,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColorLight,
              ] )
          ),
        ),
        Positioned(top: 90, left: 30, child: circle),
        Positioned(top: -40, left: -30, child: circle),
        Positioned(bottom: -50, right: -10, child: circle),
        Positioned(bottom: 120, right: 20, child: circle),
        Positioned(bottom: -50, left: -20, child: circle),
        SafeArea(
          child: Center(
            child : Container(
              padding: EdgeInsets.only(top:75.0),
              child: Column(
              
                children: [
                  getLogoImg(height: 75),
                ],
              ),
            ),
          )
        )
      ],
    );
  }

  Widget _getFormLogin(BuildContext context){
    final size = MediaQuery.of(context).size;
    final primaryColor = Theme.of(context).primaryColor;
    final bloc = LoginProvider.of(context);
    return SingleChildScrollView(
          child: Column(
          children: [
            SafeArea(child: Container(height: 180.0,)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              width: size.width * .80,
              decoration:  BoxDecoration(
                color: Theme.of(context).canvasColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3.0
                  )
                ]
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Iniciar Sesión',
                    style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color:primaryColor),),
                  ),
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
                  //_getSubmit(bloc),
                  //SizedBox(
                  //  height: 25.0,
                  //),
                  //_getSubmitFirebaseAuthAnon(bloc),
                  //SizedBox(
                  //  height: 25.0,
                  //),
                  _getSubmitFirebaseAuth(bloc),
                  SizedBox(
                    height: 25.0,
                  ),
                  _getRegisterButton(context),
                  SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            )
          ],
        ),
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
              hintText: 'usuario@mail.com',
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

  Widget _getSubmit(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
            disabledColor: Theme.of(context).backgroundColor,
            child: Container(
            
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              child: Text('Ingresar'),
            ),
            textColor: Colors.amber,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: snapshot.hasData ? () => _submit(bloc, context) : null);
      },
    );
  }

  Widget _getSubmitFirebaseAuthAnon(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
        
            disabledColor: Theme.of(context).backgroundColor,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              child: Text('Ingresar FirebaseAuth Anon'),
            ),
            textColor: Theme.of(context).backgroundColor,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: () => _submitFirebaseApp(bloc, context));
      },
    );
  }

  Widget _getSubmitFirebaseAuth(LoginBloc bloc){
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
        disabledColor: Theme.of(context).backgroundColor,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Ingresar'),
                  Icon(Icons.login)
                ],
              ),
            ),
            textColor: Theme.of(context).primaryColorDark,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            onPressed: snapshot.hasData ? () => _submitFirebaseAppEP(bloc, context) : null);
      },
    );
  }

  _submitFirebaseAppEP(LoginBloc bloc, BuildContext context) async {
    dynamic result = await auth.signInWithEmailAndPassword(bloc.email, bloc.password);
    if(result == null){
      print("Error signing in");
    }else{
      print("Siggned in");
      print(result);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  _submitFirebaseApp(LoginBloc bloc, BuildContext context) async {
    dynamic result = await auth.signInAnon();
    if(result == null){
      print("Error signing in");
    }else{
      print("Siggned in");
      print(result);
    }
  }

  _submit(LoginBloc bloc, BuildContext context) async {
    Map info = await userProvider.login(bloc.email, bloc.password);

    if (info['ok']) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      print(info['message']);
    }
  }

  Widget _getRegisterButton(BuildContext context) {
    return RaisedButton(
    disabledColor: Theme.of(context).backgroundColor,
      child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Registrar'),
                  Icon(Icons.create_rounded)
                ],
              ),
            ),
            textColor: Theme.of(context).colorScheme.onPrimary,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
        onPressed: () {
        Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthorRegisterPage()) 
        );
      },
    );
  }
}