import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';
import '../../domain/entities/user.dart';
import '../widgets/row_perfil.dart';


class PerfilScreen extends StatelessWidget {
  const PerfilScreen({
    Key? key, required this.data,
  }) : super(key: key);

  final User data;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
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
        const SizedBox(height: 8,),
        Text('Aquí podras encontrar los datos relacionados a tu perfil.',
              style:Theme.of(context)
              .textTheme
              .headline6!.copyWith(color: CuriosityColors.gray)
        ),
        const SizedBox(height: 16,),
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
        const SizedBox(height: 32,),
        SizedBox(
                width: double.infinity,
                height: 63,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(CuriosityColors.orangered)
                  ),
                  onPressed: (){
              AppNavigator.push(Routes.register);
                }, child: const Text('Cambiar perfil')),
        ),
        const SizedBox(height: 100,),
      ],
    );
  }
}

