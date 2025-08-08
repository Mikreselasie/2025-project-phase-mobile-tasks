import 'package:ecommerce/core/usecases/usecase.dart';
import 'package:ecommerce/features/auth/domain/usecases/get_current_user.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_in_params.dart';
import 'package:ecommerce/features/auth/domain/usecases/log_out.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up.dart';
import 'package:ecommerce/features/auth/domain/usecases/sign_up_params.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_event.dart';
import 'package:ecommerce/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogIn loginUsecase;
  final SignUp registerUsecase;
  final GetCurrentUser getMeUsecase;
  final Logout logoutUsecase;
  bool isAuthLoaded = false;
  bool isAuthLoading = false;

  AuthBloc({
    required this.logoutUsecase,
    required this.loginUsecase,
    required this.registerUsecase,
    required this.getMeUsecase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<GetCurrentUserEvent>(_onGetMe);
    on<LogoutEvent>((event, emit) => _logout(emit));
    on<AuthLoadRequested>((event, emit) => _loadAuth(emit));
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    debugPrint('🔐 [AuthBloc] LoginEvent received for ${event.email}');
    emit(AuthLoading());

    final result = await loginUsecase(
      LogInParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        debugPrint('❌ Login failed: ${failure.message}');
        emit(AuthFailure(failure.message));
      },
      (_) {
        debugPrint('✅ Login successful, token saved');
        emit(AuthTokenSaved());
      },
    );
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    debugPrint('📝 [AuthBloc] RegisterEvent received for ${event.email}');
    emit(AuthLoading());

    final result = await registerUsecase(
      SignUpParams(
        email: event.email,
        password: event.password,
        userName: event.name,
      ),
    );

    result.fold(
      (failure) {
        debugPrint('❌ Register failed: ${failure.message}');
        emit(AuthFailure(failure.message));
      },
      (user) {
        debugPrint('✅ Register successful: ${user.email}');
        emit(AuthSuccess(user));
      },
    );
  }

  Future<void> _onGetMe(
    GetCurrentUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('👤 [AuthBloc] GetCurrentUserEvent triggered');
    emit(AuthLoading());

    final result = await getMeUsecase(NoParams());

    result.fold(
      (failure) {
        debugPrint('❌ Failed to fetch user: ${failure.message}');
        emit(AuthFailure(failure.message));
      },
      (user) {
        debugPrint('✅ User loaded: ${user.email}');
        emit(AuthSuccess(user));
      },
    );
  }

  Future<void> _logout(Emitter<AuthState> emit) async {
    debugPrint('🚪 [AuthBloc] LogoutEvent triggered');
    emit(AuthLoading());

    // Optional: call logoutUsecase() if it contains logout logic
    emit(AuthLoggedOut());
    emit(AuthInitial());
  }

  Future<void> _loadAuth(Emitter<AuthState> emit) async {
    debugPrint('🔄 [AuthBloc] AuthLoadRequested');

    if (isAuthLoading) {
      debugPrint('⚠️ Auth is already loading, skipping...');
      return;
    }

    if (isAuthLoaded) {
      debugPrint('✅ Auth already loaded, skipping...');
      return;
    }

    isAuthLoading = true;
    emit(AuthLoading());

    final result = await getMeUsecase(NoParams());

    result.fold(
      (failure) {
        debugPrint('❌ Auth loading failed: ${failure.message}');
        emit(AuthLoadFailure(failure.message));
        isAuthLoading = false;
      },
      (user) {
        debugPrint('✅ Auth loaded: ${user.email}');
        emit(AuthLoadSuccess(user));
        isAuthLoaded = true;
        isAuthLoading = false;
      },
    );
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('📝 [AuthBloc] AuthRegisterRequested: ${event.email}');
    emit(AuthLoading());

    final result = await registerUsecase(
      SignUpParams(
        email: event.email,
        password: event.password,
        userName: event.name,
      ),
    );

    result.fold(
      (failure) {
        debugPrint('❌ Auth register failed: ${failure.message}');
        emit(AuthRegisterFailure(failure.message));
      },
      (user) {
        debugPrint('✅ Auth register success: ${user.email}');
        emit(AuthRegisterSuccess(user));
      },
    );
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('🔐 [AuthBloc] AuthLoginRequested: ${event.email}');
    emit(AuthLoading());

    final result = await loginUsecase(
      LogInParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        debugPrint('❌ Auth login failed: ${failure.message}');
        emit(AuthLoginFailure(failure.message));
      },
      (user) {
        debugPrint('✅ Auth login success: ${user.email}');
        emit(AuthLoginSuccess(user));
      },
    );
  }
}
