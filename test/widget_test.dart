import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jeu_de_nim/main.dart';

void main() {
  testWidgets(
      'Navigation de HomePage vers GamePage avec saisie valide des pseudos',
      (WidgetTester tester) async {
    // Construction de l'application.
    await tester.pumpWidget(MyApp());

    // Champs de texte avec leur label.
    final player1Field = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.labelText == 'Pseudo du Joueur 1');
    final player2Field = find.byWidgetPredicate((widget) =>
        widget is TextField &&
        widget.decoration?.labelText == 'Pseudo du Joueur 2');

    expect(player1Field, findsOneWidget);
    expect(player2Field, findsOneWidget);

    // Saisie de noms valides.
    await tester.enterText(player1Field, 'Alice');
    await tester.enterText(player2Field, 'Bob');

    // Démarrage de la partie.
    final startButton = find.text('Démarrer la partie');
    expect(startButton, findsOneWidget);
    await tester.tap(startButton);
    await tester.pumpAndSettle();

    // Vérification que la GamePage est affichée . Contrôle du texte initial.
    expect(find.text('Il reste 20 allumettes'), findsOneWidget);
  });

  testWidgets(
      'GamePage: Vérification de la logique de jeu - un coup réduit le nombre d\'allumettes',
      (WidgetTester tester) async {
    // Construction de la GamePage  avec des pseudos tests.
    await tester.pumpWidget(
        MaterialApp(home: GamePage(player1: 'Alice', player2: 'Bob')));

    // Vérifier que le nombre initial d'allumettes est bien affiché.
    expect(find.text('Il reste 20 allumettes'), findsOneWidget);

    // Appuyer sur le bouton "Prendre 1".
    final prendre1Button = find.text('Prendre 1');
    expect(prendre1Button, findsOneWidget);
    await tester.tap(prendre1Button);
    await tester.pumpAndSettle();

    // Le nombre d'allumettes devrait passer de 20 à 19.
    expect(find.text('Il reste 19 allumettes'), findsOneWidget);
  });

  testWidgets('GamePage: Fin de partie et redémarrage',
      (WidgetTester tester) async {
    // Construction de la GamePage directement avec des pseudos tests.
    await tester.pumpWidget(
        MaterialApp(home: GamePage(player1: 'Alice', player2: 'Bob')));

    // Simulation des coups jusqu'à la fin de la partie.
    // On joue toujours "Prendre 1" jusqu'à épuisement des allumettes.
    int moves = 0;
    while (moves < 20) {
      final prendre1Button = find.text('Prendre 1');
      if (prendre1Button.evaluate().isEmpty) break;
      await tester.tap(prendre1Button);
      await tester.pumpAndSettle();
      moves++;
    }

    // Vérification de la fin du jeu en cherchant le message de fin.
    expect(find.textContaining('Fin de partie'), findsOneWidget);

    // Bouton "Nouvelle Partie".
    final nouvellePartieButton = find.text('Nouvelle Partie');
    expect(nouvellePartieButton, findsOneWidget);
    await tester.tap(nouvellePartieButton);
    await tester.pumpAndSettle();

    // Réinitialisation du nombre d'allumettes à 20.
    expect(find.text('Il reste 20 allumettes'), findsOneWidget);
  });
}
