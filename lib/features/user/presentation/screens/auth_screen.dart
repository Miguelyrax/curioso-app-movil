
import 'package:curioso_app/features/user/presentation/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/unfocus_widget.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/ui/custom_appbar.dart';
import '../../../../core/usecases/validator.dart';
import '../../../../routes.dart';
import '../blocs/userbloc/user_bloc.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);


  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late FocusNode focusEmail;
  late FocusNode focusPassword;
  final List<bool> _validatorControl = [false, false];
  final GlobalKey<FormFieldState> fieldKeyEmail= GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> fieldKeyPassword= GlobalKey<FormFieldState>();
  final TextEditingController ctrlEmail = TextEditingController();
  final TextEditingController ctrlPassword = TextEditingController();
  final GlobalKey<FormState> _key= GlobalKey<FormState>();
  @override
  void initState() {
    focusEmail=FocusNode()..addListener(_listenerEmail);
    focusPassword=FocusNode()..addListener(_listenerPassword);
    super.initState();
    
  }

  @override
  void dispose() {
    focusEmail.removeListener(_listenerEmail);
    focusPassword.removeListener(_listenerPassword);
    focusEmail.dispose();
    focusPassword.dispose();
    super.dispose();
  }

  void _listenerPassword() {
    if(!focusEmail.hasFocus){
      fieldKeyEmail.currentState?.validate();
    }
   }

  void _listenerEmail() {
    if(!focusPassword.hasFocus){
      fieldKeyPassword.currentState?.validate();
    }
   }
   bool isEnable = false;
  @override
  Widget build(BuildContext context) {
    final blocProvider=BlocProvider.of<UserBloc>(context,listen: false);
    return BlocListener<UserBloc, UserState>(
      listener: (context,state) {
        if(state is UserHasData){
          Navigator.pop(context);
          isEnable=false;
          setState(() {
            
          });
        }
        if(state is UserError){
          isEnable=true;
          setState(() {
            
          });
        }
      },
        child: UnfocusWidget(
          child: Scaffold(
            backgroundColor: CuriosityColors.dark,
            appBar: customAppbar(context),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _key,
                  onChanged: ()async{
                    await Future.delayed(const Duration(milliseconds:100));
                    isEnable = _validatorControl.every((e) => e==true);
                    setState(() {
                      
                    });
                  },
                  child: SizedBox(
              height: MediaQuery.of(context).size.height-150,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Iniciar sesión',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(fontWeight: FontWeight.bold,color: CuriosityColors.beige),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
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
                             _validatorControl[0]=true;
                            return result;
                          }else{
                             _validatorControl[0]=false;
                             return result;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomInput(
                        label: 'Password',
                        fieldKey: fieldKeyPassword,
                        focusNode: focusPassword,
                        obscureText: true,
                        controller: ctrlPassword,
                        placeholderText: '*******',
                        validator: (value){
                          if(value?.isEmpty??true){
                            _validatorControl[1]=false;
                            return 'Ingrese password';
                          }else{
                            _validatorControl[1]=true;
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        height: 63,
                        width: double.infinity,
                        child: 
                        ElevatedButton(
                            onPressed:!isEnable?null: () {
                              if(validateForm()){
                                  blocProvider.add(
                                    OnUserLoaded(
                                      email: ctrlEmail.text, password: ctrlPassword.text
                                    )
                                  );
                                }
                              },
                            child:const Text('Iniciar sesión')
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                       SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: (){
                            AppNavigator.push(Routes.recovery);
                          },
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                              .textTheme.headline6!
                              .copyWith(
                                color:CuriosityColors.orangered
                              )
                          ),
                        )
                      ),
                      const Spacer(),
                      SizedBox(
                            width: double.infinity,
                            child: TextButton(style: ButtonStyle(
                              overlayColor:MaterialStateProperty.all(Colors.transparent) 
                            ),
                              onPressed: (){
                                Navigator.pop(context);
                                AppNavigator.push(Routes.register);
                              },
                              child: RichText(
                                text: TextSpan(
                                  text:'¿No tienes una cuenta?',
                                  style: Theme.of(context)
                                  .textTheme.headline6!
                                  .copyWith(
                                    color:CuriosityColors.gray
                                  ),
                                children: [
                                  TextSpan(
                                    text: ' Hazte una',
                                    style: Theme.of(context)
                                    .textTheme.headline6!
                                    .copyWith(
                                      color:CuriosityColors.beige
                                    ),
                                  )
                                ]
                               ),
                              )
                            ),
                    )
                    ],
                      ),
                  ),
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