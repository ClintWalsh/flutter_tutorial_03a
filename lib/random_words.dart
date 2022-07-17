import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
} // RandomWords

class RandomWordsState extends State<RandomWords> {
  final _randomWordPairs = <WordPair>[];
  final _savedWordPairs = Set<WordPair>();

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if(item.isOdd) return Divider();

        final index = item ~/ 2;

        if(index >= _randomWordPairs.length) {
          _randomWordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randomWordPairs[index]);
      }, // itemBuilder
    ); // ListView
  } //_buildList

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedWordPairs.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: TextStyle(
          fontSize: 18.0,
        ) // TextStyle
      ), // Text
      trailing: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null
      ), // trialing: Icon
      onTap: () {
        setState(() {
          if(alreadySaved) {
            _savedWordPairs.remove(pair);
          }
          else {
            _savedWordPairs.add(pair);
          } 
        }); // setState
      } // onTap
    ); // ListTitle
  } // _buildRow

  void _pushedSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _savedWordPairs.map((WordPair pair) {
            return ListTile(
              title: Text(pair.asPascalCase,
                style: TextStyle(
                  fontSize: 16.0,
                ) // TextStyle
              ) // title: Text
            ); // ListTile
          }); // map
          
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList(); // divideTiles

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved WordPairs'),
            ), // AppBar
            body: ListView(children: divided),
          ); // Scaffold
        } // builder
      ) // MaterialPageRoute
    ); // Navigator
  } // _pushedSaved 

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPair Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushedSaved
          ), // IconButton
        ], // actions: Widget
      ), // AppBar
      body: _buildList()
    ); // Scaffold
  } // build
} // RandomWordsState
