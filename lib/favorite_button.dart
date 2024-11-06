import 'package:flutter/material.dart';
import 'user.dart';

class FavoriteButton extends StatefulWidget {
  final User user;
  final String articleTitle;
  final VoidCallback onToggleFavorite;

  FavoriteButton({
    required this.user,
    required this.articleTitle,
    required this.onToggleFavorite,
  });

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.user.favoriteArticles.contains(widget.articleTitle);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
        widget.onToggleFavorite();
      },
    );
  }
}
