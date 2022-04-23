import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:playing_cards/playing_cards.dart';

class CardDeck {
  List<PlayingCard> deck = standardFiftyTwoCardDeck();

  late int _deckTop;

  List<PlayingCard> playerHand = [];
  List<PlayingCard> houseHand = [];

  // PlayingCardViewStyle myCardStyles = PlayingCardViewStyle(suitStyles: {
  //   Suit.spades: SuitStyle(
  //     builder: (context) => FittedBox(
  //       fit: BoxFit.fitHeight,
  //       child: Text(
  //         "S",
  //         style: TextStyle(fontSize: 500),
  //       ),
  //     ),
  //   ),
  //   Suit.diamonds: SuitStyle(
  //     builder: (context) => FittedBox(
  //       fit: BoxFit.fitHeight,
  //       child: Text(
  //         "D",
  //         style: TextStyle(fontSize: 500),
  //       ),
  //     ),
  //   ),
  //   Suit.clubs: SuitStyle(
  //     builder: (context) => FittedBox(
  //       fit: BoxFit.fitHeight,
  //       child: Text(
  //         "C",
  //         style: TextStyle(fontSize: 500),
  //       ),
  //     ),
  //   ),
  //   Suit.hearts: SuitStyle(
  //     builder: (context) => FittedBox(
  //       fit: BoxFit.fitHeight,
  //       child: Text(
  //         "H",
  //         style: TextStyle(fontSize: 500),
  //       ),
  //     ),
  //   ),
  // });

  // PlayingCardViewStyle getMyCardStyles() {
  //   return myCardStyles;
  // }

  CardDeck(){
    shuffle(deck);
    _deckTop = 0;
  }

  List<PlayingCard> getDeck(){
    return deck;
  }

  List<PlayingCard> getPlayerHand(){
    return playerHand;
  }

  List<PlayingCard> getHouseHand(){
    return houseHand;
  }

  void addPlayerCard(){
    playerHand.add(nextCard()); // add the next card in the deck to the player's hand
  }

  void addHouseCard(){
    houseHand.add(nextCard()); // add the next card in the deck to the house's hand
  }

  PlayingCard nextCard() {
    _deckTop++; // pull a card off of the top
    // print(deck[_deckTop].value);
    return deck[_deckTop]; // return the top card
  }

  String handEnd(){
    houseDraw();

    var playerHandSum = calculateHand(hand: playerHand);
    var houseHandSum = calculateHand(hand: houseHand);

    var result = "You Lost";

    if (playerHandSum < 21 && houseHandSum > playerHandSum && houseHandSum <= 21)
      result = "You Lost";
    else if (playerHandSum > 21)
      result = "You Lost";
    else if (playerHandSum == 21 && houseHandSum == 21)
      result = "You Tied";
    else if (playerHandSum == houseHandSum)
      result = "You Tied";
    else if (playerHandSum < 21 && houseHandSum != 21)
      result = "You Won!";
    else if (playerHandSum == 21 && houseHandSum > 21)
      result = "You Won!";
    else if (playerHandSum == 21 && houseHandSum != 21)
      result = "You Won!";


    return result;
  }

  void houseDraw(){
    var houseValue = 0;
    addHouseCard();

    while (houseValue <= 17) {
      addHouseCard();
      houseValue = calculateHand(hand: houseHand);
    }

  }

  int calculateHand({required List<PlayingCard> hand}){
    int handSum = 0;
    int acesInHand = 0;

    // for each card, add its value to the sum
    for (var card in hand) {
      if (card.value == CardValue.two)
        handSum += 2;
      else if (card.value == CardValue.three)
        handSum += 3;
      else if (card.value == CardValue.four)
        handSum += 4;
      else if (card.value == CardValue.five)
        handSum += 5;
      else if (card.value == CardValue.six)
        handSum += 6;
      else if (card.value == CardValue.seven)
        handSum += 7;
      else if (card.value == CardValue.eight)
        handSum += 8;
      else if (card.value == CardValue.nine)
        handSum += 9;
      else if (card.value == CardValue.ten || card.value == CardValue.jack || card.value == CardValue.queen || card.value == CardValue.king)
        handSum += 10;
      else if (card.value == CardValue.ace)
        acesInHand++; // save the aces to calculate after everything else
    }

    // calculate the value of any aces
    for (int i = 0; i < acesInHand; i++){
      if (handSum >= 11)
        handSum += 1;
      else if (handSum < 11)
        handSum += 11;
    }

    return handSum;
  }

  void shuffle(List elements, [int start = 0, int? end, Random? random]) {
    random ??= Random();
    end ??= elements.length;
    var length = end - start;
    while (length > 1) {
      var pos = random.nextInt(length);
      length--;
      var tmp1 = elements[start + pos];
      elements[start + pos] = elements[start + length];
      elements[start + length] = tmp1;
    }
  }

}