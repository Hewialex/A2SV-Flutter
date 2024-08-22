import 'package:equatable/equatable.dart';
import 'package:layout_in_flutter/feature/authentication/domain/entity/user_entity.dart';

// Abstract base class for all user events
abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Event for signing in
class SignInEvent extends UserEvent {
  final UserEntity user;

  SignInEvent(this.user);
}

// Event for signing up
class SignUpEvent extends UserEvent {
  final UserEntity user;

  SignUpEvent(this.user);
}

// Event for fetching user details
class GetMeEvent extends UserEvent {}


