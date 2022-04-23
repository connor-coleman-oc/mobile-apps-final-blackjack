import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playing_cards/playing_cards.dart';

import '../objects/card_deck.dart';
import 'game_over_page.dart';

class GamePage extends StatefulWidget {
  String chips;
  String pool;
  String result = "";
  var roundOver = false;
  var poolController = TextEditingController();

  var deck = CardDeck();

  GamePage({required this.chips, required this.pool}) {
    // initialize both hands
    for (int i = 0; i < 2; i++) {
      deck.addPlayerCard();
      // deck.addHouseCard();
    }
  }

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return _gamePage(context);
  }

  Widget _gamePage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "House Hand: " +
                      widget.deck
                          .calculateHand(hand: widget.deck.getHouseHand())
                          .toString() +
                      "\n",
                  style: TextStyle(fontSize: 16)),
              Container(
                height: 120,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.deck
                        .getHouseHand()
                        .map((e) => PlayingCardView(
                              card: e,
                            ))
                        .toList(),
                  ),
                ),
              ),
              // Container(
              //   height: 150,
              //   child: FlatCardFan(
              //     children: deck.getPlayerHand().map((e) => PlayingCardView(card: e,)).toList(),
              //   ),
              // ),
              // TODO add hit and stay buttons

              Text(
                "\n" + widget.result + "\n",
                style: TextStyle(fontSize: 17),
              ),

              widget.roundOver
                  ? Container()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                widget.deck.addPlayerCard();
                              });
                            },
                            child: const Text('Hit')),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                // have the dealer go and calculate who won
                                widget.result = widget.deck.handEnd();
                                if (widget.result == "You Won!") {
                                  widget.chips = (int.parse(widget.chips) +
                                          (int.parse(widget.pool) * 2))
                                      .toString();
                                } else if (widget.result == "You Tied") {
                                  widget.chips = (int.parse(widget.chips) +
                                          int.parse(widget.pool))
                                      .toString();
                                  // } else if (widget.result == "You Lost") {
                                  //   widget.chips = (int.parse(widget.chips) -
                                  //           int.parse(widget.pool))
                                  //       .toString();
                                }
                                widget.pool = "0";
                                widget.roundOver = true;

                                if (widget.chips == "0"){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GameOverPage()));
                                }

                              });
                            },
                            child: const Text('Stay')),
                      ],
                    ),

              Container(
                height: 120,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.deck
                        .getPlayerHand()
                        .map((e) => PlayingCardView(
                              card: e,
                            ))
                        .toList(),
                  ),
                ),
              ),

              // TODO add current pool
              // TODO add personal chip counter
              Text(
                  "\nPlayer Hand: " +
                      widget.deck
                          .calculateHand(hand: widget.deck.getPlayerHand())
                          .toString(),
                  style: TextStyle(fontSize: 16)),
              Text("\n\nCurrent chips: " + widget.chips,
                  style: TextStyle(fontSize: 16)),
              Text("\nCurrent pool: " + widget.pool + "\n",
                  style: TextStyle(fontSize: 16)),

              widget.roundOver ? // this is a conditional operator (boolVariable ? falseWidget() : trueWidget()
              // if (widget.roundOver && !widget.gameOver)
                  Column(
                      children: [
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          // Text(
                          //   "Next Bet:",
                          //   style: TextStyle(fontSize: 16),
                          // ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GamePage(
                                            chips: (int.parse(widget.chips) -
                                                (int.parse(widget
                                                    .poolController.text)))
                                                .toString(),
                                            pool: widget.poolController.text)));
                              },
                              child: const Text('Next Bet: ')),
                          Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
                          TextField(
                              controller: widget.poolController,
                              decoration: const InputDecoration(
                                  //icon: Icon(Icons.person),
                                  constraints: BoxConstraints(maxWidth: 100))
                              // TODO add validator for only numbers
                              ),
                        ]),
                      ],
                  ) : Container(),
            ],

          ),
        ),
      ),
    );
  }
}
