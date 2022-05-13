
import 'package:curioso_app/features/quiz/domain/entities/riesgo.dart';

class RiesgoModel extends Riesgo {
    const RiesgoModel({
        required String id,
        required String name,
        required String description,
        required dynamic icon,
    }) : super(
         id:id,
         name:name,
         description:description,
         icon:icon,
    );


    factory RiesgoModel.fromJson(Map<String, dynamic> json) => RiesgoModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        icon: json["icon"],
    );

    @override
    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "icon": icon,
    };
    
    
}


