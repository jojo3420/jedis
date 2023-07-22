import 'package:flutter/material.dart';

void moveScreen(context, screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

void backScreen(context) {
  Navigator.pop(context);
}
