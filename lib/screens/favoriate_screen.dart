import 'package:flutter/material.dart';
import '../data/favorites_manager.dart';
import '../models/attraction.dart';
import '../widgets/attraction_card.dart';

class FavoriateScreen extends StatelessWidget {
  const FavoriateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Attraction>>(
      valueListenable: FavoritesManager.favorites,
      builder: (context, favs, _) {
        if (favs.isEmpty) {
          return const Center(child: Text('No favorites yet'));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: favs.length,
          itemBuilder: (context, i) => AttractionCard(attraction: favs[i]),
        );
      },
    );
  }
}