import 'package:flutter/material.dart';

class SongSearchBar extends StatelessWidget {
  const SongSearchBar({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final Function(String text) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Artist - Song',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onChanged: (text) => onChanged(text),
      ),
    );
  }
}