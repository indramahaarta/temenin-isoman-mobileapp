class Article {
  late String title;
  late String source;
  late String publishedDate;
  late String imageUrl;
  late String articleUrl;
  late String briefDescription;

  Article({
    required this.title,
    required this.source,
    required this.publishedDate,
    required this.imageUrl,
    required this.articleUrl,
    required this.briefDescription,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    title: json["fields"]["title"],
    source: json["fields"]["source"],
    publishedDate: json["fields"]["published_date"],
    briefDescription: json["fields"]["brief_description"],
    imageUrl: json["fields"]["image_url"],
    articleUrl: json["fields"]["article_url"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "source": source,
    "published_date": publishedDate,
    "brief_description": briefDescription,
    "image_url": imageUrl,
    "article_url": articleUrl,
  };

}
