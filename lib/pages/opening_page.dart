import 'package:flutter/material.dart';

import 'game_page.dart';

class OpeningPage extends StatelessWidget {
  final _chipController = TextEditingController();
  final _poolController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();
    return _openingPage(context);
  }

  Widget _openingPage(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TODO Create TextButton for Starting credits
                Text("Blackjack\n", style: TextStyle(fontSize: 25)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GamePage(
                                  chips: (int.parse(_chipController.text) - (int.parse(_poolController.text))).toString(),
                                  pool: _poolController.text)));
                    },
                    child: const Text('Start New Game', style: TextStyle(fontSize: 18))),

                Column(
                  children: [
                    Text(
                      "\nStarting Credits:",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextField(
                        controller: _chipController,
                        decoration: const InputDecoration(
                            //icon: Icon(Icons.person),
                            hintText: '1000',
                            constraints: BoxConstraints(maxWidth: 100))
                        // TODO add validator for only numbers
                        ),
                    Text(
                      "\nStarting Bet:",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextField(
                        controller: _poolController,
                        decoration: const InputDecoration(
                            //icon: Icon(Icons.person),
                            hintText: '100',
                            constraints: BoxConstraints(maxWidth: 100))
                        // TODO add validator for only numbers
                        ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
