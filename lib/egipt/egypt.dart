import 'package:flutter/material.dart';
import 'package:scroll_to_perfection/egipt/main_text.dart';
import 'package:scroll_to_perfection/egipt/page2.dart';
import 'package:scroll_to_perfection/egipt/page3.dart';

import 'page1.dart';

class EgyptPage extends StatefulWidget {
  EgyptPage({Key key}) : super(key: key);

  @override
  _EgyptPageState createState() => _EgyptPageState();
}

Color backgroundColor = Color.fromRGBO(216, 177, 136, 1);
Color darkerColor = Color.fromRGBO(200, 162, 122, 1);

class _EgyptPageState extends State<EgyptPage> {
  ScrollController _scrollController;

  double get screenHeight => MediaQuery.of(context).size.height;

  double get screenWidth => MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double get offset =>
      _scrollController.hasClients ? _scrollController.offset : 0.0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Deligne',
        textTheme: TextTheme(body1: TextStyle(fontSize: 28)),
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: -0.3 * offset,
              left: 0,
              right: 0,
              height: screenHeight,
              child: RepaintBoundary(
                child: Image.asset(
                  'images/sky.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 0.2 * screenHeight,
              left: 0,
              right: 0,
              child: MainText(),
            ),
            Positioned(
              top: screenHeight * 0.55 - 0.65 * offset,
              right: 0,
              left: 0,
              height: screenHeight * 0.4,
              child: RepaintBoundary(
                child: Image.asset(
                  'images/pyramid.png',
                  fit: BoxFit.cover,
                  alignment: Alignment(0, -0.2),
                ),
              ),
            ),
            Header(),
            Positioned(
              top: screenHeight * 0.8 - 1 * offset,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: RepaintBoundary(
                child: Image.asset(
                  'images/sand.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.8 - 1 * offset,
              left: 0,
              right: 0,
              height: screenHeight * 0.3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, 1],
                    colors: [backgroundColor.withOpacity(0), backgroundColor],
                  ),
                ),
              ),
            ),
            Scrollbar(
              child: ListView(
                controller: _scrollController,
                cacheExtent: screenHeight * 1,
                children: <Widget>[
                  Container(height: screenHeight),
                  Container(
                    height: 100,
                    color: backgroundColor,
                  ),
                  Container(
                    color: backgroundColor,
                    child: Page1(),
                  ),
                  Page2(),
                  Page3(),
                  Container(
                    height: 100,
                    color: darkerColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(64),
      child: Row(
        children: <Widget>[
          Text('GOTOEGYPT'),
          Spacer(),
          if (MediaQuery.of(context).size.width > 900) ...[
            Text('Home'),
            SizedBox(width: 32),
            Text('Explore'),
            SizedBox(width: 32),
            Text('Articles'),
            SizedBox(width: 32),
            Text('Galries'),
            SizedBox(width: 32),
            Text('Contact'),
            SizedBox(width: 64),
          ],
          Icon(
            Icons.apps,
            color: backgroundColor,
            size: 32,
          ),
        ],
      ),
    );
  }
}

class WhenShownListener extends StatefulWidget {
  final VoidCallback onWidgetShown;
  final Widget child;
  final double initOffset;

  const WhenShownListener(
      {Key key, this.onWidgetShown, this.child, this.initOffset = 0})
      : super(key: key);

  @override
  _WhenShownListenerState createState() => _WhenShownListenerState();
}

class _WhenShownListenerState extends State<WhenShownListener> {
  bool hasEmitted = false;

  @override
  Widget build(BuildContext context) {
    final renderObject = context.findRenderObject() as RenderBox;
    final offsetY = renderObject?.localToGlobal(Offset.zero)?.dy ?? 0;
    final deviceHeight = MediaQuery.of(context).size.height;
    if (renderObject != null &&
        offsetY < deviceHeight - widget.initOffset &&
        !hasEmitted) {
      hasEmitted = true;
      widget.onWidgetShown();
    }
    return widget.child;
  }
}
