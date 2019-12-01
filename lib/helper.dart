class GameCommad {
  final int code;
  final dynamic data;

  GameCommad(this.code, this.data);

  GameCommad.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        data = json['data'];

  Map<String, dynamic> toJson() => {
        'code': code,
        'data': data,
      };
}

const ADD_USER_INFO = 1;
const ADD_GAME_DATA = 2;
const ADD_GROUP_GAME_DATA = 3;
const ADD_GROUP_GAME_TILE = 31;
const START_PERSONAL_GAME = 5;
const START_GROUP_GAME = 6;
const START_PERSONAL_TASK = 7;
const START_GROUP_TASK = 8;

final READY_FOR_GROUP = 9;
final NOT_READY_FOR_GROUP = 91;
final ON_GROUP_BOARD = 92;
final LEAVE_GROUP_BOARD = 93;
