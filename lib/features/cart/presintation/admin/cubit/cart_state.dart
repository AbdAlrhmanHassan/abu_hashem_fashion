part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}


class CartSuccess extends CartState {
  final List<CartModel> cartItems;

  const CartSuccess(this.cartItems);

  
}
final class CartFailure extends CartState {
  final String errorMsg;

  const CartFailure({required this.errorMsg});
}
