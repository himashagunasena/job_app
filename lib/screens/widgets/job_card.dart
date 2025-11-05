import 'package:flutter/material.dart';
import 'package:job_app/models/job_details_model.dart';
import 'package:provider/provider.dart';

import '../../provider/fav_job_provider.dart';
import '../../utils/app_colors.dart';
import '../job_details_screen.dart';

class JobCard extends StatelessWidget {
  final JobDetailsModel jobDetails;
  final int index;

  const JobCard({super.key, required this.jobDetails, required this.index});

  @override
  Widget build(BuildContext context) {
    Color cardColorsText(int index) {
      return index % 2 == 0
          ? AppColors().cardLightColor(context)
          : AppColors().titleColors(context);
    }

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
            color: index % 2 == 0
                ? AppColors().cardColor(context)
                : AppColors().white(context),
            boxShadow: [
              BoxShadow(
                color: AppColors().shadowColors(context),
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
                            ? AppColors().white(context).withOpacity(0.2)
                            : AppColors()
                                .titleColors(context)
                                .withOpacity(0.2)),
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
                  Expanded(
                    child: Column(
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
