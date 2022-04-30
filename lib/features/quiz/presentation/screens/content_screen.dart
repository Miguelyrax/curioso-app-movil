import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/answer.dart';
import '../bloc/quiz_bloc.dart';
import '../widgets/custom_radio_widget.dart';

class ContentScreen extends StatefulWidget {
  const ContentScreen({
    Key? key, required this.state,
  }) : super(key: key);
  final QuizHasData state;

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late PageController _controller;
  @override
  void initState() {
    _controller=PageController(initialPage: 0);
    super.initState();
    
  }
  int indice =0;
  @override
  Widget build(BuildContext context) {
    final state=widget.state.result;
    final questions=widget.state.result.questions;
    final blocProvider=BlocProvider.of<QuizBloc>(context,listen: false);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Quiz',style: TextStyle(fontSize: 20,color:Color(0xff50555C), fontWeight: FontWeight.bold ),),
            Text(state.name,style: const TextStyle(fontSize: 34,color:Colors.white, fontWeight: FontWeight.bold ),),
            Text('Pregunta 0${indice+1}/0${questions.length}',style: TextStyle(fontSize: 28,color:Colors.white.withOpacity(0.6), fontWeight: FontWeight.bold ),),
            const SizedBox(height: 16,),
            Row(
              children: List.generate(questions.length, (index) => Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 2,
                  color:indice>=index?const Color(0xff1CBD88): Colors.white.withOpacity(0.6),
                ),
              )),
            ),
            const SizedBox(height: 4,),
            SizedBox(
              width:double.infinity,
              child: Text('0${indice+1}/0${questions.length}',textAlign: TextAlign.end,style: TextStyle(color: Color(0xff1CBD88)),),
            ),
            const SizedBox(height: 16,),
            Flexible(
              flex: 1,
              child: PageView.builder(
                itemCount: state.questions.length,
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_,index){
                  return Column(
                    children: [
                      Text(state.questions[index].title.split(':')[1].trim(),style: const TextStyle(fontSize: 16,color:Color(0xffFAFCFC), fontWeight: FontWeight.bold ),),
                      const SizedBox(height: 16,),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_,i){
                          return const SizedBox(height: 8,);
                        },
                        itemCount: state.questions[index].answer.length,
                        shrinkWrap: true,
                        itemBuilder: (_,i) {
                          return CustomRadio<Answer?>(
                            title:state.questions[index].answer[i].description,
                            groupValue: widget.state.answer,
                            onChanged: (Answer? value) { 
                              final map={
                                "${state.questions[index].id}":state.questions[index].answer[i].id
                              };
                              blocProvider.add(OnAnswerSelected(answer:state.questions[index].answer[i],data: map));
                            },
                            value: state.questions[index].answer[i],
                          );
                        }
                      ),
                    ],
                  );
                }),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding:MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)) ,
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                  backgroundColor: MaterialStateProperty.all(const Color(0xff1CBD88))
                ),
                onPressed:widget.state.answer==null?null: ()async{
                  if(indice==state.questions.length-1){
                     blocProvider.add(OnQuizSubmite(data: blocProvider.state.props[2] as Map<String,dynamic>));
                    return;
                  }
                  blocProvider.add(OnNextAnswer());
                  indice++;
                  setState(() {
                  });
                  _controller.animateToPage(indice,duration:const Duration(milliseconds: 500),curve: Curves.ease);
                },
                 child: const Text('Continuar')
              ),
            )
          ],
        ),
      ),
    );
  }
}