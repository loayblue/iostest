class UnitsModle {
  Data? data;

  UnitsModle({this.data});

  UnitsModle.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class Data {
  List<Units>? units;

  Data({this.units});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['units'] != null) {
      units = <Units>[];
      json['units'].forEach((v) {
        units!.add(new Units.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (units != null) {
      data['units'] = units!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Units {
  String? uuid;
  String? name;
  int? floor;
  bool? unitStatus;
  String? residentName;
  String? description;
  String? nameTower;
  String? uuidTower;
  String? userNameUuid;
  String? status;

  Units(
      {this.uuid,
      this.name,
      this.floor,
      this.unitStatus,
      this.residentName,
      this.description,
      this.nameTower,
      this.uuidTower,
      this.userNameUuid,
      this.status});

  Units.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    floor = json['floor'];
    unitStatus = json['unit_status'];
    residentName = json['resident_name'];
    description = json['description'];
    nameTower = json['name_tower'];
    uuidTower = json['uuid_tower'];
    userNameUuid = json['user_name_uuid'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uuid'] = uuid;
    data['name'] = name;
    data['floor'] = floor;
    data['unit_status'] = unitStatus;
    data['resident_name'] = residentName;
    data['description'] = description;
    data['name_tower'] = nameTower;
    data['uuid_tower'] = uuidTower;
    data['user_name_uuid'] = userNameUuid;
    data['status'] = status;
    return data;
  }
}
