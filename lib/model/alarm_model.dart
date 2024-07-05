class AlarmModel {
  int alarmId;
  String from;
  String to;

  AlarmModel({required this.alarmId, required this.from, required this.to});

  Map<String, dynamic> toJson() {
    return {'alarmId': alarmId, 'from': from, 'to': to};
  }

  static AlarmModel fromJson(dynamic json) {
    return AlarmModel(
        alarmId: json['alarmId'], from: json['from'], to: json['to']);
  }
}
