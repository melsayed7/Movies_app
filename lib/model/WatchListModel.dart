class WatchListModel {
  String id;

  String image;

  String title;

  String content;

  String date;

  bool check;

  WatchListModel({
    this.id = '',
    required this.image,
    required this.title,
    required this.content,
    required this.date,
    this.check = false,
  });

  WatchListModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          image: json['image'] as String,
          title: json['title'] as String,
          content: json['content'] as String,
          date: json['date'] as String,
          check: json['check'] as bool,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'content': content,
      'date': date,
      'check': check,
    };
  }
}
