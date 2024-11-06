import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final List<Color> colors;
  final String text;
  final Function onPressed;
  const CustomGradientButton({
    super.key,
    required this.colors,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colors),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(18),
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => onPressed(),
            child: Text(text),
          )
        ],
      ),
    );
  }
}
