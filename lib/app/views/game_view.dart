import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hmm_word/app/notifiers/game_notifier.dart';
import 'package:hmm_word/app/widgets/keyboard_widget.dart';
import 'package:hmm_word/app/widgets/text_boxes.dart';

class GameView extends ConsumerStatefulWidget {
  const GameView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameViewState();
}

class _GameViewState extends ConsumerState<GameView> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateNotifierProvider);
    final gameStateNotifier = ref.watch(gameStateNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('WRDL'),
        actions: [
          IconButton(
            onPressed: () {
              gameStateNotifier.reset();
            },
            icon: const Icon(
              Icons.punch_clock,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          const Column(
            children: [
              TextBoxes(),
              KeyboardWidget(),
            ],
          ),
          if (gameStateNotifier.wordFound || gameStateNotifier.gameOver)
            Center(
              child: Container(
                height: 300,
                width: 350,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 10,
                      offset: Offset(1, 1),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      gameStateNotifier.wordFound ? "Well Done!" : 'Game Over',
                      style: TextStyle(
                        color: gameStateNotifier.wordFound
                            ? Colors.green
                            : Colors.red,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'The word is "${gameState.refWord}"',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        gameStateNotifier.reset();
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// bool isWordInList(String targetWord, List<String> wordList) {
//   for (String word in wordList) {
//     if (word == targetWord) {
//       return true;
//     }
//   }
//   return false;
// }
