import 'dart:math';

import 'package:brainburst/constants/colors.dart';
import 'package:flutter/material.dart';

enum Player { X, O, computer }

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  List<String> squares = List.generate(9, (_) => ''); // Initialize empty board
  Player currentPlayer = Player.X;

  void _handleTap(int index) {
    if (squares[index] == '' && _checkWinner() == '') {
      setState(() {
        squares[index] = currentPlayer
            .toString()
            .split('.')
            .last; // Get player symbol (X or O)
        currentPlayer = currentPlayer == Player.X ? Player.O : Player.X;
        if (currentPlayer == Player.O) {
          _computerMove();
        }
        String winner = _checkWinner();
        if (winner != '') {
          _updateWinnerMessage(winner);
        } else if (currentPlayer == Player.O) {
          _computerMove();
        }
      });
    }
  }

  String _checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (squares[i] == squares[i + 3] &&
          squares[i] == squares[i + 6] &&
          squares[i] != '') {
        return squares[i];
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (squares[i] == squares[i + 1] &&
          squares[i] == squares[i + 2] &&
          squares[i] != '') {
        return squares[i];
      }
    }

    // Check diagonals
    if (squares[0] == squares[4] &&
        squares[0] == squares[8] &&
        squares[0] != '') {
      return squares[0];
    }
    if (squares[2] == squares[4] &&
        squares[2] == squares[6] &&
        squares[2] != '') {
      return squares[2];
    }

    // Check for tie
    bool isTie = true;
    for (int i = 0; i < 9; i++) {
      if (squares[i] == '') {
        isTie = false;
        break;
      }
    }
    if (isTie) {
      return 'Tie';
    }

    return '';
  }

  void _resetGame() {
    setState(() {
      squares = List.generate(9, (_) => '');
      currentPlayer = Player.X;
      _updateWinnerMessage(''); // Clear winner message
    });
  }

  void _computerMove() {
    int? bestMoveIndex = _findBestMove(Player.O);
    if (bestMoveIndex != null) {
      _handleTap(bestMoveIndex);
    }
  }

  int? _findBestMove(Player player) {
    List<int> availableMoves = [];
    for (int i = 0; i < 9; i++) {
      if (squares[i] == '') {
        availableMoves.add(i);
      }
    }
    if (availableMoves.isEmpty) return null;
    return availableMoves[Random().nextInt(availableMoves.length)];
  }

  void _updateWinnerMessage(String winner) {
    setState(() {
      currentPlayer = Player.X; // Reset current player for next game
    });
  }

  Widget _buildSquare(int index) {
    return ElevatedButton(
      onPressed: () => _handleTap(index),
      style: ElevatedButton.styleFrom(
        backgroundColor: Clr.jade,
        foregroundColor: Colors.black,
        minimumSize: const Size(50, 50),
      ),
      child: Text(squares[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    String winner = _checkWinner();

    return Scaffold(
      backgroundColor: Clr.lightBlue,
      appBar: AppBar(
        backgroundColor: Clr.lightBlue,
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              winner == ''
                  ? 'Current Player: $currentPlayer'
                  : 'Winner: $winner',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare(0),
                const SizedBox(width: 10),
                _buildSquare(1),
                const SizedBox(width: 10),
                _buildSquare(2),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare(3),
                const SizedBox(width: 10),
                _buildSquare(4),
                const SizedBox(width: 10),
                _buildSquare(5),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare(6),
                const SizedBox(width: 10),
                _buildSquare(7),
                const SizedBox(width: 10),
                _buildSquare(8),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _resetGame,
              child: const Text('Reset Game'),
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Clr.lightCyan),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
