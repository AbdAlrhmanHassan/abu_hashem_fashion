import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget customAppName() {
  return Shimmer.fromColors(
    period: const Duration(seconds: 8),
    baseColor: Colors.black,
    highlightColor: Colors.blue[200]!,
    child: const Text(
      "Abu Hashem Fashion",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}
