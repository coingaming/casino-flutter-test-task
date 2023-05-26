import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget(
      {Key? key,
      required this.image,
      this.width = 50,
      this.height = 50,
      this.fit})
      : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
            color: Colors.brown,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
    );
  }
}
