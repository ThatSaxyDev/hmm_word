// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameStateNotifierProvider =
    NotifierProvider<GameStateNotifier, GameState>(() {
  return GameStateNotifier();
});

class GameStateNotifier extends Notifier<GameState> {
  @override
  GameState build() => const GameState(
        refWord: 'TODAY',
      );

  void reset() {
    state = state.copyWith(tryValues: const ['', '', '', '', '']);
  }

  void backspace() {
    for (int i = state.tryValues.length - 1; i >= 0; i--) {
      String tryValue = state.tryValues[i];
      if (tryValue.isNotEmpty && tryValue.length != 5) {
        List<String> updatedTryValues = List<String>.from(state.tryValues);
        updatedTryValues[i] = tryValue.substring(0, tryValue.length - 1);
        state = state.copyWith(tryValues: updatedTryValues);
        return;
      }
    }
  }

  void input({required String input}) {
    for (int i = 0; i < state.tryValues.length; i++) {
      if (state.tryValues[i].length < 5) {
        List<String> updatedTryValues = List<String>.from(state.tryValues);
        updatedTryValues[i] += input;
        state = state.copyWith(tryValues: updatedTryValues);
        break;
      }
    }
  }

  bool get wordFound => _isWordInList();

  bool get gameOver => _gameOver();

  bool _isWordInList() {
    for (String word in state.tryValues) {
      if (word == state.refWord) {
        return true;
      }
    }
    return false;
  }

  bool _gameOver() {
    if (state.tryValues[4].length == 5) {
      return true;
    }
    return false;
  }

  bool isLetterInSamePosition(String letter) {
    // Iterate over each position in the words
    for (int position = 0; position < state.refWord.length; position++) {
      // Check if the letter is in the same position in the refWord
      if (state.refWord[position] == letter) {
        // Check if the letter is in the same position in at least one of the tryValues
        for (String tryValue in state.tryValues) {
          if (position < tryValue.length && tryValue[position] == letter) {
            return true;
          }
        }
      }
    }
    return false;
  }

  bool isLetterInTryValuesOnly(String letter) {
    // Check if the letter is present in any of the tryValues but not in the refWord
    for (String tryValue in state.tryValues) {
      if (tryValue.contains(letter) && !state.refWord.contains(letter)) {
        return true;
      }
    }
    return false;
  }

  bool isLetterInWrongPosition(String letter) {
    // Check if the letter occurs in the refWord and at least one of the tryValues, but not in the correct position
    for (int i = 0; i < state.refWord.length; i++) {
      if (state.refWord[i] == letter) {
        // Check if the letter is in the same position in at least one of the tryValues
        bool inCorrectPosition = false;
        for (String tryValue in state.tryValues) {
          if (tryValue.length > i && tryValue[i] == letter) {
            inCorrectPosition = true;
            break;
          }
        }
        // If the letter is not in the correct position in any tryValue, return true
        if (!inCorrectPosition) {
          return true;
        }
      }
    }
    return false;
  }

  String checkLetterPosition(String letter) {
    String refWord =
        state.refWord; // Assuming you have a property named refWord
    List<String> tryValues =
        state.tryValues; // Assuming you have a property named tryValues

    // Check if the letter is in the same position in the refWord and at least one of the tryValues
    for (int position = 0; position < refWord.length; position++) {
      if (refWord[position] == letter) {
        // Check if the letter is in the same position in at least one of the tryValues
        for (String tryValue in tryValues) {
          if (position < tryValue.length && tryValue[position] == letter) {
            return 'a';
          }
        }
        return 'b';
      }
    }

    // Check if the letter is present in any of the tryValues but not in the refWord
    for (String tryValue in tryValues) {
      if (tryValue.contains(letter) && !refWord.contains(letter)) {
        return 'c';
      }
    }

    return '';
  }
}

class GameState {
  final String refWord;
  final List<String> tryValues;

  const GameState({
    this.refWord = '',
    this.tryValues = const ['', '', '', '', ''],
  });

  GameState copyWith({
    String? refWord,
    List<String>? tryValues,
  }) {
    return GameState(
      refWord: refWord ?? this.refWord,
      tryValues: tryValues ?? this.tryValues,
    );
  }
}
