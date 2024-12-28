import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {}

class PerformSignIn extends SignInEvent {
  final String email;
  final String password;

  PerformSignIn(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
