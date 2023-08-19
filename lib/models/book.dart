import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

import 'package:book/models/location.dart';
import 'package:book/utils/formats.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String bookDescription;
  final String languageCode;
  final List<String> genres;
  final List<String> images;
  final List<String> likedUids;
  final MyLocation location;
  final dynamic position;
  final String ownerUid;
  final String bookInfo;
  final Timestamp createdAt;
  final bool? rating;
  final int? popularity;
  final String? goodReadsLink;
  final bool isSell;
  final double? sellPrice;
  final bool isRent;
  final double? rentPrice;
  final int? rentDuration;
  final Timestamp? rentStartDate;
  final Timestamp? rentEndDate;
  final bool isSwap;

  bool get isRentDuration => rentDuration != null;

  double? get rentRate => isRent
      ? isRentDuration
          ? (rentPrice! / rentDuration!)
          : (rentPrice! /
              ((rentEndDate!.toDate().millisecondsSinceEpoch -
                      rentStartDate!.toDate().millisecondsSinceEpoch) /
                  86400000))
      : null;

  String get rentTime => Formats.rentTime(
        isRentDuration: isRentDuration,
        rentStartDate: rentStartDate,
        rentEndDate: rentEndDate,
        rentDuration: rentDuration,
      );
  String get rentTimeShort => Formats.rentTimeShort(
        isRentDuration: isRentDuration,
        rentStartDate: rentStartDate,
        rentEndDate: rentEndDate,
        rentDuration: rentDuration,
      );

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.bookDescription,
    required this.languageCode,
    required this.genres,
    required this.images,
    required this.likedUids,
    required this.location,
    required this.position,
    required this.ownerUid,
    required this.bookInfo,
    required this.createdAt,
    this.rating,
    this.popularity,
    this.goodReadsLink,
    required this.isSell,
    required this.sellPrice,
    required this.isRent,
    required this.rentPrice,
    this.rentDuration,
    this.rentStartDate,
    this.rentEndDate,
    required this.isSwap,
  });

  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? bookDescription,
    String? languageCode,
    List<String>? genres,
    List<String>? images,
    List<String>? likedUids,
    MyLocation? location,
    dynamic position,
    String? ownerUid,
    String? bookInfo,
    Timestamp? createdAt,
    bool? rating,
    int? popularity,
    String? goodReadsLink,
    bool? isSell,
    double? sellPrice,
    bool? isRent,
    double? rentPrice,
    int? rentDuration,
    Timestamp? rentStartDate,
    Timestamp? rentEndDate,
    bool? isSwap,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      bookDescription: bookDescription ?? this.bookDescription,
      languageCode: languageCode ?? this.languageCode,
      genres: genres ?? this.genres,
      images: images ?? this.images,
      likedUids: likedUids ?? this.likedUids,
      location: location ?? this.location,
      position: position ?? this.position,
      ownerUid: ownerUid ?? this.ownerUid,
      bookInfo: bookInfo ?? this.bookInfo,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
      popularity: popularity ?? this.popularity,
      goodReadsLink: goodReadsLink ?? this.goodReadsLink,
      isSell: isSell ?? this.isSell,
      sellPrice: sellPrice ?? this.sellPrice,
      isRent: isRent ?? this.isRent,
      rentPrice: rentPrice ?? this.rentPrice,
      rentDuration: rentDuration ?? this.rentDuration,
      rentStartDate: rentStartDate ?? this.rentStartDate,
      rentEndDate: rentEndDate ?? this.rentEndDate,
      isSwap: isSwap ?? this.isSwap,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'author': author,
      'bookDescription': bookDescription,
      'languageCode': languageCode,
      'genres': genres,
      'images': images,
      'likedUids': likedUids,
      'location': location.toMap(),
      'position': position,
      'ownerUid': ownerUid,
      'bookInfo': bookInfo,
      'createdAt': createdAt,
      'rating': rating,
      'popularity': popularity,
      'goodReadsLink': goodReadsLink,
      'isSell': isSell,
      'sellPrice': sellPrice,
      'isRent': isRent,
      'rentPrice': rentPrice,
      'rentDuration': rentDuration,
      'rentStartDate': rentStartDate,
      'rentEndDate': rentEndDate,
      'isSwap': isSwap,
    };
  }

  factory Book.fromMap(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;

    return Book(
      id: map['id'] as String,
      title: map['title'] as String,
      author: map['author'] as String,
      bookDescription: map['bookDescription'] as String,
      languageCode: map['languageCode'] as String,
      genres: List<String>.from((map['genres'] as List<String>)),
      images: List<String>.from((map['images'] as List<String>)),
      likedUids: List<String>.from((map['likedUids'] as List<String>)),
      location: MyLocation.fromMap(map['location'] as Map<String, dynamic>),
      position: map['position'] as dynamic,
      ownerUid: map['ownerUid'] as String,
      bookInfo: map['bookInfo'] as String,
      createdAt: map['createdAt'] as Timestamp,
      rating: map['rating'] != null ? map['rating'] as bool : null,
      popularity: map['popularity'] != null ? map['popularity'] as int : null,
      goodReadsLink:
          map['goodReadsLink'] != null ? map['goodReadsLink'] as String : null,
      isSell: map['isSell'] as bool,
      sellPrice: map['sellPrice'] != null ? map['sellPrice'] as double : null,
      isRent: map['isRent'] as bool,
      rentPrice: map['rentPrice'] != null ? map['rentPrice'] as double : null,
      rentDuration:
          map['rentDuration'] != null ? map['rentDuration'] as int : null,
      rentStartDate: map['rentStartDate'] != null
          ? map['rentStartDate'] as Timestamp
          : null,
      rentEndDate:
          map['rentEndDate'] != null ? map['rentEndDate'] as Timestamp : null,
      isSwap: map['isSwap'] as bool,
    );
  }

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, bookDescription: $bookDescription, languageCode: $languageCode, genres: $genres, images: $images, likedUids: $likedUids, location: $location, position: $position, ownerUid: $ownerUid, bookInfo: $bookInfo, createdAt: $createdAt, rating: $rating, popularity: $popularity, goodReadsLink: $goodReadsLink, isSell: $isSell, sellPrice: $sellPrice, isRent: $isRent, rentPrice: $rentPrice, rentDuration: $rentDuration, rentStartDate: $rentStartDate, rentEndDate: $rentEndDate, isSwap: $isSwap)';
  }

  @override
  bool operator ==(covariant Book other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.title == title &&
        other.author == author &&
        other.bookDescription == bookDescription &&
        other.languageCode == languageCode &&
        listEquals(other.genres, genres) &&
        listEquals(other.images, images) &&
        listEquals(other.likedUids, likedUids) &&
        other.location == location &&
        other.position == position &&
        other.ownerUid == ownerUid &&
        other.bookInfo == bookInfo &&
        other.createdAt == createdAt &&
        other.rating == rating &&
        other.popularity == popularity &&
        other.goodReadsLink == goodReadsLink &&
        other.isSell == isSell &&
        other.sellPrice == sellPrice &&
        other.isRent == isRent &&
        other.rentPrice == rentPrice &&
        other.rentDuration == rentDuration &&
        other.rentStartDate == rentStartDate &&
        other.rentEndDate == rentEndDate &&
        other.isSwap == isSwap;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        author.hashCode ^
        bookDescription.hashCode ^
        languageCode.hashCode ^
        genres.hashCode ^
        images.hashCode ^
        likedUids.hashCode ^
        location.hashCode ^
        position.hashCode ^
        ownerUid.hashCode ^
        bookInfo.hashCode ^
        createdAt.hashCode ^
        rating.hashCode ^
        popularity.hashCode ^
        goodReadsLink.hashCode ^
        isSell.hashCode ^
        sellPrice.hashCode ^
        isRent.hashCode ^
        rentPrice.hashCode ^
        rentDuration.hashCode ^
        rentStartDate.hashCode ^
        rentEndDate.hashCode ^
        isSwap.hashCode;
  }
}
