import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/provider/fav_job_provider.dart';
import 'package:job_app/provider/job_details_provider.dart';
import 'package:job_app/screens/faviorite_job_screen.dart';
import 'package:job_app/screens/widgets/common_button.dart';
import 'package:job_app/screens/widgets/job_card.dart';
import 'package:job_app/screens/widgets/search.dart';
import 'package:job_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

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

  @override
  void dispose() {
    searchController.clear();
    super.dispose();
  }

  Color cardColorsText(int index) {
    return index % 2 == 0
        ? AppColors().cardLightColor(context)
        : AppColors().titleColors(context);
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
                style: GoogleFonts.bungee(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    color: AppColors().titleColors(context)),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
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
                          focusNode: searchFocus,
                          onchange: (value) {
                            provider.search(
                                value, favJobProvider.favJobIds, isSelectedFav);
                          },
                        )),
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
                                ? AppColors().primaryColor(context)
                                : AppColors().white(context)),
                        child: Icon(Icons.bookmark,
                            color: isSelectedFav
                                ? AppColors().white(context)
                                : AppColors().primaryColor(context)),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              CommonButton(
                  size: Size(MediaQuery.of(context).size.width, 52),
                  title: "Go to faviorite Jobs",
                  onclick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FavioriteJobScreen()),
                    );
                  }),
              SizedBox(height: 16),
              provider.getIsLoading ?? false
                  ? Center(
                      child: Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3),
                          child: CircularProgressIndicator(
                            color: AppColors().primaryColor(context),
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
                            color: AppColors().titleColors(context),
                          ),
                        ))
                      : Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: provider.getFilterJobDetails?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: JobCard(
                                      jobDetails:
                                          provider.getFilterJobDetails![index],
                                      index: index),
                                );
                              }),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
