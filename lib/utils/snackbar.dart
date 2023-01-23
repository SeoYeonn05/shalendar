import 'package:flutter/material.dart';

void showSnackBar(dynamic context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  ;
}
