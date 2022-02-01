import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';

class Utils {
  static Future<PackageInfo> getPackageName() async {
    PackageInfo pck = await PackageInfo.fromPlatform();
    return pck;
  }

  static shareText(String text) {
    Share.share(text);
  }

  //date current
  static String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }
}
