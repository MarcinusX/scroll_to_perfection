import 'dart:math' as math;

import 'package:flutter/material.dart';

class ZoomIn extends StatefulWidget {
  @override
  _ZoomInState createState() => _ZoomInState();
}

class _ZoomInState extends State<ZoomIn> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  double get pageOffset => pageController.hasClients ? pageController.page : 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoom in'),
      ),
      body: Stack(
        children: [
          Page(
            color: Colors.yellow,
            text: 'The master fisherman',
            imagePath: 'images/image2.jpg',
            transitionPercentage: pageOffset < 1.1 ? null : 0,
          ),
          Page(
            color: Colors.deepOrange,
            text: 'What the deer are telling us',
            imagePath: 'images/image1.jpg',
            transitionPercentage:
                pageOffset < 0.1 ? null : (pageOffset - 1).clamp(0.0, 1.0),
          ),
          Page(
            color: Colors.orangeAccent,
            text: 'The elephant queen',
            imagePath: 'images/image0.jpg',
            transitionPercentage:
                pageController.hasClients ? pageOffset.clamp(0.0, 1.0) : null,
          ),
          NotificationListener<ScrollNotification>(
            onNotification: (not) {
              print(not);
              return true;
            },
            child: PageView(
              controller: pageController,
              scrollDirection: Axis.vertical,
              children: [
                Container(width: double.infinity),
                Container(width: double.infinity),
                Container(width: double.infinity),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Page extends StatefulWidget {
  final Color color;
  final String text;
  final String imagePath;
  final double transitionPercentage;

  const Page({
    this.text,
    this.imagePath,
    Key key,
    this.color,
    this.transitionPercentage,
  }) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
      upperBound: 0.05,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Page oldWidget) {
    if (oldWidget.transitionPercentage == null &&
        widget.transitionPercentage != null) {
      animationController.forward(from: 0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper:
          InvertedCircleClipper(percentage: widget.transitionPercentage ?? 0),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 1 +
                animationController.value +
                (widget.transitionPercentage ?? 0),
            child: child,
          );
        },
        child: Container(
          color: widget.color,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.text),
                  Image.asset(
                    widget.imagePath,
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.height / 2,
                    fit: BoxFit.cover,
                  )
                ],
              ),
              TextButton(
                child: Text('Scroll down'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  final double percentage;

  InvertedCircleClipper({this.percentage});

  @override
  Path getClip(Size size) {
    return Path()
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: math.sqrt(size.longestSide * size.longestSide +
                  size.shortestSide * size.shortestSide) *
              percentage *
              0.5,
        ),
      )
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
