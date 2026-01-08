class MoviePoster {
  final String id;
  final String movieName;
  final String image;
  final DateTime createdAt;

  MoviePoster({
    required this.id,
    required this.movieName,
    required this.image,
    required this.createdAt,
  });

  factory MoviePoster.fromJson(Map<String, dynamic> json) {
    return MoviePoster(
      id: json['_id'],
      movieName: json['MovieName'],
      image: json['image'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
