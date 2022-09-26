import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Course/course_activities.dart';
import 'package:jatayu/Course/course_controller.dart';
import 'package:jatayu/Theme.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';

class CoursePage extends GetView<CourseController> {
  final controller = Get.put(CourseController());
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'course',
      child: Scaffold(
        // appBar: PreferredSize(
        //   child: AppBar(
        //     backgroundColor: Colors.white,
        //     elevation: 8,
        //     leadingWidth: 0,
        //     shadowColor: Style.nearlyDarkBlue.withOpacity(0.16),
        //     title: CompanyAppbar(),
        //   ),
        //   preferredSize: Size(
        //     double.infinity,
        //     MediaQuery.of(context).size.height / 14,
        //   ),
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FadeInDown(
                  delay: Duration(milliseconds: 1300),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    // padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListTile(
                      title: Text(
                        'Jatayu Curriculum',
                        style: Style.title.copyWith(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: Text(
                          'An initiative to help you learn',
                          style: Style.subtitle2.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                FadeInUp(
                  delay: Duration(milliseconds: 200),
                  child: Lottie.asset(
                    'assets/json/hand_leaves.json',
                    repeat: false,
                    reverse: false,
                  ),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 1600),
                  child: Card(
                    elevation: 10,
                    shadowColor: Style.nearlyDarkBlue.withOpacity(0.16),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Style.nearlyDarkBlue.withOpacity(0.16),
                        width: 0.87,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Column(
                        children: [
                          CurriculumComponent(
                              title: 'Basics', jsonLink: 'sprout'),
                          CurriculumComponent(
                            title: 'Intermediate',
                            jsonLink: 'purplePlantSingle',
                          ),
                          CurriculumComponent(
                            title: 'Advanced',
                            jsonLink: 'purpleSinglePlantSprouting',
                          )
                        ]
                            .map(
                              (e) => ComponentContainer(
                                thisComponent: e,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ComponentContainer extends StatelessWidget {
  final CurriculumComponent thisComponent;
  const ComponentContainer({
    Key? key,
    required this.thisComponent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: ExpansionTile(
              leading: FittedBox(
                fit: BoxFit.fill,
                child: CircleAvatar(
                  backgroundColor: Style.nearlyDarkBlue.withOpacity(0.048),
                  child: Lottie.asset(
                    'assets/json/${thisComponent.jsonLink}.json',
                    height: 80,
                    width: 80,
                    repeat: true,
                    reverse: false,
                  ),
                ),
              ),
              title: Text(
                thisComponent.title,
                style: Style.title.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Style.nearlyDarkBlue,
                ),
              ),
              iconColor: Style.nearlyDarkBlue.withOpacity(0.87),
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Style.nearlyDarkBlue.withOpacity(0.048),
                    border: Border.all(
                      color: Style.nearlyDarkBlue.withOpacity(0.87),
                      width: 0.32,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      ...[1, 2, 3, 4]
                          .map(
                            (e) => Bounce(
                              child: GestureDetector(
                                onTap: () => Future.delayed(
                                  Duration(milliseconds: 150),
                                  () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) =>
                                          CourseActivityWidget(),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    elevation: 4,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    shadowColor:
                                        Style.nearlyDarkBlue.withOpacity(0.24),
                                    child: ListTile(
                                      minLeadingWidth: 16,
                                      leading: Icon(
                                        Icons.play_circle_outline,
                                        color: Style.nearlyDarkBlue
                                            .withOpacity(0.87),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      title: Text(
                                        'Level $e',
                                        style: Style.title.copyWith(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ]),
        ),
        Divider(
          indent: 80,
          endIndent: 16,
          thickness: 0.40,
          color: Style.nearlyDarkBlue.withOpacity(0.24),
        ),
      ],
    );
  }
}

class CurriculumComponent {
  String title;
  String jsonLink;

  CurriculumComponent({required this.title, required this.jsonLink});
}
