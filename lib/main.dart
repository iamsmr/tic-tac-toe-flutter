import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<IconData?> moves = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null
  ];
  List<bool> isFirstPress = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<int> winnerCross = [];
  bool isX = true;

  myNewFontWhite(double size) {
    return GoogleFonts.pressStart2p(
      textStyle: TextStyle(
        color: Colors.white,
        letterSpacing: 3,
        fontSize: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Color(0xff28282A),
        elevation: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text("Tic Tac Toe", style: myNewFontWhite(27)),
              SizedBox(height: 20),
              Text("Tap On The Boxes to play", style: myNewFontWhite(10)),
              SizedBox(height: 20),
              Divider(color: Colors.white30)
            ],
          ),
        ),
      ),
      // backgroundColor: Colors.grey[900],
      backgroundColor: Color(0xff28282A),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: GridView.builder(
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, int index) {
              return Opacity(
                opacity:
                    winnerCross.length == 3 && winnerCross.indexOf(index) == -1
                        ? 0.5
                        : 1,
                child: MaterialButton(
                  color: colorToDisplay(moves[index]),
                  onPressed: () {
                    if (!isFirstPress[index]) {
                      setState(() {
                        if (isX) {
                          moves[index] = Icons.close;
                        } else {
                          moves[index] = Icons.circle_outlined;
                        }
                        isX = !isX;
                        isFirstPress[index] = true;
                      });
                    }
                    checkGame(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: winnerCross.indexOf(index) != -1
                        ? BorderSide(color: Colors.white, width: 3)
                        : BorderSide.none,
                  ),
                  child: moves[index] != null
                      ? Icon(
                          moves[index],
                          color: Color(0xff1E1E1F),
                          size: 55,
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color colorToDisplay(IconData? icon) {
    if (icon == null) {
      return Color(0xff3C3C3E);
    } else if (icon == Icons.close) {
      return Color(0xffFFD447);
    } else {
      return Colors.pink;
    }
  }

  void checkGame(BuildContext context) {
    // First Row Check
    if (moves[0] != null && moves[0] == moves[1] && moves[0] == moves[2]) {
      showWinDialog(moves[0]!, [0, 1, 2], context);
    }
    // Second Row Check
    else if (moves[3] != null && moves[3] == moves[4] && moves[3] == moves[5]) {
      showWinDialog(moves[3]!, [3, 4, 5], context);
    }
    // Third Row Check
    else if (moves[6] != null && moves[6] == moves[7] && moves[6] == moves[8]) {
      showWinDialog(moves[6]!, [6, 7, 8], context);
    }
    // first column check
    else if (moves[0] != null && moves[0] == moves[3] && moves[0] == moves[6]) {
      showWinDialog(moves[0]!, [0, 3, 6], context);
    }

    // second column check
    else if (moves[1] != null && moves[1] == moves[4] && moves[1] == moves[7]) {
      showWinDialog(moves[1]!, [1, 4, 7], context);
    }

    // third column check
    else if (moves[2] != null && moves[2] == moves[5] && moves[2] == moves[8]) {
      showWinDialog(moves[2]!, [2, 5, 8], context);
    }
    // first Diagonal check
    else if (moves[0] != null && moves[0] == moves[4] && moves[0] == moves[8]) {
      showWinDialog(moves[0]!, [0, 4, 8], context);
    }
    // second Diagonal check
    else if (moves[2] != null && moves[2] == moves[4] && moves[2] == moves[6]) {
      showWinDialog(moves[2]!, [2, 4, 6], context);
    } else {
      if ((isFirstPress.indexOf(false) == -1)) {
        showWinDialog(Icons.square_foot, [], context, isDraw: true);
      }
      // showWinDialog(moves[2]!, context);
    }
  }

  void showWinDialog(
    IconData winer,
    List<int> winerIndex,
    BuildContext context, {
    bool isDraw = false,
  }) {
    setState(() {
      winnerCross = winerIndex;
    });

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          padding: EdgeInsets.all(30),
          height: 300,
          child: Column(
            children: [
              Text(
                "Game Over",
                style: myNewFontWhite(25),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.white54),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isDraw)
                    Icon(
                      winer,
                      size: 50,
                      color: winer == Icons.close
                          ? Color(0xffFFD447)
                          : Colors.pink,
                    ),
                  SizedBox(width: 20),
                  Text(isDraw ? "Draw Match" : "Won This game",
                      style: myNewFontWhite(15)),
                ],
              ),
              SizedBox(height: 30),
              MaterialButton(
                minWidth: 200,
                height: 55,
                color: Color(0xffFE654F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < moves.length; i++) {
                      moves[i] = null;
                    }
                    for (int i = 0; i < isFirstPress.length; i++) {
                      isFirstPress[i] = false;
                    }
                    winnerCross.clear();
                  });
                  Navigator.pop(context);
                },
                child: Text("Restart", style: myNewFontWhite(15)),
              )
            ],
          ),
        );
      },
    );
  }
}
