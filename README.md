# BLOK Chantier

Application Flutter de commande de matériaux pour conducteurs de travaux .

## Lancer l'app

    git clone https://github.com/sidibeabdoulhafiz-cyber/blok_chantier.git
    cd blok_chantier
    flutter pub get
    flutter run

## Ce qui est fait

- Catalogue avec filtre par catégorie
- Détail produit avec choix de la quantité
- Panier : quantités modifiables, total en FCFA, choix du chantier, envoi de la commande (statut Reçue)
- Mes commandes : liste et détail avec suivi Reçue, Transmise, En livraison, Livrée, Facturée
- État partagé avec ChangeNotifier (provider)

## Ce qui n'est pas fait

- Pas de persistance : les commandes créées disparaissent au redémarrage
- Chantiers proposés = ceux des commandes existantes du JSON
- Pas de chargement HTTP (données dans assets/data.json)

## Ce qui m'a bloqué

- Installation de Flutter : flutter.bat était vide (0 octet). Réinstallation du SDK avec git clone et correction du Path.
- Réseau : échec DNS vers storage.googleapis.com. Résolu en utilisant mes données mobile.
- NDK Android : installé manuellement depuis le SDK Manager.
- pubspec.yaml : erreur d'indentation YAML, corrigée.
- Git : le dépôt distant contenait déjà un commit, push refusé au début, puis marqueurs de conflit dans le README à nettoyer.

## Outils d'IA

J'ai utilisé Claude pour structurer le projet et écrire le code. J'ai testé chaque écran et je peux expliquer et modifier le code.