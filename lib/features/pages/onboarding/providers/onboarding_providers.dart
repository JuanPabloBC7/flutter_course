import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider that manages the selected interests in the onboarding flow.
/// Stores a Set of selected interest names.
final selectedInterestsProvider = StateNotifierProvider<SelectedInterestsNotifier, Set<String>>((ref) {
  return SelectedInterestsNotifier();
});

class SelectedInterestsNotifier extends StateNotifier<Set<String>> {
  SelectedInterestsNotifier() : super({});

  void toggle(String interest) {
    if (state.contains(interest)) {
      state = {...state}..remove(interest);
    } else {
      state = {...state, interest};
    }
  }

  bool isSelected(String interest) => state.contains(interest);
}
