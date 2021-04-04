import 'dart:async';

class Validators {
  final emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = new RegExp(pattern);
      if (regExp.hasMatch(data)) {
        sink.add(data);
      } else {
        sink.addError('El correo electrónico no es válido.');
      }
    },
  );

  final passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 5) {
        sink.add(data);
      } else {
        sink.addError('La contraseña debe tener al menos 5 caracteres.');
      }
    },
  );

  final nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 1) {
        sink.add(data);
      } else {
        sink.addError('No ha ingresado su nombre.');
      }
    },
  );

  final surnameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 1) {
        sink.add(data);
      } else {
        sink.addError('No ha ingresado su apellido.');
      }
    },
  );

  final knowledgeAreaValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 1) {
        sink.add(data);
      } else {
        sink.addError('No ha ingresado su área de conocimiento.');
      }
    },
  );

  final aboutValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (data, sink) {
      if (data.length >= 10) {
        sink.add(data);
      } else {
        sink.addError('Su descripción debe contener al menos 10 caracteres.');
      }
    },
  );

}
