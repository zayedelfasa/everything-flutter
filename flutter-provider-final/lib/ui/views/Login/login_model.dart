import 'package:provider_example/core/ViewModels/base_model.dart';
import 'package:provider_example/enums/viewstate.dart';
import 'package:provider_example/locator.dart';
import 'package:provider_example/services/authentication_service.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String userIdText) async {
    setState(ViewState.Busy);

    var userId = int.tryParse(userIdText);

    // bukan angka
    if (userId == null) {
      errorMessage = "Input yang dimasukkan bukan angka";
      setState(ViewState.Idle);
      return false;
    }

    var success = await _authenticationService.login(userId);

    // code to handle potential error here too..
    setState(ViewState.Idle);
    return success;
  }
}
