import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
             const Text('Tu perfil de inversionista es',style: TextStyle(fontSize: 20,color:Color(0xff50555C), fontWeight: FontWeight.bold ),),
              Text(state.riesgo.name,style: const TextStyle(fontSize: 34,color:const Color(0xff1CBD88), fontWeight: FontWeight.bold ),),
              const SizedBox(height: 16,),
              const Text('¿Qué significa?',style: TextStyle(fontSize: 20,color:Colors.white, fontWeight: FontWeight.bold ),),
              const SizedBox(height: 16,),
              Text(state.riesgo.description,style: TextStyle(fontSize: 16,color:Color(0xffE0E0E0), fontWeight: FontWeight.bold ),),
              const SizedBox(height: 16,),
              const Text('El nivel de riesgo, medido como la variación en el patrimonio que está dispuesto a tolerar un inversionista de este perfil, no es muy elevado, por lo que la exposición a acciones en este portafolio será cercana al 20%.',style: TextStyle(fontSize: 14,color:Color(0xff919599), fontWeight: FontWeight.bold ),),
              const Spacer(),
              SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding:MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)) ,
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                  backgroundColor: MaterialStateProperty.all(const Color(0xff1CBD88))
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
