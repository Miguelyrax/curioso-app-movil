import 'package:curioso_app/core/themes/colors.dart';
import 'package:curioso_app/features/instruments/presentation/bloc/instrument_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DetailInstrumentScreen extends StatelessWidget {
  const DetailInstrumentScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CuriosityColors.dark,
        ),
        backgroundColor: CuriosityColors.dark,
        body: BlocBuilder<InstrumentBloc, InstrumentState>(
        builder: (context, state) {
          if(state is InstrumentHasData){
            if(state.loading){
              return const CircularProgressIndicator(color: CuriosityColors.crystalblue,);
            }else{
              return  ViewDetail(state:state);
            }
          }
          if(state is InstrumentError){
            return  SizedBox(
            child: Center(
                  child: Text(state.message),
            ),
          );
          }
          return const SizedBox(
            child: Center(
                  child: Text('Hola Mundo'),
                ),
          );
          
        },
      ),
       ),
    );
  }
}

class ViewDetail extends StatelessWidget {
  const ViewDetail({
    Key? key, required this.state,
  }) : super(key: key);
  final InstrumentHasData state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity,),
          Text('Valor',
              style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(
              color: CuriosityColors.gray)
          ),
          const SizedBox(height:16,),
          Text('3,578.62',
              style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(
                fontWeight: FontWeight.bold,
              )
          ),
          const SizedBox(height:200,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) => Flexible(
              child: Text('1M',
                style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  color: CuriosityColors.gray
                )
              ),
            ),),
          ),
          const SizedBox(height:32,),
          RowDetail(title: 'Pais',description: state.detail?.country??'',),
          const SizedBox(height:16,),
          RowDetail(title: 'Currency',description: state.detail?.currency??'',),
          const SizedBox(height:16,),
          RowDetail(title: 'Nombre',description: state.detail?.name??'',),
          const SizedBox(height:16,),
          RowDetail(title: 'Exchange',description: state.detail?.exchange??'',),
          const SizedBox(height:16,),
          const RowDetail(title: 'Logo',description: 'US',),
          const SizedBox(height:16,),
        ],
      ),
    );
  }
}

class RowDetail extends StatelessWidget {
  const RowDetail({
    Key? key,required  this.title,required  this.description,
  }) : super(key: key);
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title,
              style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(
                color: CuriosityColors.gray
              )
            ),
        ),
        Expanded(
          child: Text(description,
          textAlign: TextAlign.end,
              style: Theme.of(context)
              .textTheme
              .headline6!
            ),
        ),
      ],
    );
  }
}