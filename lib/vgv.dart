import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class VeryGood extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Very good gentle animations'),
      ),
      body: ChangeNotifierProvider.value(
        value: scrollController,
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 800),
            alignment: Alignment.center,
            child: ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                final moduloIndex = index % 3;
                if (moduloIndex == 0) {
                  return AspectRatio(
                    aspectRatio: 2,
                    child: VeryGoodImage(
                      'images/image0.jpg',
                    ),
                  );
                } else if (moduloIndex == 1) {
                  return Row(
                    children: [
                      Expanded(
                        child: VeryGoodImage(
                          'images/image1.jpg',
                        ),
                      ),
                      Expanded(
                        child: VeryGoodImage(
                          'images/image2.jpg',
                        ),
                      )
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: VeryGoodImage(
                            'images/image3.jpg',
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: VeryGoodImage(
                            'images/image4.jpg',
                          ),
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: VeryGoodImage(
                            'images/image5.jpg',
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class VeryGoodImage extends StatelessWidget {
  final String imagePath;

  const VeryGoodImage(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return VeryGoodWrapper(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class VeryGoodWrapper extends StatelessWidget {
  final Widget child;

  const VeryGoodWrapper({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollController>(
      builder: (context, scrollController, child) {
        final renderObject = context.findRenderObject() as RenderBox;
        final offsetY = renderObject?.localToGlobal(Offset.zero)?.dy ?? 0;
        if (offsetY <= 0) {
          return child;
        }
        final deviceHeight = MediaQuery.of(context).size.height;
        final size = renderObject.size;
        final heightVisible = deviceHeight - offsetY;
        final howMuchSown = (heightVisible / size.height).clamp(0.0, 1.0);
        final scale = 0.8 + howMuchSown * 0.2;
        final opacity = 0.25 + howMuchSown * 0.75;
        return Transform.scale(
          scale: scale,
          alignment: Alignment.center,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
