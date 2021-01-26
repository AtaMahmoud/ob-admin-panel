class LightScene {
  bool isDefault;
  String id;
  String source;
  String sceneName;
  List<Room> rooms;

  LightScene({
    this.isDefault,
    this.id,
    this.source,
    this.sceneName,
    this.rooms,
  });

  LightScene.fromJson(Map<String, dynamic> json) {
    isDefault = json['isDefault'] as bool;
    id = json['_id'] as String;
    source = json['source'] as String;
    sceneName = json['sceneName'] as String;
    rooms = [];
    json['rooms']
        .forEach((e) => rooms.add(Room.fromJson(e as Map<String, dynamic>)));
  }
}

class Room {
  List<Mode> modes;
  String id;
  String label;

  Room({
    this.modes,
    this.id,
    this.label,
  });

  Room.fromJson(Map<String, dynamic> json) {
    modes = [];
    json['moodes']
        .forEach((e) => modes.add(Mode.fromJson(e as Map<String, dynamic>)));
    id = json['_id'] as String;
    label = json['label'] as String;
  }
}

class Mode {
  bool status;
  num intensity;
  String id;
  String lightName;
  String lightColor;

  Mode({
    this.status,
    this.intensity,
    this.id,
    this.lightName,
    this.lightColor,
  });

  Mode.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool;
    intensity = json['intensity'] as num;
    id = json['_id'] as String;
    lightName = json['lightName'] as String;
    lightColor = json['lightColor'] as String;
  }
}
