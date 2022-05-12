

class Validator{
  
   String? emailValidator(String? value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = RegExp(pattern);

    if(value == null || value.isEmpty){
      return 'Debe ingresar un email';
    } else if (!regex.hasMatch(value)) {
      return 'Ingrese un mail valido';
    } else {
      return null;
    }
  }
}