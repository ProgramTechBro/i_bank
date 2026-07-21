import 'package:injectable/injectable.dart';
import '../../../domain/entities/language_entity.dart';

abstract class SettingsLocalDatasource {
  Future<List<LanguageEntity>> getLanguages();
}

@LazySingleton(as: SettingsLocalDatasource)
class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {
  @override
  Future<List<LanguageEntity>> getLanguages() async {
    return const [
      LanguageEntity(code: 'VN', name: 'Vietnamese'),
      LanguageEntity(code: 'FR', name: 'Frech'),
      LanguageEntity(code: 'GB', name: 'English'),
      LanguageEntity(code: 'JP', name: 'Japanese'),
      LanguageEntity(code: 'PT', name: 'Portuguese'),
      LanguageEntity(code: 'CN', name: 'China'),
      LanguageEntity(code: 'KR', name: 'Korea'),
      LanguageEntity(code: 'NI', name: 'Nicaragua'),
      LanguageEntity(code: 'RU', name: 'Russia'),
      LanguageEntity(code: 'PT', name: 'Portuguese'),
      LanguageEntity(code: 'FR', name: 'Frech'),
    ];
  }
}
