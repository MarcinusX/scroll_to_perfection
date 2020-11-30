import 'package:flutter/material.dart';
import 'package:scroll_to_perfection/egipt/egypt.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() => setState(() {}));
    _animation = CurvedAnimation(
      curve: Curves.easeOutCubic,
      parent: _animationController,
    );
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
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, (1 - _animation.value) * height * 0.25),
          child: child,
        ),
        child: Column(
          children: <Widget>[
            WhenShownListener(
              onWidgetShown: () => _animationController.forward(),
              child: Text(
                'THE ANCIENT',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Egyptian',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Text(
                  ' civilization',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                )
              ],
            ),
            SizedBox(height: height * 0.1),
            if (width > 440)
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'The ancient Egyptian civilization, famous for its pyramids, pharaohs, mummies, and tombs, flourished for thousands for thousands of yers. But what was its lasting impact?',
                    ),
                  ),
                  SizedBox(width: 64),
                  Expanded(
                    child: Text(
                      'Watch the video below to learn how ancient Egypt contributed to modern-day society with its many cultural developments, particularly in language & mathematics',
                    ),
                  )
                ],
              )
            else ...[
              Text(
                'The ancient Egyptian civilization, famous for its pyramids, pharaohs, mummies, and tombs, flourished for thousands for thousands of yers. But what was its lasting impact?',
              ),
              SizedBox(height: 16),
              Text(
                'Watch the video below to learn how ancient Egypt contributed to modern-day society with its many cultural developments, particularly in language & mathematics',
              )
            ],
            SizedBox(height: height * 0.1),
          ],
        ),
      ),
    );
  }
}

class EgiptPage extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;

  const EgiptPage({Key key, this.scrollController, this.child})
      : super(key: key);

  @override
  _EgiptPageState createState() => _EgiptPageState();
}

class _EgiptPageState extends State<EgiptPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.scrollController,
      builder: (context, child) {
        final renderObject = context.findRenderObject() as RenderBox;
        final offsetY = renderObject?.localToGlobal(Offset.zero)?.dy ?? 0;
        final deviceHeight = MediaQuery.of(context).size.height;
        if (renderObject != null &&
            offsetY < deviceHeight &&
            _animationController.isDismissed) {
          _animationController.forward();
        }
        return child;
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Transform.translate(
          offset: Offset(0, 100 * (1 - _animationController.value)),
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}

class MyAwesomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
