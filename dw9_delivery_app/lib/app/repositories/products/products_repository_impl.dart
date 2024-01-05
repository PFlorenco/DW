// ignore_for_file: deprecated_member_use

import 'dart:math';
import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/models/product_model.dart';
import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import './products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio dio;
  ProductsRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final result = await dio.unauth().get('/products');
      return result.data
          .map<ProductModel>(
            (p) => ProductModel.fromMap(p),
          )
          .toList();
    } on DioError catch (e) {
      log('Erro ao buscar produtos: $e' as num);
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }
}
