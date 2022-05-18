import 'package:curioso_app/core/ui/custom_appbar.dart';
import 'package:curioso_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';
import '../widgets/row_perfil.dart';


class PerfilScreen extends StatelessWidget {
  const PerfilScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context).state as UserHasData;
    final data =userBloc.user;
    return SafeArea(
      child: Scaffold(
        appBar: customAppbar(context),
        backgroundColor:CuriosityColors.dark,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bienvenido',
                    style:Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: CuriosityColors.beige
                    )
                  ),
              Text(data.name,
                    style:Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(
                      fontWeight: FontWeight.bold,
                    )
              ),
              const SizedBox(height: 16,),
              Text('Aquí podras encontrar los datos relacionados a tu perfil.',
                    style:Theme.of(context)
                    .textTheme
                    .headline5!.copyWith(color: CuriosityColors.gray)
              ),
              const SizedBox(height: 64,),
              RowPerfil(
                title: data.name,
                danger: false,
                onPressed: (){},
              ),
              const SizedBox(height: 16,),
              RowPerfil(
                title: data.email,
                danger: false,
                onPressed: (){},
              ),
              const SizedBox(height: 16,),
              RowPerfil(
                title: 'Password',
                danger: true,
                onPressed: (){},
              ),
              const SizedBox(height: 16,),
              RowPerfil(
                title: 'Perfil del inversionista',
                danger: false,
                onPressed: (){},
              ),
              const Spacer(),
              const SizedBox(height: 32,),
              SizedBox(
                      width: double.infinity,
                      height: 63,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CuriosityColors.orangered)
                        ),
                        onPressed: (){
                    AppNavigator.push(Routes.survey);
                      }, child: const Text('Cambiar perfil')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

