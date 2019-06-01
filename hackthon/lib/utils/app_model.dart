import 'package:hackthon/utils/avarjana.dart';
import 'package:hackthon/utils/pasindu.dart';
import 'package:hackthon/utils/shakthi.dart';
import 'package:hackthon/utils/thadiya.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model with Avarjana, Shakthi, Pasindu, Thadiya {
  int homeTabState;
  void setHomeTabState(int i) {
    homeTabState = i;
    notifyListeners();
  }

  int messageTabState;
  void setMessageTabState(int i) {
    messageTabState = i;
    notifyListeners();
  }

  int notificationTabState;
  void setNotificationTabState(int i) {
    notificationTabState = i;
    notifyListeners();
  }

  int profileTabState;
  void setProfileTabState(int i) {
    profileTabState = i;
    notifyListeners();
  }
}
