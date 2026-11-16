import 'package:daycheck/features/settings/data/app_settings.dart';
import 'package:daycheck/features/settings/data/settings_repository.dart';

class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository([this.settings = const AppSettings()]);

  AppSettings settings;

  @override
  Future<AppSettings> load() async => settings;

  @override
  Future<void> save(AppSettings value) async => settings = value;
}
