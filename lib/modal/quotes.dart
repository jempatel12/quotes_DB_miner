class Quotes {
  final String content;
  final String author;
  final String tags;
  bool favoriteCheck;

  Quotes({
    required this.content,
    required this.author,
    required this.tags,
    required this.favoriteCheck,
  });

  factory Quotes.fromMap({required Map data}) {
    return Quotes(
      content: data["content"],
      author: data["author"],
      tags: data["tags"][0],
      favoriteCheck: false,
    );
  }
}