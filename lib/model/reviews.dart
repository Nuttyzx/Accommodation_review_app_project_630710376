
class Review {
  final int id;
  final int userId;
  final String name;
  final String avatar;
  final double rating;
  final String comment;
  final String photo;
  final String date;

  Review({
    required this.id,
    required this.userId,
    required this.name,
    required this.avatar,
    required this.rating,
    required this.comment,
    required this.photo,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      avatar: json['avatar'],
      rating: json['rating'],
      comment: json['comment'],
      photo: json['photo'],
      date: json['date'],
    );
  }
}
