import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage cross = AssetImage('images/cross.png');
  AssetImage edit = AssetImage('images/edit.png');

  bool isCross = true;

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
    });
  }

  AlertStyle alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    animationDuration: Duration(
      milliseconds: 500,
    ),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    titleStyle: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
  );

  void playGame(int index) {
    if (gameState[index] == 'empty') {
      setState(() {
        if (isCross) {
          this.gameState[index] = 'cross';
        } else {
          this.gameState[index] = 'circle';
        }
        this.isCross = !this.isCross;
        this.checkWin();
      });
    }
  }

  alertDialogueBoxForWin(context, index) {
    Alert(
      closeFunction: resetGame,
      context: context,
      title: '${this.gameState[index]} won',
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      image: Image(
        image: getImage(this.gameState[index]),
        height: 80.0,
        width: 80.0,
        fit: BoxFit.cover,
      ),
      style: alertStyle,
    ).show();
  }

  alertDialogueBoxForDraw(context) {
    Alert(
      context: context,
      closeFunction: resetGame,
      title: 'GAME DRAW',
      buttons: [
        DialogButton(
          child: Text(
            'OK',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage("images/cross.png"),
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
          Image(
            image: AssetImage("images/circle.png"),
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
        ],
      ),
      style: alertStyle,
    ).show();
  }

  void checkWin() {
    if ((this.gameState[0] != 'empty') &&
        (this.gameState[0] == this.gameState[1]) &&
        (this.gameState[1] == this.gameState[2])) {
      setState(() {
        alertDialogueBoxForWin(context, 0);
        resetGame();
      });
    } else if ((this.gameState[3] != 'empty') &&
        (this.gameState[3] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[5])) {
      setState(() {
        alertDialogueBoxForWin(context, 3);
        resetGame();
      });
    } else if ((this.gameState[6] != 'empty') &&
        (this.gameState[6] == this.gameState[7]) &&
        (this.gameState[7] == this.gameState[8])) {
      setState(() {
        alertDialogueBoxForWin(context, 6);
        resetGame();
      });
    } else if ((this.gameState[0] != 'empty') &&
        (this.gameState[0] == this.gameState[3]) &&
        (this.gameState[3] == this.gameState[6])) {
      setState(() {
        alertDialogueBoxForWin(context, 0);
        resetGame();
      });
    } else if ((this.gameState[1] != 'empty') &&
        (this.gameState[1] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[7])) {
      setState(() {
        alertDialogueBoxForWin(context, 1);
        resetGame();
      });
    } else if ((this.gameState[2] != 'empty') &&
        (this.gameState[2] == this.gameState[5]) &&
        (this.gameState[5] == this.gameState[8])) {
      setState(() {
        alertDialogueBoxForWin(context, 2);
        resetGame();
      });
    } else if ((this.gameState[0] != 'empty') &&
        (this.gameState[0] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[8])) {
      setState(() {
        alertDialogueBoxForWin(context, 0);
        resetGame();
      });
    } else if ((this.gameState[2] != 'empty') &&
        (this.gameState[2] == this.gameState[4]) &&
        (this.gameState[4] == this.gameState[6])) {
      setState(() {
        alertDialogueBoxForWin(context, 2);
        resetGame();
      });
    } else if (!gameState.contains('empty')) {
      setState(() {
        this.alertDialogueBoxForDraw(context);
        resetGame();
      });
    }
  }

  getImage(String value) {
    switch (value) {
      case ('empty'):
        return edit;
        break;

      case ('cross'):
        return cross;
        break;
      case ('circle'):
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
