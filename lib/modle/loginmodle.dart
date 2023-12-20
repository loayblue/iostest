class Loginmodel {
  Loginmodel({
    required this.data,
    required this.status,
    this.error,
    required this.statusCode,
  });
  late final Data data;
  late final bool status;
  late final Null error;
  late final int statusCode;

  Loginmodel.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    status = json['status'];
    error = null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['status'] = status;
    _data['error'] = error;
    _data['statusCode'] = statusCode;
    return _data;
  }
}

class Data {
  Data({
    required this.security,
    required this.token,
  });
  late final Security security;
  late final String token;

  Data.fromJson(Map<String, dynamic> json) {
    security = Security.fromJson(json['security']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['security'] = security.toJson();
    _data['token'] = token;
    return _data;
  }
}

class Security {
  Security({
    required this.uuid,
    required this.phone,
    required this.tower,
    required this.towerUuid,
    required this.email,
  });
  late final String uuid;
  late final String phone;
  late final String tower;
  late final String towerUuid;
  late final String email;

  Security.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    phone = json['phone'];
    tower = json['tower'];
    towerUuid = json['tower_uuid'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uuid'] = uuid;
    _data['phone'] = phone;
    _data['tower'] = tower;
    _data['tower_uuid'] = towerUuid;
    _data['email'] = email;
    return _data;
  }
}
