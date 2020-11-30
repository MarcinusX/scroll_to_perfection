import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scroll_to_perfection/blocked_animation.dart';
import 'package:scroll_to_perfection/cuberto.dart';
import 'package:scroll_to_perfection/egipt/egypt.dart';
import 'package:scroll_to_perfection/vgv.dart';
import 'package:scroll_to_perfection/whatsapp_images.dart';
import 'package:scroll_to_perfection/zoom_in.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (_) => HomePage(),
        '/whatsapp': (_) => WhatsappImages(),
        '/egypt': (_) => EgyptPage(),
        '/verygood': (_) => VeryGood(),
        '/blockedAnimation': (_) => BlockedAnimation(),
        '/zoom_in': (_) => ZoomIn(),
        '/cuberto': (_) => Cuberto(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter: Scroll to perfection'),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.github),
            onPressed: () =>
                launch('https://github.com/MarcinusX/scroll_to_perfection'),
          )
        ],
      ),
      body: ListView(
        children: [
          DemoOptionButton(
            name: 'What\'sApp paralax images',
            path: '/whatsapp',
          ),
          DemoOptionButton(
            name: 'Egypt',
            path: '/egypt',
          ),
          DemoOptionButton(
            name: 'VeryGood',
            path: '/verygood',
          ),
          DemoOptionButton(
            name: 'Blocked animation',
            path: '/blockedAnimation',
          ),
          DemoOptionButton(
            name: 'Zoom in',
            path: '/zoom_in',
          ),
          DemoOptionButton(
            name: 'Cuberto',
            path: '/cuberto',
          ),
        ],
      ),
    );
  }
}

class DemoOptionButton extends StatelessWidget {
  final String name;
  final String path;

  const DemoOptionButton({Key key, this.name, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      onTap: () => Navigator.of(context).pushNamed(path),
    );
  }
}
