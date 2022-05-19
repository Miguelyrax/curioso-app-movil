import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../domain/entities/instrument.dart';
class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key, required this.instrument,
    this.dragHandle=false, this.index,
  }) : super(key: key);
  final Instrument instrument;
  final bool dragHandle;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: CuriosityColors.blackbeige
      ),
      child: Row(
        crossAxisAlignment:dragHandle?CrossAxisAlignment.center: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(instrument.name,
                    style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(
                    fontWeight: FontWeight.bold,
                    color: CuriosityColors.beige)
                ),
                Text(instrument.symbol,
                  style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: CuriosityColors.gray)
                ),
              ],
            ),
          ),
          dragHandle?ReorderableDragStartListener(index:index!,child: const IconButton(onPressed: null,icon: const Icon(Icons.menu,color: CuriosityColors.white,))):
          Expanded(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('322,83',
                  style: Theme.of(context).textTheme.headline5!
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
