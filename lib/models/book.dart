import 'package:flutter/material.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final String bookDescription;
  final List<String> images;
  final List<String> likedUids;
  final String location;
  final String ownerUid;
  final String bookInfo;
  final bool isSell;
  final double? sellPrice;
  final bool isRent;
  final double? leasePrice;
  final int? leaseDuration;
  final DateTimeRange? leaseTimeRange;
  final bool isSwap;

  bool get isLeaseDuration => leaseDuration != null;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.images,
    required this.location,
    required this.bookDescription,
    required this.ownerUid,
    required this.bookInfo,
    required this.isSell,
    required this.isRent,
    required this.isSwap,
    required this.likedUids,
    required this.sellPrice,
    required this.leasePrice,
    required this.leaseDuration,
    required this.leaseTimeRange,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      images: json['images'],
      location: json['location'],
      bookDescription: json['bookDescription'],
      bookInfo: json['bookInfo'],
      ownerUid: json['ownerUid'],
      isRent: json['isRent'],
      isSell: json['isSell'],
      isSwap: json['isSwap'],
      likedUids: json['likedUids'],
      leaseDuration: json['leaseDuration'],
      leasePrice: json['leasePrice'],
      leaseTimeRange: json['leaseTimeRange'],
      sellPrice: json['sellPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'images': images,
      'location': location,
      'bookDescription': bookDescription,
      'bookInfo': bookInfo,
      'ownerUid': ownerUid,
      'isRent': isRent,
      'isSell': isSell,
      'isSwap': isSwap,
      'likedUids': likedUids,
      'leaseDuration': leaseDuration,
      'leasePrice': leasePrice,
      'leaseTimeRange': leaseTimeRange,
      'sellPrice': sellPrice,
    };
  }
}
