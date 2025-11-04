import 'package:flutter/cupertino.dart';
import 'package:job_app/core/api_calls.dart';
import 'package:job_app/models/job_details_model.dart';

class JobDetailsProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();
  List<JobDetailsModel>? jobDetails;
  List<JobDetailsModel>? filterJobDetails;
  bool isLoading = true;
  bool isSelect = false;
  String? errorMessage;

  List<JobDetailsModel>? get getJobDetails => jobDetails;

  List<JobDetailsModel>? get getFilterJobDetails => filterJobDetails;

  bool? get getIsLoading => isLoading;

  String? get getErrorMessage => errorMessage;

  Future<void> fetchData() async {
    try {
      jobDetails = await apiCalls.fetchJobDetails();
      filterJobDetails = jobDetails;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  void search(String value, List<String> id, bool isSelect) {
    if (isSelect) {
      if (value.isEmpty) {
        filterFavItems(id, isSelect);
        notifyListeners();
      }
      filterJobDetails = jobDetails
          ?.where((val) =>
              id.contains(val.id) &&
              (val.jobTitle.toLowerCase().contains(value.toLowerCase()) ||
                  val.city.toLowerCase().contains(value.toLowerCase()) ||
                  val.country.toLowerCase().contains(value.toLowerCase())))
          .toList();
      notifyListeners();
    } else {
      if (value.isEmpty) {
        filterJobDetails = jobDetails;
        notifyListeners();
      } else {
        filterJobDetails = jobDetails
            ?.where((val) =>
                val.jobTitle.toLowerCase().contains(value.toLowerCase()) ||
                val.city.toLowerCase().contains(value.toLowerCase()) ||
                val.country.toLowerCase().contains(value.toLowerCase()))
            .toList();
        notifyListeners();
      }
    }
  }

  void filterFavItems(List<String> id, bool select) {
    if ((id.isEmpty || id == []) && !select) {
      filterJobDetails = jobDetails;
      notifyListeners();
    } else if (id.isEmpty && select) {
      filterJobDetails = [];
      notifyListeners();
    } else {
      if (!select || id.isEmpty || id == []) {
        filterJobDetails = jobDetails;
        notifyListeners();
      } else {
        filterJobDetails =
            jobDetails?.where((val) => id.contains(val.id)).toList();
        notifyListeners();
      }
    }
  }
}
