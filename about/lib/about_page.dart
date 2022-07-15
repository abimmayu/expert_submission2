import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const routeName = '/about';

  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: kPrussianBlue,
                  child: const Center(
                    child: ClipOval(
                      child: Image(
                          width: 128,
                          height: 128,
                          image: AssetImage(
                            'assets/muse.png',
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: kMikadoYellow,
                  child: const Text(
                    'Muse Asia merupakan sebuah aplikasi katalog film yang dikembangkan oleh Abim sebagai proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
          )
        ],
      ),
    );
  }
}
