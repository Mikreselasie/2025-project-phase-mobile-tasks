import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/auth/domain/usecases/get_current_user.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in_params.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up_params.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogIn loginUsecase;
  final SignUp registerUsecase;
  final GetCurrentUser getMeUsecase;

  AuthBloc({
    required this.loginUsecase,
    required this.registerUsecase,
    required this.getMeUsecase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<GetCurrentUserEvent>(_onGetMe);
    on<LogoutEvent>((event, emit) => _logout(emit));
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUsecase(
      LogInParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthTokenSaved()),
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await registerUsecase(
      SignUpParams(
        email: event.email,
        password: event.password,
        userName: event.name,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onGetMe(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await getMeUsecase(NoParams());
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _logout(Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Implement logout logic here, if needed
    emit(AuthLoggedOut());
    emit(AuthInitial());
  }
}
