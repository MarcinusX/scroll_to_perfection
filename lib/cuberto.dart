import 'dart:math';

import 'package:flutter/material.dart';

class Cuberto extends StatefulWidget {
  @override
  _CubertoState createState() => _CubertoState();
}

class _CubertoState extends State<Cuberto> {
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuberto'),
      ),
      body: Scrollbar(
        controller: pageController,
        isAlwaysShown: true,
        thickness: 6,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              pageSnapping: false,
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(),
                Page(index: 0, pageController: pageController),
                Page(index: 1),
                Page(index: 2),
                Page(index: 3),
                Page(index: 4, pageController: pageController),
                SizedBox(),
              ],
            ),
            if (pageController.hasClients &&
                pageController.page != null &&
                pageController.page > 1 &&
                pageController.page < 5)
              Align(
                alignment: Alignment(0.5, 0),
                child: IgnorePointer(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Stack(
                      children: [
                        _StackImage(pageController: pageController, index: 4),
                        _StackImage(pageController: pageController, index: 3),
                        _StackImage(pageController: pageController, index: 2),
                        _StackImage(pageController: pageController, index: 1),
                        _StackImage(pageController: pageController, index: 0),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StackImage extends StatelessWidget {
  const _StackImage({
    Key key,
    @required this.pageController,
    @required this.index,
  }) : super(key: key);

  final PageController pageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    final page = pageController.hasClients ? (pageController.page ?? 0) : 0;
    final percentageMoved = (page - index - 1).clamp(0.0, 1.0);
    return Positioned.fill(
      child: ClipPath(
        clipper: percentageMoved > 0 ? WaveClipper(percentageMoved) : null,
        child: Image.asset(
          'images/image$index.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final int index;
  final PageController pageController;

  const Page({Key key, this.index, this.pageController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shouldShowImageOnFirstPage = index == 0 &&
        pageController.hasClients &&
        pageController.page != null &&
        pageController.page <= 1;
    final shouldShowImageOnLastPage = index == 4 &&
        pageController.hasClients &&
        pageController.page != null &&
        pageController.page >= 5;
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'Page $index',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Expanded(
          child: shouldShowImageOnFirstPage || shouldShowImageOnLastPage
              ? Container(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'images/image$index.jpg',
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height * 0.8,
                    fit: BoxFit.cover,
                  ),
                )
              : SizedBox(),
        ),
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double percentage;

  WaveClipper(this.percentage);

  @override
  Path getClip(Size size) {
    Path path = Path();
    final height = size.height * (1 - percentage);
    path.lineTo(0, height);
    path.quadraticBezierTo(
      size.width * 1 / 8,
      height - 40 * sin(20 * percentage).abs(),
      size.width * 1 / 4,
      height - 20 * sin(20 * percentage).abs(),
    );
    path.quadraticBezierTo(
      size.width * 3 / 8,
      height - 10 * sin(10 * percentage).abs(),
      size.width * 2 / 4,
      height - 30 * sin(10 * percentage).abs(),
    );
    path.quadraticBezierTo(
      size.width * 5 / 8,
      height - 50 * sin(20 * percentage).abs(),
      size.width * 3 / 4,
      height - 25 * sin(20 * percentage).abs(),
    );
    path.quadraticBezierTo(
      size.width * 7 / 8,
      height - 15 * sin(15 * percentage).abs(),
      size.width * 4 / 4,
      height - 30 * sin(15 * percentage).abs(),
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => true;
}
