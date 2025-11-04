// To parse this JSON data, do
//
//     final jobDetailsModel = jobDetailsModelFromJson(jsonString);

import 'dart:convert';

List<JobDetailsModel> jobDetailsModelFromJson(String str) =>
    List<JobDetailsModel>.from(
        json.decode(str).map((x) => JobDetailsModel.fromJson(x)));

String jobDetailsModelToJson(List<JobDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobDetailsModel {
  String jobTitle;
  String companyName;
  String city;
  String country;
  String jobType;
  String description;
  String area;
  DateTime createDate;
  String salary;
  String logo;
  String id;

  JobDetailsModel({
    required this.jobTitle,
    required this.companyName,
    required this.city,
    required this.country,
    required this.jobType,
    required this.description,
    required this.area,
    required this.createDate,
    required this.salary,
    required this.logo,
    required this.id,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) =>
      JobDetailsModel(
        jobTitle: json["job_title"],
        companyName: json["company_name"],
        city: json["city"],
        country: json["country"],
        jobType: json["job_type"],
        description: json["description"],
        area: json["area"],
        createDate: DateTime.parse(json["create_date"]),
        salary: json["salary"],
        logo: json["logo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "job_title": jobTitle,
        "company_name": companyName,
        "city": city,
        "country": country,
        "job_type": jobType,
        "description": description,
        "area": area,
        "create_date": createDate.toIso8601String(),
        "salary": salary,
        "logo": logo,
        "id": id,
      };
}
