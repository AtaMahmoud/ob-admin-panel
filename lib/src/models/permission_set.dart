class PermissionSet {
  bool isDefault;
  String id;
  String name;
  List<Set> sets;
  num v;

  PermissionSet({
    this.isDefault,
    this.id,
    this.name,
    this.sets,
    this.v,
  });

  PermissionSet.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      isDefault = json['isDefault'];
      id = json['_id'];
      name = json['Name'];
      sets = [];
      json['Sets'].forEach((e) {
        sets.add(Set.fromJson(e));
      });
      v = json['__v'];
    }
  }
}

class Set {
  List<Permission> permissions;
  String id;
  String name;

  Set({
    this.permissions,
    this.id,
    this.name,
  });

  Set.fromJson(Map<String, dynamic> json) {
    permissions = [];
    json['Permissions'].forEach((e) {
      permissions.add(Permission.fromJson(e));
    });
    id = json['_id'];
    name = json['Name'];
  }
}

class Permission {
  String status;
  String id;
  String name;

  Permission({this.status, this.id, this.name});

  Permission.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    id = json['_id'];
    name = json['Name'];
  }
}
