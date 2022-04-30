
import 'package:equatable/equatable.dart';

import 'answer.dart';

class Question extends Equatable{
    const Question({
        required this.id,
        required this.title,
        required this.answer,
    });

    final String id;
    final String title;
    final List<Answer> answer;

  @override
  List<Object?> get props => [
        id,
        title,
        answer,
  ];
}
