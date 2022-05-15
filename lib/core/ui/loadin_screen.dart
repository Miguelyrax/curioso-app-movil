import 'package:curioso_app/core/themes/colors.dart';
import 'package:curioso_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../routes.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    final userBloc=BlocProvider.of<UserBloc>(context,listen: false);
    userBloc.add(OnUserRenew());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc,UserState>(
      listener: (context,state) {
        if(state is UserHasData){
          AppNavigator.replaceWith(Routes.home);
        }
        if(state is UserError){
          AppNavigator.replaceWith(Routes.home);
        }
      },
      child: 
         const SafeArea(
          child: Scaffold(
            backgroundColor: CuriosityColors.dark,
            body:  Center(
                  child: CircularProgressIndicator(color: Colors.blue,),
              ),
           ),
        )
        );
      }
}