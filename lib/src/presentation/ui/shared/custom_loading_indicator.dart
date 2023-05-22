import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 1.5,
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
