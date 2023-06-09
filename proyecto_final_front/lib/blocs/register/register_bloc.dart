import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:proyecto_final_front/model/models.dart';
import 'package:proyecto_final_front/model/user/register_response.dart';
import 'package:proyecto_final_front/model/user/register_user_request.dart';
import 'package:proyecto_final_front/repositories/repositories.dart';
import 'package:proyecto_final_front/rest/rest.dart';
import 'package:proyecto_final_front/services/user_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    _userService = GetIt.I.get<UserService>();
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
  }
  late UserService _userService;

  _onRegisterButtonPressed(RegisterButtonPressed event, Emitter<RegisterState> emit) async{
    emit(RegisterLoading());
    try{
      final user = await _userService.registerUser(event.request);
      emit(RegisterSucess(user: user));
    } on CustomException catch (e) {
      emit(RegisterFailure(error: e.message));
    }
  }
}
