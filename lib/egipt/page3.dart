import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scroll_to_perfection/egipt/egypt.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(
        curve: Curves.easeOutCubic, parent: _animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: darkerColor,
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Column(
          children: <Widget>[
            SizedBox(height: height * 0.1),
            Text('10 THINGS', style: TextStyle(color: Colors.black)),
            SizedBox(height: height * 0.05),
            _header(),
            WhenShownListener(
              initOffset: 200,
              onWidgetShown: () => _animationController.forward(),
              child: SizedBox(height: height * 0.1),
            ),
            if (width > height)
              Row(
                children: <Widget>[
                  Expanded(child: _leftSide(width)),
                  SizedBox(width: width * 0.1),
                  Expanded(child: _rightSide(height, width))
                ],
              )
            else ...[
              _leftSide(width),
              _rightSide(height, width),
            ],
            SizedBox(height: height * 0.1),
          ],
        ),
      ),
    );
  }

  RichText _header() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontFamily: 'IbarraRealNova',
        ),
        children: [
          TextSpan(
            text: 'You probably didn\'t know\n',
          ),
          TextSpan(
            text: 'about ',
          ),
          TextSpan(
            text: 'ancient Egypt',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'IbarraRealNova',
            ),
          )
        ],
      ),
    );
  }

  Widget _rightSide(double height, double width) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset((width / 2) * (1 - _animation.value), 0),
          child: child,
        );
      },
      child: Container(
        height: height / 2,
        child: Stack(
          alignment: Alignment(0, 0.5),
          children: <Widget>[
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value * 0.5 * pi - pi * 0.7,
                  child: child,
                );
              },
              child: Container(
                width: 360,
                height: 360,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.7),
                      Colors.white.withOpacity(0),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Image.asset('images/pharaon.png'),
          ],
        ),
      ),
    );
  }

  Widget _leftSide(double width) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset((-width / 2) * (1 - _animation.value), 0),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'His original name was\nNot Tutankhamun',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 38,
            ),
          ),
          SizedBox(height: 32),
          Text(
            'Tutankhamun was originally named Tutanhaten. This name, whic literally means "living image of the Aten", reflected the fact that Tutankhaten\'s parents worshipped a sun god known as "the Aten". After a few years on the throne the young king.',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 32),
          Text(
            'Read More',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.black,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
