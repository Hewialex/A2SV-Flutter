import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class UploadFailure extends Failure {
  const UploadFailure(String message) : super(message);
}


class ServerFailure extends Failure{
  ServerFailure(super.message);
}

class CacheFailure extends Failure{
  CacheFailure(super.message);
}

class ConnectionFailure extends Failure{
  ConnectionFailure(super.message);
  
}
class NetworkFailure extends Failure{
  NetworkFailure(super.message);
  
}

class UnauthorizedFailure extends Failure{
  UnauthorizedFailure(super.message);
  
}