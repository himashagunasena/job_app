import 'package:flutter/material.dart';
import 'package:job_app/provider/fav_job_provider.dart';
import 'package:job_app/provider/job_details_provider.dart';
import 'package:job_app/screens/job_details_screen.dart';
import 'package:job_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../models/job_details_model.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocus = FocusNode();
  bool isSelectedFav = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavJobProvider>(context, listen: false).getFavJobs();
      var provider = Provider.of<JobDetailsProvider>(context, listen: false);
      provider.fetchData();
    });
    super.initState();
  }

  Color cardColorsText(int index) {
    return index % 2 == 0 ? AppColors.white : AppColors.titleColors;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<JobDetailsProvider>(context);
    var favJobProvider = Provider.of<FavJobProvider>(context, listen: true);
    return GestureDetector(
      onTap: () {
        searchFocus.unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text(
                "Find Your\nDream Job",
                style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    color: AppColors.titleColors),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowColors,
                            blurRadius: 8,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: searchController,
                        focusNode: searchFocus,
                        decoration: InputDecoration(
                            hintText: "Search your dream jobs",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none)),
                        onChanged: (value) {
                          provider.search(
                              value, favJobProvider.favJobIds, isSelectedFav);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        searchController.clear();
                        isSelectedFav = !isSelectedFav;
                        favJobProvider.getFavJobs();
                        provider.filterFavItems(
                            favJobProvider.favJobIds, isSelectedFav);
                      },
                      child: Container(
                        height: 52,
                        width: 52,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isSelectedFav
                                ? AppColors.primaryColor
                                : AppColors.white),
                        child: Icon(Icons.bookmark,
                            color: isSelectedFav
                                ? AppColors.white
                                : AppColors.primaryColor),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              provider.getIsLoading ?? false
                  ? Center(
                      child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3),
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          )),
                    )
                  : provider.getFilterJobDetails == null ||
                          provider.getFilterJobDetails!.isEmpty
                      ? Center(
                          child: Text(
                          "No data",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppColors.titleColors,
                          ),
                        ))
                      : Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: provider.getFilterJobDetails?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: jobCard(
                                      provider.getFilterJobDetails![index],
                                      index),
                                );
                              }),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget jobCard(JobDetailsModel jobDetails, int index) {
    var favJobProvider = Provider.of<FavJobProvider>(context, listen: true);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => JobDetailsScreen(
                    jobDetails: jobDetails,
                  )),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: index % 2 == 0 ? AppColors.primaryColor : AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColors,
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobDetails.jobTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: cardColorsText(index),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: index % 2 == 0
                            ? AppColors.white.withOpacity(0.2)
                            : AppColors.titleColors.withOpacity(0.2)),
                    child: Text(
                      jobDetails.jobType,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: cardColorsText(index),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobDetails.companyName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: cardColorsText(index),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${jobDetails.city} , ${jobDetails.country}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: cardColorsText(index),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      favJobProvider.setFavJob(jobDetails.id);
                    },
                    child: Icon(
                        favJobProvider.isFavJob(jobDetails.id)
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: cardColorsText(index)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
