import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/// L'application racine.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeu de Nim',
      theme: ThemeData(
        // Fond de l'application en jaune (ton doux)
        scaffoldBackgroundColor: Colors.yellow[100],
        // Thème global pour les ElevatedButton : fond gris et texte noir
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            foregroundColor: Colors.black,
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

/// La page d'accueil permet aux deux joueurs de saisir leur pseudo.
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _player1Controller = TextEditingController();
  final _player2Controller = TextEditingController();

  @override
  void dispose() {
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }

  void _startGame() {
    String player1 = _player1Controller.text.trim();
    String player2 = _player2Controller.text.trim();
    if (player1.isEmpty || player2.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Veuillez entrer les pseudos pour les deux joueurs')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(player1: player1, player2: player2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu de Nim - Accueil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _player1Controller,
              decoration: InputDecoration(labelText: 'Pseudo du Joueur 1'),
            ),
            TextField(
              controller: _player2Controller,
              decoration: InputDecoration(labelText: 'Pseudo du Joueur 2'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startGame,
              child: Text('Démarrer la partie'),
            ),
          ],
        ),
      ),
    );
  }
}

/// La page de jeu gère la partie de Nim.
class GamePage extends StatefulWidget {
  final String player1;
  final String player2;

  GamePage({required this.player1, required this.player2});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _remainingMatches = 20;
  int _currentPlayerIndex = 0;
  late List<String> _players;
  String _gameStatus = '';

  @override
  void initState() {
    super.initState();
    _players = [widget.player1, widget.player2];
    _gameStatus = "C'est le tour de ${_players[_currentPlayerIndex]}";
  }

  void _makeMove(int matchesToTake) {
    if (_remainingMatches < matchesToTake) return;

    setState(() {
      _remainingMatches -= matchesToTake;
      if (_remainingMatches == 0) {
        String winner = _players[(_currentPlayerIndex + 1) % 2];
        _gameStatus = "Fin de partie ! Le gagnant est $winner.";
      } else {
        _currentPlayerIndex = (_currentPlayerIndex + 1) % 2;
        _gameStatus = "C'est le tour de ${_players[_currentPlayerIndex]}";
      }
    });
  }

  void _restartGame() {
    setState(() {
      _remainingMatches = 20;
      _currentPlayerIndex = 0;
      _gameStatus = "C'est le tour de ${_players[_currentPlayerIndex]}";
    });
  }

  /// Construit l'affichage des allumettes sous forme d'images.
  Widget _buildMatches() {
    List<Widget> matchWidgets = [];
    for (int i = 0; i < _remainingMatches; i++) {
      matchWidgets.add(
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset(
            'assets/images/match.png',
            width: 30,
            height: 60,
          ),
        ),
      );
    }
    return Wrap(
      alignment: WrapAlignment.center,
      children: matchWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool gameEnded = _remainingMatches == 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Jeu de Nim'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Il reste $_remainingMatches allumettes',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            _buildMatches(),
            SizedBox(height: 20),
            Text(
              _gameStatus,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            if (!gameEnded)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed:
                        _remainingMatches >= 1 ? () => _makeMove(1) : null,
                    child: Text('Prendre 1'),
                  ),
                  ElevatedButton(
                    onPressed:
                        _remainingMatches >= 2 ? () => _makeMove(2) : null,
                    child: Text('Prendre 2'),
                  ),
                  ElevatedButton(
                    onPressed:
                        _remainingMatches >= 3 ? () => _makeMove(3) : null,
                    child: Text('Prendre 3'),
                  ),
                ],
              ),
            if (gameEnded)
              ElevatedButton(
                onPressed: _restartGame,
                child: Text('Nouvelle Partie'),
              ),
          ],
        ),
      ),
    );
  }
}
