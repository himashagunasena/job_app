import 'dart:convert';

import 'package:job_app/models/job_details_model.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  Future<List<JobDetailsModel>> fetchJobDetails() async {
    final response = await http.get(
      Uri.parse('https://6909f8181a446bb9cc20c999.mockapi.io/job/job_details'),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => JobDetailsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load job details');
    }
  }
}
