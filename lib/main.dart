import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class CardsScreen extends StatelessWidget {
  final String folderName;

  CardsScreen({required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$folderName Cards'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 10, 
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
