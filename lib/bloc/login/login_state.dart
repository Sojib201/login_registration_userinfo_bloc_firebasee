import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {}

class SignInInitial extends SignInState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInLoading extends SignInState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInSuccess extends SignInState {
  final String message;

  SignInSuccess(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class SignInFailure extends SignInState {
  final String error;

  SignInFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class signFailure extends SignInState{
  final String code;

  signFailure(this.code);

  @override
  // TODO: implement props
  List<Object?> get props => [code];

}
