import 'package:bloc/bloc.dart';
import 'package:layout_in_flutter/core/error/failure.dart';
import 'package:layout_in_flutter/feature/authentication/domain/usecase/getme_usecase.dart';
import 'package:layout_in_flutter/feature/authentication/domain/usecase/signin_usecase.dart';
import 'package:layout_in_flutter/feature/authentication/domain/usecase/signup_usecase.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_event.dart';
import 'package:layout_in_flutter/feature/authentication/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SigninUsecase signInUseCase;
  final SignupUsecase signUpUseCase;
  final GetmeUsecase getMeUseCase;


  UserBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getMeUseCase,

  }) : super(UserInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(UserLoading());
      final result = await signInUseCase.execute(event.user);
      result.fold(
        (failure) => emit(UserError(_mapFailureToMessage(failure))),
        (user) => emit(UserLoaded(user)),
      );
    });

    on<SignUpEvent>((event, emit) async {
      emit(UserLoading());
      final result = await signUpUseCase.execute(event.user);
      print('it is working');
      result.fold(
        (failure) => emit(UserError(_mapFailureToMessage(failure))),
        (user) => emit(UserLoaded(user)),
      );
    });

    on<GetMeEvent>((event, emit) async {
      emit(UserLoading());
      
      final result = await getMeUseCase.execute();
      result.fold(
        (failure) => emit(UserError(_mapFailureToMessage(failure))),
        (user) => emit(UserLoaded(user)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case ConnectionFailure:
        return 'Connection Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
