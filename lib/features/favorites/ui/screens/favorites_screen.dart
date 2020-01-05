import 'package:flutter/material.dart';
import 'package:lyrics/features/favorites/data/datasources/favorites_table_provider.dart';
import 'package:lyrics/features/song_search/ui/widgets/search_results_list.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SearchResultsList(
      futureSongs: FavoritesTableProvider.table.getAll(),
    );
  }
}