
import 'package:curioso_app/features/news/domain/entities/news.dart';

class NewsModel extends News {
    const NewsModel({
        required String category,
        required int datetime,
        required String headline,
        required int id,
        required String image,
        required String related,
        required String source,
        required String summary,
        required String url,
    }) : super(
      category:category,
      datetime:datetime,
      headline:headline,
      id:id,
      image:image,
      related:related,
      source:source,
      summary:summary,
      url:url,
    );


    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        category: json["category"],
        datetime: json["datetime"],
        headline: json["headline"],
        id: json["id"],
        image: json["image"],
        related: json["related"],
        source: json["source"],
        summary: json["summary"],
        url: json["url"],
    );

}



