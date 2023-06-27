import 'package:book/models/book.dart';
import 'package:flutter/material.dart';

final List<Book> mockBooks = [
  Book(
    id: '1',
    title: 'To Kill a Mockingbird',
    author: 'Harper Lee',
    location: 'New York',
    bookDescription:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    bookInfo:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    images: [
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
    ],
    ownerUid: '1',
    isSell: false,
    isRent: true,
    isSwap: false,
    sellPrice: null,
    leasePrice: 45,
    leaseDuration: null,
    leaseTimeRange: null,
    likedUids: [],
  ),
  Book(
    id: '2',
    title: '1984',
    author: 'George Orwell',
    location: 'Los Angeles',
    bookDescription:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    bookInfo:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem v',
    images: [
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
    ],
    ownerUid: '2',
    isSell: true,
    isRent: false,
    isSwap: false,
    sellPrice: 43,
    leasePrice: null,
    leaseDuration: null,
    leaseTimeRange: null,
    likedUids: [],
  ),
  Book(
    id: '3',
    title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    location: 'San Francisco',
    bookDescription:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    bookInfo:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem v',
    images: [
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
    ],
    ownerUid: '3',
    isSell: false,
    isRent: false,
    isSwap: true,
    sellPrice: null,
    leasePrice: null,
    leaseDuration: null,
    leaseTimeRange: null,
    likedUids: [],
  ),
  Book(
    id: '4',
    title: 'One Hundred Years of Solitude',
    author: 'Gabriel Garcia Marquez',
    location: 'Chicago',
    bookDescription:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem v',
    bookInfo:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    images: [
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
    ],
    ownerUid: '4',
    isSell: true,
    isRent: true,
    isSwap: false,
    sellPrice: 45,
    leasePrice: 23,
    leaseDuration: 4,
    leaseTimeRange: null,
    likedUids: [],
  ),
  Book(
    id: '5',
    title: 'Brave New World',
    author: 'Aldous Huxley',
    location: 'Seattle',
    bookDescription:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    bookInfo:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    images: [
      'https://images-na.ssl-images-amazon.com/images/I/51yfgMIMwDL._SX322_BO1,204,203,200_.jpg'
    ],
    ownerUid: '5',
    isSell: false,
    isRent: true,
    isSwap: true,
    sellPrice: null,
    leasePrice: 56,
    leaseDuration: 34,
    leaseTimeRange: null,
    likedUids: [],
  ),
  Book(
    id: '6',
    title: 'Pride and Prejudice',
    author: 'Jane Austen',
    location: 'Boston',
    bookDescription:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem vvvv',
    bookInfo:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    images: [
      'lib/assets/images/3D_hipster.jpg',
    ],
    ownerUid: '6',
    isSell: true,
    isRent: false,
    isSwap: true,
    sellPrice: 45,
    leasePrice: null,
    leaseDuration: null,
    leaseTimeRange: null,
    likedUids: [],
  ),
  Book(
    id: '7',
    title: 'The Catcher in the Rye',
    author: 'J.D. Salinger',
    location: 'Miami',
    bookDescription:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    bookInfo:
        'Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem Lorem ',
    images: [
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
      'lib/assets/images/3D_hipster.jpg',
    ],
    ownerUid: '7',
    isRent: true,
    isSell: true,
    isSwap: true,
    sellPrice: 45,
    leasePrice: 3,
    leaseDuration: null,
    leaseTimeRange: DateTimeRange(
      start: DateTime.fromMillisecondsSinceEpoch(1650979000000),
      end: DateTime.fromMillisecondsSinceEpoch(1655979000000),
    ),
    likedUids: [],
  ),
];
