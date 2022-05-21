import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';


class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    print('aqca');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
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
        const SizedBox(height: 70,),
        Text('Binvenido a una nueva forma de aprender',
              style:Theme.of(context)
              .textTheme
              .headline2!
        ),
        const SizedBox(height: 32,),
        Text('Ingresa y conoce mucho mas',
              style:Theme.of(context)
              .textTheme
              .headline3!.copyWith(
                color: CuriosityColors.gray
              )
        ),
        const SizedBox(height: 32,),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: 63,
                child: ElevatedButton(onPressed: (){
                 AppNavigator.push(Routes.auth);
                }, child: const Text('Iniciar sesión')),
              ),
            ),
            const SizedBox(width: 16,),
            SizedBox(
              height: 63,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CuriosityColors.aquagreen)
                ),
                onPressed: (){
            
                },
                child: const Text('?'),
              ),
            )
          ],
        ),
        const SizedBox(height: 16,),
        SizedBox(
                width: double.infinity,
                height: 63,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(CuriosityColors.orangered)
                  ),
                  onPressed: (){
              AppNavigator.push(Routes.register);
                }, child: const Text('Hazte una cuenta')),
        ),
        const SizedBox(height: 100,),
      ],
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
