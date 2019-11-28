class GameCommad {
  final int code;
  final String data;

  GameCommad(this.code, this.data);

  GameCommad.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data,
      };
}

final ADD_USER_INFO = 1;
final ADD_GAME_DATA = 2;
final ADD_GROUP_GAME_DATA = 3;
final START_PERSONAL_GAME = 5;
final START_GROUP_GAME = 6;
final START_PERSONAL_TASK = 7;
final START_GROUP_TASK = 8;
