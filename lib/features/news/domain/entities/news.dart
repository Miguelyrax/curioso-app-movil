
import 'package:equatable/equatable.dart';

class News extends Equatable {
    const News({
        required this.category,
        required this.datetime,
        required this.headline,
        required this.id,
        required this.image,
        required this.related,
        required this.source,
        required this.summary,
        required this.url,
    });

    final String category;
    final int datetime;
    final String headline;
    final int id;
    final String image;
    final String related;
    final String source;
    final String summary;
    final String url;

  @override
  List<Object?> get props => [
      category,
      datetime,
      headline,
      id,
      image,
      related,
      source,
      summary,
      url,
  ];

}



