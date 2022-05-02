
import 'package:equatable/equatable.dart';

class HistorialData  extends Equatable{
    const HistorialData({
        required this.c,
        required this.h,
        required this.l,
        required this.o,
        required this.s,
        required this.t,
        required this.v,
    });

    final List<double> c;
    final List<double> h;
    final List<double> l;
    final List<double> o;
    final String s;
    final List<int> t;
    final List<int> v;

  @override
  List<Object?> get props => [
    c,
    h,
    l,
    o,
    s,
    t,
    v,
  ];
}
