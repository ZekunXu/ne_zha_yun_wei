
const daluApiUrl = "https://api.dalurobot.com/";
const daluImgUrl = "https://mapimg.dalurobot.com/";

class ApiUrl {
  static const String LOGIN_REQUEST = daluApiUrl + "session"; // 登录请求接口
  static const String ROBOTS_LIST = daluApiUrl + "robot/query/page/robots"; //获取所有机器人的列表
  static const String MAP_LIST = daluApiUrl + "slammap/query/page/map"; //获取账号下所有地图的列表
  static const String NAVIGATION_CONTROL = daluApiUrl + "slamcontrol/"; //处理所有的导航请求
  static const String ALL_MAP_PATH_INFO = daluApiUrl + "slammap"; //获取所有的地图和地图下所有路径的信息
}
