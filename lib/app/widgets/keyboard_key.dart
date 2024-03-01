// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hmm_word/app/notifiers/game_notifier.dart';

class KeyboardKey extends ConsumerWidget {
  final String keyText;
  final void Function()? onPressed;
  const KeyboardKey({
    super.key,
    required this.keyText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateNotifierProvider);
    final gameStateNotifier = ref.watch(gameStateNotifierProvider.notifier);
    //  List<String> refLetters = gameState.refWord.split('');
    // gameStateNotifier.checkLetterPosition(keyText)

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 30,
        decoration: BoxDecoration(
          color: gameState.tryValues[0].length < 5
              ? null
              : switch (gameStateNotifier.checkLetterPosition(keyText)) {
                  'a' => Colors.green,
                  'b' => Colors.yellow.shade600,
                  'c' => Colors.grey,
                  _ => null
                },
          // gameStateNotifier.isLetterInSamePosition(keyText)
          //     ? Colors.green
          //     : null,
          border: Border.all(
            width: 1,
            color: Colors.blueGrey,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: keyText == '.'
              ? const Icon(
                  Icons.arrow_back,
                  size: 20,
                )
              : Text(
                  keyText,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
      ),
    );
  }
}
