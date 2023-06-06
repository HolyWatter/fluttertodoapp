import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todoapp/common/secure_storage/secure_storage_provider.dart';

final dioProvider = Provider<Dio>((ref){
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    DioInterceptor(storage: storage)
  );
  
  return dio;
});

class DioInterceptor extends Interceptor{
  final FlutterSecureStorage storage;

    DioInterceptor({required this.storage});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if(options.headers['accessToken'] == 'true'){
      options.headers.remove('accessToken');

      final token = await storage.read(key: 'accessToken');

      options.headers.addAll({
        'authorization' : token
      });
    }

    if(options.headers['refreshToken'] == 'true'){
      options.headers.remove('refreshToken');

      final token = await storage.read(key: 'refreshToken');

      options.headers.addAll({
        'authorization' : token
      });
    }
    print('[${options.method}] ${options.baseUrl}');

    return super.onRequest(options, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final refreshToken = await storage.read(key: 'refreshToken');

    if(refreshToken == null){
      return handler.reject(err);
    }
    
    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    try{
      if(isStatus401 && !isPathRefresh){
        final dio = Dio();
        final res = await dio.post('http://localhost:4000/auth/token',
        options: Options(
          headers: {
            'authorization' : refreshToken
          }
        ));
        final accessToken = res.data['accessToken'];

        final options = err.requestOptions;
        options.headers.addAll({
          'authorization' : accessToken
        });

        await storage.write(key: 'accessToken', value: accessToken);

        final response = await dio.fetch(options);
        return handler.resolve(response);

        
      }
    }on DioError catch(e){
      return handler.reject(e);
    }

    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response);
    return super.onResponse(response, handler);
  }
}