import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage cross = AssetImage('images/cross.png');
  AssetImage edit = AssetImage('images/edit.png');

  bool isCross = true;
  String message;

  List<String> gameState;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = "";
    });
  }

  void playGame(int index) {
    if (gameState[index] == 'empty') {
      setState(() {
        if (isCross) {
          this.gameState[index] = 'Cross';
        } else {
          this.gameState[index] = 'Circle';
        }
        this.isCross = !this.isCross;
        this.checkWin();
      });
    }
  }

  void checkWin() {
    if ((this.gameState[0] != 'empty') &&
        (this.gameState[0] == this.gameState[1]) &&
        (this.gameState[1] == this.gameState[2])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
      });
    } else if ((this.gameState[3] != 'empty') &&
        (this.gameState[3] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[5])) {
      setState(() {
        this.message = '${this.gameState[3]} wins';
      });
    } else if ((this.gameState[6] != 'empty') &&
        (this.gameState[6] == this.gameState[7]) &&
        (this.gameState[7] == this.gameState[8])) {
      setState(() {
        this.message = '${this.gameState[6]} wins';
      });
    } else if ((this.gameState[0] != 'empty') &&
        (this.gameState[0] == this.gameState[3]) &&
        (this.gameState[3] == this.gameState[6])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
      });
    } else if ((this.gameState[1] != 'empty') &&
        (this.gameState[1] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[7])) {
      setState(() {
        this.message = '${this.gameState[1]} wins';
      });
    } else if ((this.gameState[2] != 'empty') &&
        (this.gameState[2] == this.gameState[5]) &&
        (this.gameState[5] == this.gameState[8])) {
      setState(() {
        this.message = '${this.gameState[2]} wins';
      });
    } else if ((this.gameState[0] != 'empty') &&
        (this.gameState[0] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[8])) {
      setState(() {
        this.message = '${this.gameState[0]} wins';
      });
    } else if ((this.gameState[2] != 'empty') &&
        (this.gameState[2] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[6])) {
      setState(() {
        this.message = '${this.gameState[2]} wins';
      });
    } else if (!gameState.contains('empty')) {
      setState(() {
        this.message = 'GAME DRAWS';
      });
    }
    if (this.message.isNotEmpty) {
      setState(() {
        this.resetAfterNoWin();
      });
    }
  }

  resetAfterNoWin() {
    Timer(
        Duration(
          seconds: 3,
        ), () {
      setState(() {
        this.gameState = [
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
        ];
        this.message = '';
      });
    });
  }

  AssetImage getImage(String value) {
    switch (value) {
      case ('empty'):
        return edit;
        break;

      case ('Cross'):
        return cross;
        break;
      case ('Circle'):
        return circle;
        break;
    }
  }

  void resetGame() {
    setState(() {
      this.gameState = [
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
        "empty",
      ];
      this.message = '';
    });
  }

  void resetAfterWin() {
    Timer(Duration(microseconds: 2000), () {
      setState(() {
        this.gameState = [
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
          "empty",
        ];
        this.message = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tic-Tac-Toe',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              ),
              itemCount: 9,
              itemBuilder: (context, i) => SizedBox(
                height: 150.0,
                width: 150.0,
                child: MaterialButton(
                  onPressed: () {
                    playGame(i);
                  },
                  child: Image(
                    image: this.getImage(this.gameState[i]),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              this.message,
              style: TextStyle(
                fontFamily: 'Advent_Pro',
                fontSize: 37.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          MaterialButton(
            minWidth: 230.0,
            height: 50.0,
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0),
            ),
            onPressed: () {
              this.resetGame();
            },
            child: Text(
              'Reset Game',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Project by Hitesh Garg',
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
