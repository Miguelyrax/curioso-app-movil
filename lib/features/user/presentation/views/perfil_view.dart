import 'package:curioso_app/core/ui/custom_appbar.dart';
import 'package:curioso_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:curioso_app/features/user/presentation/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors.dart';
import '../../../../routes.dart';
import '../../domain/entities/user.dart';
import '../widgets/row_perfil.dart';


class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> with SingleTickerProviderStateMixin {
  final TextEditingController ctrlName = TextEditingController();
  final TextEditingController ctrlCorreo = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animationPositioned;
  late User data;
  @override
  void initState() {
    _controller=AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _animation=Tween<double>(begin: 1,end: 0)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn
      )
    );
    _animationPositioned=Tween<double>(begin: 0.0,end: 1)
    .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn
      )
    );
    final userBloc = BlocProvider.of<UserBloc>(context).state as UserHasData;
    data =userBloc.user;
    ctrlName.text=data.name;
    ctrlCorreo.text=data.email;
    super.initState();
  }
  bool _edit=false;
  @override
  Widget build(BuildContext context) {
    final textStyle=Theme.of(context) .textTheme.headline3;
    return SafeArea(
      child: Scaffold(
        appBar: customAppbar(context),
        backgroundColor:CuriosityColors.dark,
        body: Form(
          key: _key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context,Widget? child) {
              return Padding(
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
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        Expanded(
                          child: Text('Perfil del inversionista', style:textStyle)
                        ),
                        Text(
                          'Balanceado',
                          style:Theme.of(context).textTheme.headline3!
                          .copyWith(
                            color: CuriosityColors.beige
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 64,),
                    RowPerfil(onPressed: (value){
                      _edit=value;
                      if(value){
                        _controller.forward();
                      }else{
                        _controller.reverse();
                      }
                      setState(() {
                        
                      });
                    },alignment: Alignment.centerRight,),
                    const SizedBox(height: 32,),

                    SizeTransition(
                      sizeFactor:_animation ,
                      axisAlignment: 1,
                      child: Text(data.name, style:textStyle)
                    ),
                    SizeTransition(
                      sizeFactor:_animationPositioned ,
                      axisAlignment: -1,
                      child: CustomInput(
                        controller: ctrlName,
                        label: 'Name',
                        validator: (value){
                          if(value!=null && value.isNotEmpty){
                            return null;
                          }else{
                            return '';
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16,),
                    SizeTransition(
                      sizeFactor:_animation ,
                      axisAlignment: 1,
                      child: Text(data.email, style:textStyle)
                    ),
                    SizeTransition(
                      sizeFactor:_animationPositioned ,
                      axisAlignment: -1,
                      child: CustomInput(
                        enabled: false,
                        controller: ctrlCorreo,
                        label: 'Email',
                        validator: (value){
                          if(value!=null && value.isNotEmpty){
                            return null;
                          }else{
                            return '';
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text('Password', style:textStyle)
                        ),
                        SizeTransition(
                      sizeFactor:_animationPositioned ,
                      axisAlignment: 1,
                          child: TextButton(
                            onPressed: (){},
                            child: Text('Cambiar password',
                            style:Theme.of(context).textTheme.headline3!
                            .copyWith(
                              color: CuriosityColors.orangered
                            ),)
                          ),
                        )
                        

                      ],
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
              );
            }
          ),
        ),
      ),
    );
  }
}

