import 'package:curioso_app/features/user/domain/entities/user.dart';
import 'package:curioso_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';


class PerfilScreen extends StatelessWidget {
  final User data;

  const PerfilScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(data.name)
      ],
    );
  }
}