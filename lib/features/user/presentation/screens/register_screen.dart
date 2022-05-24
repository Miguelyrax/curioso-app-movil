import 'package:curioso_app/core/ui/custom_snackbar.dart';
import 'package:curioso_app/core/usecases/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/ui/custom_appbar.dart';
import '../../../../routes.dart';
import '../blocs/userbloc/user_bloc.dart';
import '../widgets/custom_field.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late FocusNode focusEmail;
  late FocusNode focusPassword;
  late FocusNode focusUsuario;
  late FocusNode focusConfirmPassword;
  final fieldKeyEmail=GlobalKey<FormFieldState>();
  final fieldKeyPassword=GlobalKey<FormFieldState>();
  final fieldKeyUsuario=GlobalKey<FormFieldState>();
  final fieldKeyConfirmPassword=GlobalKey<FormFieldState>();
  final TextEditingController ctrlEmail = TextEditingController();
  final TextEditingController ctrlPassword = TextEditingController();
  final TextEditingController ctrlUsuario = TextEditingController();
  final TextEditingController ctrlConfirmPassword = TextEditingController();
  final GlobalKey<FormState> _key= GlobalKey<FormState>();
  final List<bool> _validatorControl = [false, false, false, false];
  @override
  void initState() {
    focusEmail=FocusNode()..addListener(_listereEmail);
    focusPassword=FocusNode()..addListener(_listerePassword);
    focusUsuario=FocusNode()..addListener(_listereUsuario);
    focusConfirmPassword=FocusNode()..addListener(_listereConfirmPassword);
    super.initState();
  }

  void _listereEmail() { 
    if (!focusEmail.hasFocus) {
        if(fieldKeyEmail.currentState != null) {
          fieldKeyEmail.currentState!.validate();
        }
    }
  }
  void _listerePassword() {
    if (!focusPassword.hasFocus) {
        if(fieldKeyPassword.currentState != null) {
          fieldKeyPassword.currentState!.validate();
        }
    }
   }
  void _listereUsuario() {
    if (!focusUsuario.hasFocus) {
        if(fieldKeyUsuario.currentState != null) {
          fieldKeyUsuario.currentState!.validate();
        }
    }
   }
  void _listereConfirmPassword() { 
    if (!focusConfirmPassword.hasFocus) {
        if(fieldKeyConfirmPassword.currentState != null) {
          fieldKeyConfirmPassword.currentState!.validate();
        }
    }
  }
  bool isValid=false;

  @override
  void dispose() {
    focusEmail.removeListener(_listereEmail);
    focusPassword.removeListener(_listerePassword);
    focusUsuario.removeListener(_listereUsuario);
    focusConfirmPassword.removeListener(_listereConfirmPassword);
    focusEmail.dispose();
    focusPassword.dispose();
    focusUsuario.dispose();
    focusConfirmPassword.dispose();
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    ctrlUsuario.dispose();
    ctrlConfirmPassword.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     final blocProvider=BlocProvider.of<UserBloc>(context,listen: false);
    return BlocListener<UserBloc, UserState>(
      listener: (context,state) {
        if(state is UserLoading){
          isValid=false;
          setState(() {
            
          });
        }
        if(state is UserError){
          customSnackBar(context,texto: state.message);
          isValid=true;
          setState(() {
            
          });
        }
        if(state is UserHasData){
          Navigator.pop(context);
        }
      },
        child: Scaffold(
          backgroundColor: CuriosityColors.dark,
          appBar: customAppbar(context),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _key,
                onChanged: () async{
                  await Future.delayed(const Duration(milliseconds: 100));
                  isValid=_validatorControl.every((e) => e==true);
                   setState(() => {
                });},
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Register',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomInput(
                    fieldKey: fieldKeyUsuario,
                    focusNode: focusUsuario,
                    controller: ctrlUsuario,
                    label: 'Usuario',
                    placeholderText: 'Usuario',
                    validator: (value){
                      if(value?.isEmpty??true){
                         _validatorControl[0]=false;
                        return 'Ingrese usuario';
                      }else {
                         _validatorControl[0]=true;
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomInput(
                    fieldKey: fieldKeyEmail,
                    focusNode: focusEmail,
                    controller: ctrlEmail,
                    label: 'Email',
                    placeholderText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator:(value){
                      final result=Validator().emailValidator(value);
                      if(result==null){
                         _validatorControl[1]=true;
                        return result;
                      }else{
                         _validatorControl[1]=false;
                         return result;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomInput(
                    fieldKey: fieldKeyPassword,
                    focusNode: focusPassword,
                    controller: ctrlPassword,
                    label: 'Password',
                    placeholderText: 'Password',
                    validator: (value){
                      if(value?.isEmpty??true){
                         _validatorControl[2]=false;
                        return 'Ingrese password';
                      }else{
                         _validatorControl[2]=true;
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomInput(
                    fieldKey: fieldKeyConfirmPassword,
                    focusNode: focusConfirmPassword,
                    controller: ctrlConfirmPassword,
                    label: 'ConfirmPassword',
                    placeholderText: 'ConfirmPassword',
                    validator: (value){
                      if(value?.isEmpty??true){
                         _validatorControl[3]=false;
                        return 'Ingrese password';
                      }else if(value!=ctrlPassword.text){
                        _validatorControl[3]=false;
                        return 'El password no coincide';
                      }
                      else{
                         _validatorControl[3]=true;
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                   
                  const SizedBox(
                    height: 32,
                  ),
          
                  SizedBox(
                        width: double.infinity,
                        height: 63,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                              if (states.contains(MaterialState.disabled)) {
                                return CuriosityColors.graychetau; // Disabled color
                              }
                              return CuriosityColors.orangered; // Regular color
                              }
                            )
                          ),
                          onPressed:!isValid?null: (){
                            if(validateForm()){
                              blocProvider.add(OnUserRegister(email: ctrlEmail.text, password: ctrlPassword.text, name: ctrlUsuario.text));
                            }
                        }, child: const Text('Crear cuenta')),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                      AppNavigator.push(Routes.auth);
                    },
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        '¿Ya tienes una cuenta?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                          .textTheme.headline6!
                          .copyWith(
                            color:CuriosityColors.aquagreen
                          )
                      )
                    ),
                  ),
                ],
                  ),
              ),
            ),
          ),
   )
      
    );
  }



  bool validateForm(){
    return _key.currentState?.validate()??false;
  }
}