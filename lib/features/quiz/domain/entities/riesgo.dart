import 'package:equatable/equatable.dart';

class Riesgo extends Equatable{
    const Riesgo({
        required this.id,
        required this.name,
        required this.description,
        required this.icon,
    });

    final String id;
    final String name;
    final String description;
    final dynamic icon;
    
    @override
    List<Object?> get props => [
        id,
        name,
        description,
        icon,
    ];
}


