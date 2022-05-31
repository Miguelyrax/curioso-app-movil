import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../widgets/instrument_list.dart';
class InstrumentosScreen extends StatefulWidget {
  const InstrumentosScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InstrumentosScreen> createState() => _InstrumentosScreenState();
}

class _InstrumentosScreenState extends State<InstrumentosScreen> with AutomaticKeepAliveClientMixin{
  late TextEditingController _controller;
  @override
  void initState() {
    _controller=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomScrollView(
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

              const SizedBox(height: 8,),
              SizedBox(
                height: 30,
                child: TextFormField(
                  onChanged: (value){
                    setState(() {
                      
                    });
                  },
                  controller: _controller,
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
        InstrumentList(
          controller: _controller,
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 100,)
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}