import 'package:dio/dio.dart';
import 'package:securitygate/modle/tunit.dart';

class ApiClient {
  final Dio _dio = Dio();



  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        'https://themetanest.dev/metagate/public/api/security/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> postFroEmirates(
    String accessToken,
    String documenttype,
    String givennames,
    String nationalitycode,
    String birthday,
    String sex,
    String expriydate,
    String personalnumber,
    String personalnumber1,
    String sername,
    String phone,
    String uuidunit,
    String reason,
    String prefixphone,
  ) async {
    try {
      Response response = await _dio.post(
        'https://themetanest.dev/metagate/public/api/security/scan_invitation_code',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        data: {
          'documenttype': documenttype,
          'givennames': givennames,
          'nationality_code': nationalitycode,
          'birthday': birthday,
          'sex': sex,
          'expriydate': expriydate,
          'personalnumber': personalnumber,
          'personalnumber1': personalnumber1,
          'sername': sername,
          'phone': phone,
          'uuidunit': uuidunit,
          'reason': reason,
          'prefixphone': prefixphone,
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> postfromuserscan(
      String accessToken,
      String user_uuid,
      String unit_name,
      String reason,
      String prefix_phone,
      String phonenumber) async {
    try {
      Response response = await _dio.post(
        'https://themetanest.dev/metagate/public/api/security/scan_user_phone',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        data: {
          'user_uuid': user_uuid,
          'unit_name': unit_name,
          'reason': reason,
          'prefix_phone': prefix_phone,
          'phone': phonenumber
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> postFromInvitation(
    String accessToken,
    String uuidvisit,
  ) async {
    try {
      Response response = await _dio.post(
        'https://themetanest.dev/metagate/public/api/security/scan_invitation_code',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        data: {
          'user_uuid': uuidvisit,
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> updateUserCheckIn(
    String accessToken,
    String useruuid,
  ) async {
    try {
      Response response = await _dio.post(
        'https://themetanest.dev/metagate/public/api/security/user_unit/update',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        data: {
          'user_uuid': useruuid,
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> postmanully(
      String accessToken,
      String email,
      String phone,
      String firstname,
      String lastname,
      String unitname,
      String reason,
      String prefixphone) async {
    try {
      Response response = await _dio.post(
        'https://themetanest.dev/metagate/public/api/security/visit_manually',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
        data: {
          'email': email,
          'phone': phone,
          'first_name': firstname,
          'last_name': lastname,
          'unit_name': unitname,
          'reason': reason,
          'prefix_phone': prefixphone,
        },
      );
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> getAllUnits(String accessToken) async {
    try {
      Response response = await _dio.get(
        'https://themetanest.dev/metagate/public/api/security/unit/all',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future allUnits(String accessToken) async {
    try {
      Response response = await _dio.get(
        'https://themetanest.dev/metagate/public/api/security/unit/all',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      if (response.data['statusCode'] == 200) {
        Units(
          uuid: response.data['uuid'],
          name: response.data['name'],
        );
        return Units;
      }
    } on DioError catch (e) {
      return e.response!.data;
    }
  }


  updateUserInTower(String accesstoken, String userid) {}
}
