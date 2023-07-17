import 'package:book/widgets/error_widget.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    required this.e,
    required this.s,
  });

  final Object e;
  final StackTrace s;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyErrorWidget(e: e, s: s),
    );
  }
}
