import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
    required this.ctrlEmail,
    required this.ctrlPassword,
    required this.blocProvider,
  }) : super(key: key);

  final TextEditingController ctrlEmail;
  final TextEditingController ctrlPassword;
  final UserBloc blocProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
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
          controller: ctrlPassword,
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return ElevatedButton(
                onPressed:state is UserLoading?null: () {
                  blocProvider.add(OnUserLoaded(
                      email: ctrlEmail.text, password: ctrlPassword.text));
                },
                child:Text(state is UserLoading?'Cargando...':'Iniciar sesión'));
          },
        )
      ],
    );
  }
}
