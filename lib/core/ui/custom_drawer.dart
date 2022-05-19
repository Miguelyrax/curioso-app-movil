import 'package:curioso_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:curioso_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../themes/colors.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context,listen: false);
    return Container( 
      color:CuriosityColors.dark,
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Curiosity',
                  style:Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(
                    fontWeight: FontWeight.bold,
                    color: CuriosityColors.beige
                  )
                ),
            Text('App',
                  style:Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(
                    fontWeight: FontWeight.bold,
                  )
            ),
            const SizedBox(height: 64,),
            GestureDetector(
              onTap: (){
                AppNavigator.push(Routes.profile);
              },
              child: Text('Perfil',
                    style:Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(
                      fontWeight: FontWeight.bold,
                    )
              ),
            ),
            const SizedBox(height: 16,),
            Text('Configuraciones',
                  style:Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(
                    fontWeight: FontWeight.bold,
                  )
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                userBloc.add(OnUserLogout());
                Navigator.pop(context);
              },
              child: Text('Cerrar sesión',
                    style:Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: CuriosityColors.orangered
                    )
              ),
            ),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    );
  }
}