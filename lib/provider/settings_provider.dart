// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_board_v2/models/settings.dart';
import 'package:awesome_board_v2/repository/settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final allSettingsProvider = StateNotifierProvider<SettingsNotifier, Settings>(
    (ref) => SettingsNotifier(SettingsRepositorySharedPrefs()));

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier(this.repository) : super(Settings.defaultSettings);
  final SettingsRepository repository;
  Future<bool> saveToDisk() async {
    return await repository.saveSettings(state);
  }

  void loadFromDisk() async {
    state = await repository.fetchSettings();
  }

  void updateSmartModeInCreate(bool value) {
    state = state.copyWith(smartModeInCreateMode: value);
  }
}
