import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final double size;
  final Color color;

  Loading({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitPulsingGrid(
        color: color,
        size: size,
      ),
    );
  }
}
