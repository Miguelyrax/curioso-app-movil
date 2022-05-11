import 'package:curioso_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);


  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController ctrlEmail = TextEditingController();
  final TextEditingController ctrlPassword = TextEditingController();
  final GlobalKey<FormState> _key= GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final blocProvider=BlocProvider.of<UserBloc>(context,listen: false);
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
                    'Login',
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
                 SizedBox(
                  width: double.infinity,
                  child: Text(
                    '¿Olvidaste tu contraseña?',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                      .textTheme.headline6!
                      .copyWith(
                        color:CuriosityColors.orangered
                      )
                  )
                ),
                const SizedBox(
                  height: 32,
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 63,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed:state is UserLoading?null: () {
                            if(validateForm()){
                            blocProvider.add(OnUserLoaded(
                                email: ctrlEmail.text, password: ctrlPassword.text));
                            }
                          },
                          child:Text(state is UserLoading?'Cargando...':'Iniciar sesión')),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                      width: double.infinity,
                      height: 63,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CuriosityColors.orangered)
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                    AppNavigator.push(Routes.register);
                      }, child: const Text('Hazte una cuenta')),
              )
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