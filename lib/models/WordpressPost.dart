class WordpressPost {
  final String? title;
  final DateTime? date;
  final String? link;
  final String? content;
  final String? imageUrl;

  WordpressPost(
      {this.title, this.date, this.link, this.content, this.imageUrl});

  factory WordpressPost.fromJson(Map<String, dynamic> json) {
    return WordpressPost(
        title: json['title']['rendered'],
        date: DateTime.parse(json['date']),
        link: json['link'],
        content: json['content']['rendered'],
        imageUrl: json["_embedded"]["wp:featuredmedia"][0]["source_url"]);
  }
}
