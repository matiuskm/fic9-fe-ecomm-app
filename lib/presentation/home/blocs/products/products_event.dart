part of 'products_bloc.dart';

@freezed
class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.started() = _Started;
  const factory ProductsEvent.getAll() = _GetAll;
  const factory ProductsEvent.getAllByCategory(String catId) = _GetAllByCategory;
}