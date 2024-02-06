part of 'auth_cubit.dart';

sealed class AuthcubitState extends Equatable {
  const AuthcubitState();

  @override
  List<Object> get props => [];
}

final class AuthcubitInitial extends AuthcubitState {}

final class AuthcubitLoading extends AuthcubitState {}

final class AuthcubitSuccess extends AuthcubitState {}

final class AuthcubitFailure extends AuthcubitState {
  final String errMsg;

  const AuthcubitFailure({required this.errMsg});

}
