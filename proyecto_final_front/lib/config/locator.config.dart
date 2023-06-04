// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:proyecto_final_front/repositories/authentication_repository.dart'
    as _i4;
import 'package:proyecto_final_front/repositories/chat_repository.dart' as _i6;
import 'package:proyecto_final_front/repositories/post_repository.dart' as _i8;
import 'package:proyecto_final_front/repositories/user_repository.dart' as _i5;
import 'package:proyecto_final_front/rest/rest_client.dart' as _i3;
import 'package:proyecto_final_front/services/authentication_service.dart'
    as _i11;
import 'package:proyecto_final_front/services/chat_service.dart' as _i7;
import 'package:proyecto_final_front/services/post_service.dart' as _i9;
import 'package:proyecto_final_front/services/user_service.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.RestAuthenticatedClient>(_i3.RestAuthenticatedClient());
    gh.singleton<_i3.RestClient>(_i3.RestClient());
    gh.singleton<_i4.AuthenticationRepository>(_i4.AuthenticationRepository());
    gh.singleton<_i5.UserRepository>(_i5.UserRepository());
    gh.singleton<_i6.ChatRepository>(_i6.ChatRepository());
    gh.singleton<_i7.ChatService>(_i7.ChatService());
    gh.singleton<_i8.PostRepository>(_i8.PostRepository());
    gh.singleton<_i9.PostService>(_i9.PostService());
    gh.singleton<_i10.UserService>(_i10.UserService());
    gh.singleton<_i11.JwtAuthenticationService>(
        _i11.JwtAuthenticationService());
    return this;
  }
}
