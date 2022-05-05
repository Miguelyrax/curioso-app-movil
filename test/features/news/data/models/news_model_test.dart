import 'package:curioso_app/features/news/data/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late NewsModel newsModel;

  setUp(() {
    newsModel = const NewsModel(
      category:'category',
      datetime:123,
      headline:'headline',
      id:1,
      image:'image',
      related:'related',
      source:'source',
      summary:'summary',
      url:'url',
    );
  });
test(
  "should be a subclass of News",
  () async {
    expect(newsModel, isA<NewsModel>());
  },
);
}
