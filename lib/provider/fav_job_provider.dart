import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:job_app/models/job_details_model.dart';
import 'package:job_app/utils/storage.dart';

class FavJobProvider extends ChangeNotifier {
  List<String> favJobIds = [];
  List<JobDetailsModel> favJobs = [];
  String? jobID;

  List<String>? get getFavJobIds => favJobIds;

  List<JobDetailsModel>? get getFavJobsList => favJobs;

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

  List<JobDetailsModel>? favList(List<JobDetailsModel> details) {
    favJobs = details.where((e) => favJobIds.contains(e.id)).toList();
    if (favJobs.isNotEmpty) {
      return favJobs;
    }
    return null;
  }

  bool isFavJob(String id) {
    return favJobIds.contains(id);
  }

  void search(List<JobDetailsModel> details, String value) {
    if (value.isNotEmpty) {
      favJobs = favJobs.where((val) {
        return val.jobTitle.toLowerCase().contains(value.toLowerCase()) ||
            val.city.toLowerCase().contains(value.toLowerCase()) ||
            val.country.toLowerCase().contains(value.toLowerCase());
      }).toList();
      notifyListeners();
    } else {
      favJobs = details;
      notifyListeners();
    }
  }
}
