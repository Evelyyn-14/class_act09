import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card Organizer',
      home: const MyHomePage(title: 'Card Organizer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FoldersScreen(),
      ),
    );
  }
}

class FoldersScreen extends StatelessWidget {
  final List<String> folders = ['Hearts', 'Spades', 'Diamonds', 'Clubs'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: folders.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.folder),
          title: Text(folders[index]),
          subtitle: Text('Number of cards: 0'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CardsScreen(folderName: folders[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class CardsScreen extends StatefulWidget {
  final String folderName;

  const CardsScreen({super.key, required this.folderName});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
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
        title: Text('${widget.folderName} Cards'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          return Card(
            child: GridTile(
              child: Icon(Icons.image),
              footer: GridTileBar(
                title: Text('Card $index', style: TextStyle(color: Colors.black)),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text('Add'),
                      value: 'add',
                    ),
                    PopupMenuItem(
                      child: Text('Update'),
                      value: 'update',
                    ),
                    PopupMenuItem(
                      child: Text('Delete'),
                      value: 'delete',
                    ),
                  ],
                  onSelected: (value) {
                    // Handle menu actions
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}