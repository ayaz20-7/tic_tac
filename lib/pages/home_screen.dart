import 'package:flutter/material.dart';
import 'package:tic_tac/widget/alert_dialog_box.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int scoreX = 0;
  int scoreO = 0;
  bool turnOfO = true;
  int filledBoxes = 0;
  final List<String> xOrOList = ['', '', '', '', '', '', '', '', '',];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              _clearBoard();
            },
          )
        ],
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: [
          _buildPointsTable(),
          _buildGrid(),
          _newMatch(),
          _buildTurn(),
        ],
      ),
    );
  }

Widget _buildPointsTable(){
  return Expanded(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Column(
            children: [
              const Text(
                'Player O',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                scoreO.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(
            20.0,
          ),
          child: Column(
            children: [
              const Text(
                'Player X',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                scoreX.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    ),
  );
}


  Widget _buildGrid() {
    return Expanded(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _tapped(index);
                },
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Text(
                      xOrOList[index],
                      style: TextStyle(
                        color:
                            xOrOList[index] == 'x' ? Colors.black : Colors.red,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }


  Widget _newMatch() {
    return GestureDetector(
      onTap: _resetScore,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.play_arrow,
              color: Colors.black,
            ),
            Text(
              "New Match",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildTurn() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          turnOfO ? 'Turn of O' : 'Turn of X',
          style: const TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
    );
  }



  void _resetScore() {
    setState(() {
      scoreX = 0;
      scoreO = 0;
      _clearBoard();
    });
  }

  void _tapped(int index) {
    setState(() {
      if (turnOfO && xOrOList[index] == '') {
        xOrOList[index] = 'o';
        filledBoxes += 1;
      } else if (!turnOfO && xOrOList[index] == '') {
        xOrOList[index] = 'x';
        filledBoxes += 1;
      }

      turnOfO = !turnOfO;
      _checkTheWinner();
    });
  }

  void _checkTheWinner() {
    // check first row
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != '') {
      _showAlertDialog('Winner', xOrOList[0]);
      return;
    }

    // check second row
    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != '') {
      _showAlertDialog('Winner', xOrOList[3]);
      return;
    }

    // check third row
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != '') {
      _showAlertDialog('Winner', xOrOList[6]);
      return;
    }

    // check first column
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != '') {
      _showAlertDialog('Winner', xOrOList[0]);
      return;
    }

    // check second column
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != '') {
      _showAlertDialog('Winner', xOrOList[1]);
      return;
    }

    // check third column
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != '') {
      _showAlertDialog('Winner', xOrOList[2]);
      return;
    }

    // check diagonal
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      _showAlertDialog('Winner', xOrOList[0]);
      return;
    }

    // check diagonal
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      _showAlertDialog('Winner', xOrOList[2]);
      return;
    }

    if (filledBoxes == 9) {
      _showAlertDialog('Draw', '');
    }
  }

  void _showAlertDialog(String title, String winner) {
    showAlertDialog(
        context: context,
        title: title,
        content: winner == ''
            ? 'The match ended in a draw'
            : 'The winner is ${winner.toUpperCase()}',
        defaultActionText: 'OK',
        onOkPressed: () {
          _clearBoard();
          Navigator.of(context).pop();
        });

    if (winner == 'o') {
      scoreO += 1;
    } else if (winner == 'x') {
      scoreX += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        xOrOList[i] = '';
      }
    });

    filledBoxes = 0;
  }
}


