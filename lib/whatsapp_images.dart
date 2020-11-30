import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WhatsappImages extends StatefulWidget {
  @override
  _WhatsappImagesState createState() => _WhatsappImagesState();
}

class _WhatsappImagesState extends State<WhatsappImages> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whatsapp Parallax'),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          final imagePath = 'images/image${index % 6}.jpg';
          return AnimatedBuilder(
            animation: scrollController,
            builder: (context, child) => SingleImage(
              imagePath: imagePath,
            ),
          );
        },
      ),
    );
  }
}

class SingleImage extends StatelessWidget {
  final String imagePath;

  const SingleImage({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final renderObject = context.findRenderObject() as RenderBox;
    final offsetY = renderObject?.localToGlobal(Offset.zero)?.dy ?? 0;
    final deviceHeight = MediaQuery.of(context).size.height;
    final relativePosition = offsetY / deviceHeight;

    return Center(
      child: Container(
        width: 800,
        height: 300,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 2),
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment(0, relativePosition - 0.5),
            image: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }
}
