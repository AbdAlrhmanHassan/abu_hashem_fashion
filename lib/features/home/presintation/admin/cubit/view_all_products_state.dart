part of 'view_all_products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ViewAllProductsInitial extends ProductsState {}

final class ViewAllProductsLoading extends ProductsState {}

final class ViewAllProductsSuccess extends ProductsState {
  final List<ProductModel> productModel;
  const ViewAllProductsSuccess({required this.productModel});
}

final class ProductsFound extends ProductsState {}

final class ViewAllProductsFailure extends ProductsState {
  final String errorMsg;

  const ViewAllProductsFailure({required this.errorMsg});
}

final class CartAddSuccess extends ProductsState {}

final class CartLoading extends ProductsState {}

final class CartFailure extends ProductsState {
  final String errorMsg;

  const CartFailure({required this.errorMsg});
}
