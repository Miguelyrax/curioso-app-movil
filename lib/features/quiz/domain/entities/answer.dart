
import 'package:equatable/equatable.dart';

class Answer extends Equatable{
    const Answer({
        required this.id,
        required this.description,
    });

    final String id;
    final String description;

  @override
  List<Object?> get props => [
        id,
        description,

  ];

}
