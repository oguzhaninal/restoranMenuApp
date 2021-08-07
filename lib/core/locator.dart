import 'package:get_it/get_it.dart';
import 'package:sambaposapp/core/services/menuServices.dart';

var getIt = GetIt.asNewInstance();

void setUpLocators() {
  getIt.registerLazySingleton(() => MenuServices());
}
