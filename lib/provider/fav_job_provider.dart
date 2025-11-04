import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:job_app/utils/storage.dart';

class FavJobProvider extends ChangeNotifier {
  List<String> favJobIds = [];
  String? jobID;

  List<String>? get getFavJobIds => favJobIds;

  FavJobProvider() {
    getFavJobs();
  }

  Future<void> getFavJobs() async {
    favJobIds = await CustomStorage().getStringList(jobID ?? "") ?? [];
    notifyListeners();
  }

  Future<void> setFavJob(String id) async {
    if (favJobIds.contains(id)) {
      favJobIds.remove(id);
    } else {
      favJobIds.add(id);
    }
    await CustomStorage().setStringList(jobID ?? "", favJobIds);
    notifyListeners();
  }

  bool isFavJob(String id) {
    return favJobIds.contains(id);
  }
}
