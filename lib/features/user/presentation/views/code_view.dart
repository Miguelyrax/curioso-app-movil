import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extension/unfocus_widget.dart';
import '../../../../core/themes/colors.dart';
import '../blocs/recoverybloc/recovery_bloc.dart';

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
    return UnfocusWidget(
      child: Column(
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
                  recoveryBloc.add(OnRecoveryEmail(email: widget.controller.text,code: code));
                },
                child:const Text('Continuar')
              ),
            )
        ],
      ),
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
            if(v.isEmpty){
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
