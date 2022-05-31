import 'package:flutter/material.dart';
import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';
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