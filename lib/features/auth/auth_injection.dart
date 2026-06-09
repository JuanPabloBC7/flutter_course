import 'package:flutter_course/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_course/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_course/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_course/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_course/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:flutter_course/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_course/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_course/features/auth/domain/usecases/reset_password_usecase.dart';

/// Simple dependency injection container for the Auth feature.
///
/// Provides singleton instances of use cases wired with their dependencies.
/// In a larger app, this would be replaced by a DI framework like get_it.
class AuthInjection {
  AuthInjection._();

  // Data sources
  static final AuthRemoteDataSource _remoteDataSource = AuthRemoteDataSource();
  static final AuthLocalDataSource _localDataSource = AuthLocalDataSource();

  // Repository
  static final AuthRepository _repository = AuthRepositoryImpl(
    remoteDataSource: _remoteDataSource,
    localDataSource: _localDataSource,
  );

  // Use cases
  static LoginUseCase get loginUseCase => LoginUseCase(_repository);
  static LogoutUseCase get logoutUseCase => LogoutUseCase(_repository);
  static ResetPasswordUseCase get resetPasswordUseCase => ResetPasswordUseCase(_repository);
  static CheckSessionUseCase get checkSessionUseCase => CheckSessionUseCase(_repository);

  // Expose repository for advanced use cases
  static AuthRepository get repository => _repository;

  // Expose local data source for direct token management
  static AuthLocalDataSource get localDataSource => _localDataSource;
}
