import 'package:flutter/material.dart';

Widget imageLoadingBuilder(
    BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }
  return Center(
    child: CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null
          ? loadingProgress.cumulativeBytesLoaded /
              (loadingProgress.expectedTotalBytes ?? 100)
          : null,
      strokeWidth: 2,
      valueColor: const AlwaysStoppedAnimation(
        Colors.black45,
      ),
    ),
  );
}
