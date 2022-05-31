
import 'package:curioso_app/core/ui/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/extension/unfocus_widget.dart';
import '../../../../core/themes/colors.dart';
import '../../../../core/ui/custom_appbar.dart';
import '../blocs/recoverybloc/recovery_bloc.dart';
import '../views/change_password_view.dart';
import '../views/code_view.dart';
import '../views/success_view.dart';

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
    _ctrlEmail.text='';
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: UnfocusWidget(
        child: Scaffold(
          backgroundColor: CuriosityColors.dark,
          appBar: customAppbar(context),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<RecoveryBloc, RecoveryState>(
              listener: (_,RecoveryState state){
                if(state is RecoveryError){
                  customSnackBar(context,texto: 'Código incorrecto');
                }
              },
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
      ),
    );
  }
}
