import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
class RowDetail extends StatelessWidget {
  const RowDetail({
    Key? key,
    required this.title,
    required this.description,
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
                  .copyWith(color: CuriosityColors.gray)
          ),
        ),
        Expanded(
          child: Text(description,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.headline6!),
        ),
      ],
    );
  }
}