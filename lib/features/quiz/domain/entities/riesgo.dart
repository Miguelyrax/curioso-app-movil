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

    factory Riesgo.fromJson(Map<String, dynamic> json) => Riesgo(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon": icon,
    };
    @override
    List<Object?> get props => [
        id,
        name,
        description,
        icon,
    ];
}


