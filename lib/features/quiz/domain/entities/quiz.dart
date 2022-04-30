
import 'package:equatable/equatable.dart';

import 'question.dart';

class Quiz extends Equatable{
    const Quiz({
        required this.id,
        required this.name,
        required this.questions,
    });

    final String id;
    final String name;
    final List<Question> questions;

  @override
  List<Object?> get props => [
        id,
        name,
        questions,
  ];
  
}


