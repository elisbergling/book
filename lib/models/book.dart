class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final double price;
  final String location;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.price,
    required this.location,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'price': price,
      'location': location,
    };
  }
}
