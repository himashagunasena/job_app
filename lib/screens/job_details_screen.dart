import 'package:flutter/material.dart';
import 'package:job_app/models/job_details_model.dart';
import 'package:job_app/screens/widgets/common_button.dart';
import 'package:job_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../provider/fav_job_provider.dart';

class JobDetailsScreen extends StatefulWidget {
  final JobDetailsModel? jobDetails;

  const JobDetailsScreen({super.key, this.jobDetails});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var favJobProvider = Provider.of<FavJobProvider>(context, listen: true);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 32),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors().primaryColor(context),
                      )),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color:
                            AppColors().titleColors(context).withOpacity(0.2)),
                    child: Text(
                      widget.jobDetails?.jobType ?? "--",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors().titleColors(context),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      widget.jobDetails?.jobTitle ?? "",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                          color: AppColors().titleColors(context)),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "LKR ${widget.jobDetails?.salary ?? "--"}/ per hour",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors().subTitleColor(context),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors().white(context),
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image:
                                  NetworkImage(widget.jobDetails?.logo ?? ''),
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.jobDetails?.companyName ?? "--",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors().titleColors(context),
                              ),
                            ),
                            Text(
                              "${widget.jobDetails!.city} , ${widget.jobDetails!.country}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors().subTitleColor(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Divider(color: AppColors().dividerColor(context)),
                  ),
                  Text(
                    "Job Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors().titleColors(context),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.jobDetails?.description ?? "--",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                      color: AppColors().titleColors(context),
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: AppColors().backgroundColor(context),
              boxShadow: [
                BoxShadow(
                  color: AppColors().shadowColors(context),
                  blurRadius: 70,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SafeArea(
              bottom: true,
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        favJobProvider.setFavJob(widget.jobDetails?.id ?? "");
                      },
                      child: Container(
                        height: 52,
                        width: 52,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors().white(context)),
                        child: Icon(
                            favJobProvider.isFavJob(widget.jobDetails?.id ?? "")
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            size: 32,
                            color: AppColors().titleColors(context)),
                      ),
                    ),
                    SizedBox(width: 8),
                    CommonButton(
                      size: Size(MediaQuery.of(context).size.width - 100, 52),
                      title: "Apply",
                      onclick: () {},
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
