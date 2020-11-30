import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BlockedAnimation extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        title: Text('Animate on scroll'),
      ),
      body: Scrollbar(
        controller: scrollController,
        isAlwaysShown: true,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            _SimplePage(screenHeight: screenHeight, text: 'Scroll down'),
            SliverPersistentHeader(
              delegate: MyHeaderDelegate(screenHeight: screenHeight),
            ),
            _SimplePage(screenHeight: screenHeight, text: 'Scroll up'),
          ],
        ),
      ),
    );
  }
}

class _SimplePage extends StatelessWidget {
  const _SimplePage({
    Key key,
    @required this.screenHeight,
    @required this.text,
  }) : super(key: key);

  final double screenHeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        height: screenHeight,
        color: Color.fromARGB(255, 241, 241, 241),
        child: Text(
          text,
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double screenHeight;

  MyHeaderDelegate({@required this.screenHeight});

  @override
  double get maxExtent => 2 * screenHeight;

  @override
  double get minExtent => screenHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final screenWidth = MediaQuery.of(context).size.width;
    final percentageDone =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    return Container(
      height: double.infinity,
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: screenHeight,
        child: Stack(
          children: [
            Image1(
              percentageDone: percentageDone,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            Text1(
              percentageDone: percentageDone,
              screenWidth: screenWidth,
            ),
            Image2(
              percentageDone: percentageDone,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
            ),
            Square(
              percentageDone: percentageDone,
              screenHeight: screenHeight,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class Square extends StatelessWidget {
  const Square({
    Key key,
    @required this.percentageDone,
    @required this.screenHeight,
  }) : super(key: key);

  final double percentageDone;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    final squareStep1 = (percentageDone * 2).clamp(0.0, 1.0);
    final squareStep2 = ((percentageDone - 0.67) * 3).clamp(0.0, 1.0);
    return Align(
      alignment: Alignment(0.16 * squareStep2, 0),
      child: Container(
        width:
            squareStep1 * screenHeight * 0.1 + squareStep2 * screenHeight * 0.1,
        height:
            squareStep1 * screenHeight * 0.1 + squareStep2 * screenHeight * 0.1,
        decoration: BoxDecoration(
          border: Border.all(
            width: 4 + 8 * squareStep2,
            color: Color.lerp(Colors.white, Colors.grey, squareStep2)
                .withOpacity(squareStep1),
          ),
        ),
      ),
    );
  }
}

class Image2 extends StatelessWidget {
  const Image2({
    Key key,
    @required this.percentageDone,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final double percentageDone;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final bottomImagePercentage = ((percentageDone - 0.5) * 2).clamp(0.0, 1.0);
    return Align(
      alignment: Alignment(0.35 - 0.4 * bottomImagePercentage, 0.6),
      child: Opacity(
        opacity: bottomImagePercentage,
        child: Image.asset(
          'images/image1.jpg',
          height: screenHeight / 3.5,
          width: screenWidth / 4.5,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Text1 extends StatelessWidget {
  const Text1({
    Key key,
    @required this.screenWidth,
    @required this.percentageDone,
  }) : super(key: key);

  final double screenWidth;
  final double percentageDone;

  @override
  Widget build(BuildContext context) {
    final textPercentage = (percentageDone * 2).clamp(0.0, 1.0);

    return Align(
      alignment: Alignment(-0.3 - 0.5 * textPercentage, -0.25),
      child: Opacity(
        opacity: textPercentage,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '"You should totally subscribe to my\nchannel now"',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 16),
            Container(
              width: screenWidth * 0.4 * percentageDone,
              height: 8,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}

class Image1 extends StatelessWidget {
  const Image1({
    Key key,
    @required this.percentageDone,
    @required this.screenHeight,
    @required this.screenWidth,
  }) : super(key: key);

  final num percentageDone;
  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0.9 * percentageDone, -0.4),
      child: Opacity(
        opacity: percentageDone,
        child: Image.asset(
          'images/image2.jpg',
          height: screenHeight / 2.2,
          width: screenWidth / 2.5,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
