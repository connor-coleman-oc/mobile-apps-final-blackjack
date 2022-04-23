import 'package:flutter/material.dart';

import 'game_page.dart';
import 'opening_page.dart';

class GameOverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();
    return _gameOverPage(context);
  }

  Widget _gameOverPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TODO Create TextButton for Starting credits
                Text("Game Over\nYou ran out of chips\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24)),

                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OpeningPage()));
                    },
                    child: const Text('Back to Start Page')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
