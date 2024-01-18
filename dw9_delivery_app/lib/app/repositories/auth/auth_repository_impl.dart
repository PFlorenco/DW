// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_app/app/core/exceptions/unauthorized_exeption.dart';
import 'package:dw9_delivery_app/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_app/app/models/auth_model.dart';

import '../../core/exceptions/repository_exception.dart';
import './auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final CustomDio dio;
  AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unauth().post('/auth', data: {
        'email': email,
        'password': password,
      });

      return AuthModel.fromMap(result.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        log('Permissão negada: $e' as num);
        throw UnauthorizedExeption();
      }
      log('Erro ao realizar Login: $e' as num);
      throw RepositoryException(message: 'Erro ao realizar Login.');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post(
        '/users',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
    } on DioError catch (e) {
      log('Erro ao registrar usuário: $e' as num);
      throw RepositoryException(message: 'Erro ao registrar usuário.');
    }
  }
}
