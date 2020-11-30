import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:scroll_to_perfection/egipt/egypt.dart';

class MainText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'THE ANCIENT WORLD',
          style: TextStyle(color: backgroundColor),
        ),
        SizedBox(height: 16),
        Container(
          height: 1,
          width: 64,
          color: backgroundColor,
        ),
        SizedBox(height: 32),
        Text(
          'Discover the awe-inspiring\nPyramids of Fize and ancient Egypt\'s',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.shortestSide > 400 ? 60 : 40,
          ),
        ),
        SizedBox(height: 32),
        RotatedBox(
          quarterTurns: 2,
          child: Icon(LineIcons.angle_double_up, color: Colors.grey),
        ),
        SizedBox(height: 16),
        Text('SCROLL DOWN', style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
