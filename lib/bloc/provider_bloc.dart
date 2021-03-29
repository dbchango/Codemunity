import 'package:code_munnity/bloc/login_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginProvider extends InheritedWidget{
  static LoginProvider _instance;
  factory LoginProvider({Key key, Widget child}){
    if(_instance==null){
      _instance = new LoginProvider(key: key, child: child);
    }
    return _instance;
  }

  LoginProvider._internal({Key key, Widget child}) : super(key: key, child: child);

  final loginBloc = LoginBloc();
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context){
    return (context.dependOnInheritedWidgetOfExactType<LoginProvider>()).loginBloc;
  }
}