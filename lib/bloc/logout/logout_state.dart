import 'package:equatable/equatable.dart';

abstract class LogoutState extends Equatable {}

class AppStateLoggedOut extends LogoutState {
  final bool isLoading;
  final bool successful;

  AppStateLoggedOut({required this.isLoading, required this.successful});

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, successful];
}
