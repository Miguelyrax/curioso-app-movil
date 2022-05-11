import 'package:curioso_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController ctrlEmail = TextEditingController();
  final TextEditingController ctrlPassword = TextEditingController();
  final TextEditingController ctrlUsuario = TextEditingController();
  final TextEditingController ctrlConfirmPassword = TextEditingController();
  final GlobalKey<FormState> _key= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context,state) {
        if(state is UserHasData){
          Navigator.pop(context);
        }
      },
        child: Scaffold(
          backgroundColor: CuriosityColors.dark,
          appBar: AppBar(
            backgroundColor: CuriosityColors.blackbeige,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _key,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                Text(
                  'Usuario',
                  style: Theme.of(context).textTheme.headline4!.copyWith(),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  controller: ctrlUsuario,
                  validator: (value){
                    if(value?.isEmpty??true){
                      return 'Ingrese Usuario';
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.headline4!.copyWith(),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  controller: ctrlEmail,
                  validator: (value){
                    if(value?.isEmpty??true){
                      return 'Ingrese email';
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.headline4!.copyWith(),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  obscureText: true,
                  controller: ctrlPassword,
                  validator: (value){
                    if(value?.isEmpty??true){
                      return 'Ingrese password';
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Confirmar Password',
                  style: Theme.of(context).textTheme.headline4!.copyWith(),
                ),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  obscureText: true,
                  controller: ctrlConfirmPassword,
                  validator: (value){
                    if(value?.isEmpty??true){
                      return 'Ingrese password';
                    }else if(value!=ctrlPassword.text){
                      return 'El password no coincide';
                    }
                    else{
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
                          backgroundColor: MaterialStateProperty.all(CuriosityColors.orangered)
                        ),
                        onPressed: (){
                          if(validateForm()){
                            

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
   )
      
    );
  }

  bool validateForm(){
    return _key.currentState?.validate()??false;
  }
}