import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CardScreenWidget(),
    );
  }
}

class CardScreenWidget extends StatefulWidget {
  const CardScreenWidget({super.key});

  @override
  State<CardScreenWidget> createState() => _CardScreenWidgetState();
}

class _CardScreenWidgetState extends State<CardScreenWidget> {
  final List<String> _cards = [];

  void _addCard() {
    setState(() {
      if (_cards.length >= 6) {
        _showDialog("Error", "This folder can only hold 6 cards.");
      } else {
        _cards.add("Card ${_cards.length + 1}");
        if (_cards.length < 3) {
          _showDialog("Warning", "You need at least 3 cards in this folder.");
        }
      }
    });
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Folder"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
    );
  }
}