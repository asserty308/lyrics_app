import 'package:flutter/material.dart';
import 'package:flutter_core/i18n/context_localization.dart';

class SongSearchBar extends StatefulWidget {
  const SongSearchBar({
    Key key,
    this.onChanged,
  }) : super(key: key);

  final Function(String text) onChanged;

  @override
  _SongSearchBarState createState() => _SongSearchBarState();
}

class _SongSearchBarState extends State<SongSearchBar> {
  bool _hideClearIcon = true;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: context.localize('song_searchbar_hint'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: _hideClearIcon ? null : IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _clearText(),
          ),
          suffixIcon: _hideClearIcon ? null : IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _clearText(),
          )
        ),
        onChanged: (text) => _textChanged(text),
      ),
    );
  }

  _clearText() {
    _controller.clear();
    widget.onChanged('');

    setState(() {
      _hideClearIcon = true;
    });
  }

  _textChanged(String text) {
    if (text.isEmpty) {
      _clearText();
      return;
    }

    widget.onChanged(text);

    setState(() {
      _hideClearIcon = false;
    });
  }
}