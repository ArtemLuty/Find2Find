import 'package:find_me/caches/preferences.dart';
import 'package:find_me/data/services/firebase_messaging.dart';
import 'package:find_me/data/services/registration_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Preferences());
  locator.registerLazySingleton(() => FirebaseMessagingService());
  locator.registerLazySingleton(() => RegistrationService());
}
