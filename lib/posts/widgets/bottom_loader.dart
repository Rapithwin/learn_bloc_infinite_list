import 'package:flutter/material.dart';

class BottomLoader extends StatelessWidget {
  const BottomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.5),
          child: CircularProgressIndicator(
            strokeWidth: 3.5,
          ),
        ),
      ),
    );
  }
}
