import 'package:flextras/flextras.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hmm_word/app/notifiers/game_notifier.dart';
import 'package:hmm_word/app/widgets/text_box.dart';

class TextBoxes extends ConsumerWidget {
  const TextBoxes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateNotifierProvider);
    // final gameStateNotifier = ref.watch(gameStateNotifierProvider.notifier);
    return Expanded(
      flex: 3,
      child: SeparatedColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        separatorBuilder: () => const SizedBox(height: 20),
        children: List.generate(
          5,
          (index) {
            return SeparatedRow(
              mainAxisAlignment: MainAxisAlignment.center,
              separatorBuilder: () => const SizedBox(width: 20),
              children: List.generate(
                5,
                (indexx) {
                  String word = gameState.tryValues[index];
                  List<String> letters =
                      word.isNotEmpty ? word.split('') : List.filled(5, '');
                  return TextBoxx(
                    color: word.length == 5,
                    keyText: indexx < letters.length ? letters[indexx] : '',
                    index: indexx,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
