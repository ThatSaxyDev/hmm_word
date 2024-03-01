// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hmm_word/app/notifiers/game_notifier.dart';

class TextBoxx extends ConsumerWidget {
  final String keyText;
  final int index;
  final bool color;
  const TextBoxx({
    super.key,
    required this.keyText,
    required this.index,
    this.color = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateNotifierProvider);
    List<String> refLetters = gameState.refWord.split('');
    Color textColor = !color
        ? Colors.black
        : refLetters[index] == keyText || gameState.refWord.contains(keyText)
            ? Colors.white
            : Colors.black;

    Color backColor = refLetters[index] == keyText && color
        ? Colors.green
        : gameState.refWord.contains(keyText) && keyText.isNotEmpty && color
            ? Colors.yellow.shade600
            : color
                ? Colors.grey
                : Colors.white;

    Color backkColor = refLetters[index] == keyText && color
        ? Colors.green
        : gameState.refWord.contains(keyText) && keyText.isNotEmpty && color
            ? Colors.yellow.shade600
            : Colors.blueGrey;
    return Container(
      height: 60,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: backkColor,
        ),
        borderRadius: BorderRadius.circular(7),
        color: backColor,
      ),
      child: Center(
        child: keyText == '.'
            ? const Icon(
                Icons.arrow_back,
                size: 20,
              )
            : Text(
                keyText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }
}
