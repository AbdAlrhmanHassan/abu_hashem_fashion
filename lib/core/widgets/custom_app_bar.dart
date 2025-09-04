import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget customAppName({Duration? duration}) {
  return Shimmer.fromColors(
    period: duration ?? const Duration(seconds: 8),
    baseColor: Colors.black,
    highlightColor: Colors.blue[200]!,
    child: const Text(
      // "أبو هاشم للأزياء",
      "Abu Hashem Fashion",
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}
