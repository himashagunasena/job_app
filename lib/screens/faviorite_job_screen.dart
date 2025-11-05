import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/provider/job_details_provider.dart';
import 'package:job_app/screens/widgets/job_card.dart';
import 'package:job_app/screens/widgets/search.dart';
import 'package:provider/provider.dart';

import '../provider/fav_job_provider.dart';
import '../utils/app_colors.dart';

class FavioriteJobScreen extends StatefulWidget {
  const FavioriteJobScreen({super.key});

  @override
  State<FavioriteJobScreen> createState() => _FavioriteJobScreenState();
}

class _FavioriteJobScreenState extends State<FavioriteJobScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavJobProvider>(context, listen: false).getFavJobs();
      var provider = Provider.of<JobDetailsProvider>(context, listen: false);
      Provider.of<FavJobProvider>(context, listen: false)
          .favList(provider.jobDetails ?? []);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var favJobProvider = Provider.of<FavJobProvider>(context, listen: true);
    var provider = Provider.of<JobDetailsProvider>(context, listen: true);
    return Scaffold(
      body: Padding(
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
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                "Faviorite Jobs",
                style: GoogleFonts.bungee(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    color: AppColors().titleColors(context)),
              ),
            ),
            SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: AppColors().white(context),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors().shadowColors(context),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: CommonSearchBar(
                textEditingController: searchController,
                onchange: (value) {
                  favJobProvider.search(
                      (favJobProvider.favList(provider.jobDetails ?? []) ?? []),
                      value);
                },
              ),
            ),
            SizedBox(height: 16),
            favJobProvider.getFavJobsList == null ||
                    favJobProvider.getFavJobsList == [] ||
                    favJobProvider.getFavJobsList!.isEmpty
                ? Center(
                    child: Text(
                    "No data",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: AppColors().titleColors(context),
                    ),
                  ))
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: favJobProvider.getFavJobsList?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: JobCard(
                                jobDetails:
                                    favJobProvider.getFavJobsList![index],
                                index: index),
                          );
                        }),
                  ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
