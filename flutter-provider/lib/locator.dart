import 'package:get_it/get_it.dart';
import 'package:provider_example/services/api.dart';
import 'package:provider_example/services/authentication_service.dart';
import 'package:provider_example/ui/views/Home/home_model.dart';
import 'package:provider_example/ui/views/Login/login_model.dart';

GetIt locator = GetIt();

// jangan lupa untuk mendaftarkan semua models setiap page disini
void setupLocator() { 
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());

  locator.registerFactory(() => LoginModel());  
  locator.registerFactory(() => HomeModel());
}