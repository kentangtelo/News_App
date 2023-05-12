import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

TextStyle title = const TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle titleNews = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w500,
  fontFamily: 'Poppins',
);

TextStyle seeAll = const TextStyle(
  color: Colors.grey,
);

TextStyle titleHeader = const TextStyle(
  color: Colors.white,
  fontFamily: 'Poppins',
);

TextStyle appBarTitle = const TextStyle(
  color: Colors.black,
  fontFamily: 'Poppins',
);

String time(DateTime parse) {
  return timeago.format(parse, allowFromNow: true);
}
