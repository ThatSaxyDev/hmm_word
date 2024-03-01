import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hmm_word/app/notifiers/game_notifier.dart';
import 'package:hmm_word/app/widgets/keyboard_key.dart';

class KeyboardWidget extends ConsumerWidget {
  const KeyboardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final gameState = ref.watch(gameStateNotifierProvider);
    final gameStateNotifier = ref.watch(gameStateNotifierProvider.notifier);
    return Expanded(
      flex: 2,
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: List.generate(
            keyboardLayout.length,
            (index) => Padding(
              padding: EdgeInsets.symmetric(
                      horizontal: switch (index) {
                0 => 10,
                1 => 30,
                _ => 50,
              })
                  .copyWith(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  keyboardLayout[index].length,
                  (indexx) => KeyboardKey(
                    keyText: keyboardLayout[index][indexx],
                    onPressed: () {
                      if (gameStateNotifier.gameOver ||
                          gameStateNotifier.wordFound) {
                      } else {
                        if (keyboardLayout[index][indexx] == '.') {
                          gameStateNotifier.backspace();
                        } else {
                          gameStateNotifier.input(
                              input: keyboardLayout[index][indexx]);
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final List<List<String>> keyboardLayout = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Z', 'X', 'C', 'V', 'B', 'N', 'M', '.']
];
