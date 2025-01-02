import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {}

class SignUpInitial extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpLoading extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignUpSuccess extends RegistrationState {
  final String message;

  SignUpSuccess(
    this.message,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class SignUpFailure extends RegistrationState {
  final String error;
  //final String code;

  SignUpFailure(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class DropDownLoadedState extends RegistrationState {
  final List<String> dropdownlist;
  final String? selectedItem;

  DropDownLoadedState(this.dropdownlist, this.selectedItem);

  @override
  List<Object?> get props => [dropdownlist, selectedItem];
}

// class DropdownSelected extends RegistrationState {
//   final String selectedItem;
//   DropdownSelected({required this.selectedItem});
//   @override
//   List<Object?> get props => [selectedItem];
// }
