import 'package:curioso_app/features/user/presentation/widgets/custom_field.dart';
import 'package:curioso_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/ui/custom_appbar.dart';
import '../../../../core/usecases/validator.dart';
import '../blocs/recoverybloc/recovery_bloc.dart';

class RecoveryScreen extends StatefulWidget {
  const RecoveryScreen({Key? key}) : super(key: key);

  @override
  State<RecoveryScreen> createState() => _RecoveryScreenState();
}

class _RecoveryScreenState extends State<RecoveryScreen> {
  final TextEditingController _ctrlEmail = TextEditingController();
  @override
  void initState() {
    final recoveryBloc = BlocProvider.of<RecoveryBloc>(context);
    recoveryBloc.add(OnRecoveryInitial());
    _ctrlEmail.text='miguel_albanez_96@hotmail.com';
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        backgroundColor: CuriosityColors.dark,
        appBar: customAppbar(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<RecoveryBloc, RecoveryState>(
            builder: (context, state) {
              if(state is RecoveryInitial || state is RecoveryError){
                return  ChangePasswordView(controller: _ctrlEmail,);
              }
              else if(state is RecoveryEndLoaded){
                return CodeView(controller: _ctrlEmail);
              }
              else if(state is RecoveryLoaded){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }else if(state is RecoverySendSuccess){
                return const SuccessView();
              }else{
                return const SizedBox();
              }
              
            },
          ),
        ),
      ),
    );
  }
}

class SuccessView extends StatelessWidget {
  const SuccessView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enviamos una contraseña temporal a tu cuenta de email',
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(
                fontWeight: FontWeight.bold,
                color: CuriosityColors.beige
              ),
        ),
        const SizedBox(height: 16,),
        Text(
          'Debes ingresar esta al momento de loguearte y cambiar tu contraseña desde el menú de configuraciones del usuario',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(
                color: CuriosityColors.gray
              ),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 63,
          child: ElevatedButton(
            onPressed: (){
              AppNavigator.pop();
            },
            child: const Text('Ir al login')
          ),
        )
      ],
    );
  }
}

class CodeView extends StatefulWidget {
  const CodeView({
    Key? key, required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  State<CodeView> createState() => _CodeViewState();
}

class _CodeViewState extends State<CodeView> {
  late FocusNode _ctrlOneFocus;
  late FocusNode _ctrlTwoFocus;
  late FocusNode _ctrlThreeFocus;
  late FocusNode _ctrlFourFocus;
  final TextEditingController _ctrlOne = TextEditingController();
  final TextEditingController _ctrlTwo = TextEditingController();
  final TextEditingController _ctrlThree = TextEditingController();
  final TextEditingController _ctrlFour = TextEditingController();
  @override
  void initState() {
    _ctrlOneFocus=FocusNode();
    _ctrlTwoFocus=FocusNode();
    _ctrlThreeFocus=FocusNode();
    _ctrlFourFocus=FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    _ctrlOneFocus.dispose();
    _ctrlTwoFocus.dispose();
    _ctrlThreeFocus.dispose();
    _ctrlFourFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final recoveryBloc = BlocProvider.of<RecoveryBloc>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingresa el código',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(
                fontWeight: FontWeight.bold,
                color: CuriosityColors.beige
              ),
        ),
        const SizedBox(height: 32,),
        Text(
          'Para recuperar la contraseña debes ingresar el código de 4 dígitos que enviamos a tu email',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(
                color: CuriosityColors.gray
              ),
        ),
        const SizedBox(height: 16,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: [
              _input(_ctrlOne,_ctrlOneFocus,_ctrlTwoFocus,_ctrlOneFocus),
              const SizedBox(width: 16,),
              _input(_ctrlTwo,_ctrlTwoFocus,_ctrlThreeFocus,_ctrlOneFocus),
              const SizedBox(width: 16,),
              _input(_ctrlThree,_ctrlThreeFocus,_ctrlFourFocus,_ctrlTwoFocus),
              const SizedBox(width: 16,),
              _input(_ctrlFour,_ctrlFourFocus,_ctrlFourFocus,_ctrlThreeFocus),
            ],
          ),
        ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 63,
            child: ElevatedButton(
              onPressed:(){
                final code =int.parse(_ctrlOne.text+_ctrlTwo.text+_ctrlThree.text+_ctrlFour.text);
                print(code);
                recoveryBloc.add(OnRecoveryEmail(email: widget.controller.text,code: code));
              },
              child:const Text('Continuar')
            ),
          )
      ],
    );;
  }

  Expanded _input(TextEditingController controller, FocusNode focus,FocusNode nextFocus,FocusNode previusFocus) {
    return Expanded(
      child: TextFormField(
        focusNode: focus,
        textInputAction: TextInputAction.next,
        maxLength: 1,
        obscureText: true,
        autofocus: true,
        textAlign: TextAlign.center,
        obscuringCharacter: '*',
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (v){
            print(v);
            if(v.isEmpty){
              print('empty');
              FocusScope.of(context).requestFocus(previusFocus);
            }else{
                FocusScope.of(context).requestFocus(nextFocus);
            }
              },
          validator:(value){
            if(value!=null|| value!.isNotEmpty){
              return null;
            }else{
                return '';
            }
          },
        ),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
   const ChangePasswordView({
    Key? key, required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final recoveryBloc = BlocProvider.of<RecoveryBloc>(context);
    return Form(
      key: _key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recuperar password',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(
                  fontWeight: FontWeight.bold,
                  color: CuriosityColors.beige
                ),
          ),
          const SizedBox(height: 32,),
          Text(
            'Para recuperar la contraseña debes enviar el mail asociado a tu cuenta de CuriosityApp',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  color: CuriosityColors.gray
                ),
          ),
          const SizedBox(height: 16,),
          CustomInput(
              controller: widget.controller,
              label: 'Ingresa tu email',
              placeholderText: 'Email',
              keyboardType: TextInputType.emailAddress,
              onChangedField: (value){
              setState(() {
                
              });
              },
              validator:(value){
                final result=Validator().emailValidator(value);
                if(result==null){
                  return result;
                }else{
                    return result;
                }
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 63,
              child: ElevatedButton(
                onPressed:validate()==false?null: (){
                  recoveryBloc.add(OnSendEmail(widget.controller.text));
                },
                child:const Text('Continuar')
              ),
            )
        ],
      ),
    );
  }

  bool validate(){
    return _key.currentState?.validate()??false;
  }
}
