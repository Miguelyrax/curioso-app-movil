import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/unfocus_widget.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/usecases/validator.dart';
import '../blocs/recoverybloc/recovery_bloc.dart';
import '../widgets/custom_field.dart';

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
    return UnfocusWidget(
      child: Form(
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
      ),
    );
  }

  bool validate(){
    return _key.currentState?.validate()??false;
  }
}

