
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../instruments/presentation/views/favourites_view.dart';
import '../blocs/userbloc/user_bloc.dart';
import '../views/login_view.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController ctrlEmail = TextEditingController();
  final TextEditingController ctrlPassword = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if(state is UserHasData){
          return const FavouriteView();
        }else{
          return const LoginView();
        }
      },
    );
  }
}

