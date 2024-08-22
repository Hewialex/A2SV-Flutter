import 'package:equatable/equatable.dart';
import 'package:layout_in_flutter/feature/authentication/domain/entity/user_entity.dart';

// Abstract base class for all user states
abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state when the UserBloc/Cubit is first created
class UserInitial extends UserState {}

// State when a user-related operation is in progress (e.g., signing in, signing up)
class UserLoading extends UserState {}

// State when a user-related operation is successfully completed
class UserLoaded extends UserState {
  final UserEntity user;

  UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

// State when there is an error in a user-related operation
class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}

// Optional: State when a user is logged out
class UserLoggedOut extends UserState {}
