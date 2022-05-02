import 'package:curioso_app/core/themes/colors.dart';
import 'package:flutter/material.dart';

import 'features/instruments/presentation/widgets/instrument_list.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: CuriosityColors.dark,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Curiosity',
                      style:Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(
                        fontWeight: FontWeight.bold,
                        color: CuriosityColors.beige
                      )
                    ),
                    Text('App',
                      style:Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    Text('1 de mayo',
                      style:Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(
                        fontWeight: FontWeight.bold,
                        color: CuriosityColors.gray
                      )
                    ),
                    const SizedBox(height: 8,),
                    SizedBox(
                      height: 30,
                      child: TextFormField(
                        decoration:const InputDecoration(
                          hintText: 'Buscar'
                        ),
                      )
                    ),
                    const SizedBox(height: 32,),
                    Text('Instrumentos',
                      style:Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
              InstrumentList()
            ],
       ),
        ),
       ),
    );
  }
}

