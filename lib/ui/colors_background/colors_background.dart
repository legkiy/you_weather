import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsBackground extends StatelessWidget {
  const ColorsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, -1.2),
      child: Column(
        children: [
          Align(
            alignment: const AlignmentDirectional(0, -1.2),
            child: Container(
              width: 500,
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.blue,
                  ],
                  begin: AlignmentDirectional.bottomEnd,
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 100.0,
              sigmaY: 50.0,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
