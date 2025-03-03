# Jeu de Nim

Ce projet est une implémentation du jeu de Nim en Flutter.

## Description

Le jeu de Nim est très simple :  
- Il y a **20 allumettes** sur la table.  
- **2 joueurs** s'affrontent à tour de rôle sur le même appareil.  
- À chaque tour, un joueur peut retirer **1, 2 ou 3 allumettes**.  
- Le joueur qui retire la **dernière allumette** perd la partie.

## Fonctionnalités

- **Mode 2 joueurs** : les joueurs jouent à tour de rôle sur le même appareil.
- **Saisie des pseudos** : chaque joueur entre son pseudo en début de partie.
- **Interface graphique améliorée** : affichage des allumettes sous forme d'images sur fond jaune, avec des boutons en gris.
- **Indication du joueur actif** et affichage du nombre d'allumettes restantes.
- **Détection de la fin de partie** avec annonce du gagnant.
- **Option de relancer une nouvelle partie** après chaque fin de partie.

## Prérequis

- [Flutter SDK](https://flutter.dev/) installé.
- Un éditeur de code (Visual Studio Code, Android Studio, etc.).
- Un émulateur ou un appareil physique pour tester l'application.

## Installation

1. **Clonez le repository** :

   ```bash
   git clone https://github.com/gerardViet/jeu_de_nim.git

2. **Accédez au dossier du projet** :

   ```bash
   cd jeu_de_nim

3. **Installez les dépendances** :

   ```bash
   flutter pub get

4. **Lancez l'application** :

   ```bash
   flutter run

## Utilisation

Lancez l'application sur votre appareil ou émulateur.
Saisissez les pseudos des deux joueurs.
Appuyez sur "Démarrer la partie" pour commencer.
À tour de rôle, les joueurs retirent 1, 2 ou 3 allumettes.
La partie se termine lorsque la dernière allumette est retirée : le joueur ayant effectué ce coup perd.
Appuyez sur "Nouvelle Partie" pour recommencer.

