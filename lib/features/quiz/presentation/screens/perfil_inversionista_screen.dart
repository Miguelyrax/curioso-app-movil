import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../bloc/quiz_bloc.dart';
class PerfilInversionista extends StatelessWidget {
  const PerfilInversionista({
    Key? key, required this.state,
  }) : super(key: key);
  final QuizSubmited state;

  @override
  Widget build(BuildContext context) {
    final blocProvider=BlocProvider.of<QuizBloc>(context,listen: false);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text('Tu perfil de inversionista es',
              style: Theme.of(context).textTheme.headline3!
                        .copyWith(
                          color:CuriosityColors.riverBed,
                          fontWeight: FontWeight.bold
                        ),
              ),
              Text(state.riesgo.name,style:Theme.of(context).textTheme.headline1!
                    .copyWith(
                      color:CuriosityColors.orangered,
                      fontWeight: FontWeight.bold
                    ),
              ),
              const SizedBox(height: 16,),
              Text('¿Qué significa?',style: Theme.of(context).textTheme.headline3!
                    .copyWith(
                      fontWeight: FontWeight.bold
                    ),
              ),
              const SizedBox(height: 16,),
              Text(state.riesgo.description,style: const TextStyle(fontSize: 16,color:Color(0xffE0E0E0), fontWeight: FontWeight.bold ),),
              const SizedBox(height: 16,),
              Text('El nivel de riesgo, medido como la variación en el patrimonio que está dispuesto a tolerar un inversionista de este perfil, no es muy elevado, por lo que la exposición a acciones en este portafolio será cercana al 20%.',style: Theme.of(context).textTheme.headline4!
                    .copyWith(
                      color:CuriosityColors.riverBed,
                    ),
              ),
              const Spacer(),
              SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding:MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)) ,
                ),
                onPressed:()async{
                  blocProvider.add(OnQuizLoaded());
                },
                 child: const Text('Volver a realizar el test')
              ),
            )
          ],
        ),
      )
    );
  }
}
