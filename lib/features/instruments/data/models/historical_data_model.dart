
import 'package:curioso_app/features/instruments/domain/entities/historical_data.dart';

class HistorialDataModel extends HistorialData{
    const HistorialDataModel({
        required List<double> c,
        required List<double> h,
        required List<double> l,
        required List<double> o,
        required String  s,
        required List<int> t,
        required List<int> v,
    }) : super(
        c:c,
        h:h,
        l:l,
        o:o,
        s:s,
        t:t,
        v:v,
    );

    factory HistorialDataModel.fromJson(Map<String, dynamic> json) => HistorialDataModel(
        c: List<double>.from(json["c"].map((x) => x.toDouble())),
        h: List<double>.from(json["h"].map((x) => x.toDouble())),
        l: List<double>.from(json["l"].map((x) => x.toDouble())),
        o: List<double>.from(json["o"].map((x) => x.toDouble())),
        s: json["s"],
        t: List<int>.from(json["t"].map((x) => x)),
        v: List<int>.from(json["v"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "c": List<dynamic>.from(c.map((x) => x)),
        "h": List<dynamic>.from(h.map((x) => x)),
        "l": List<dynamic>.from(l.map((x) => x)),
        "o": List<dynamic>.from(o.map((x) => x)),
        "s": s,
        "t": List<dynamic>.from(t.map((x) => x)),
        "v": List<dynamic>.from(v.map((x) => x)),
    };
}
