import 'dart:async';

class Validators{
  final emailValidor = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink){
      Pattern pattern = r'';
      RegExp regExp = new RegExp(pattern);
      if(regExp.hasMatch(data)){
        sink.add(data);
      }else{
        sink.addError('El correo electronico no es valido');
      }
    }
  );
}