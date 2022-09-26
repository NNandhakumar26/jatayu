import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jatayu/Screens/mainpage.dart';
import 'package:jatayu/about/myposts_page.dart';
import 'package:jatayu/modals/project.dart';
import 'package:jatayu/database/network_database.dart';
import 'package:jatayu/Screens/custom_future_builder.dart';
import 'package:lottie/lottie.dart';
import '../Theme.dart';
import 'profile_page.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      // ), g and h are the ghghghghghgh ggg hhh g and h g, h
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProfilePageWidget(
                  title: 'You Are',
                  widgets: [
                    ListTile(
                      onTap: () => Style.navigateBack(context, ProfilePage()),
                      contentPadding: EdgeInsets.all(10),
                      dense: true,
                      title: Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          FirebaseAuth.instance.currentUser?.displayName ??
                              'Profile Page',
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: Style.headline.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Style.darkerText,
                          ),
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('assets/images/jatayu.png'),
                        foregroundImage: CachedNetworkImageProvider(
                            FirebaseAuth.instance.currentUser!.photoURL ?? ''),
                        // child: (controller.imageUrl.value == null)
                        //     ? Container(
                        //         color: Styling.primary,
                        //       )
                        //     : Container(
                        //         height: 150.h,
                        //         width: 150.w,
                        //         decoration: new BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           image: new DecorationImage(
                        //             fit: BoxFit.cover,
                        //             image: NetworkImage(
                        //                 controller.imageUrl.value.toString()),
                        //           ),
                        //         ),
                        //       ),
                      ),
                      // trailing: SizedBox(
                      //   width: Get.width / 8,
                      //   child: Icon(
                      //     Icons.edit_outlined,
                      //     color: Style.nearlyDarkBlue,
                      //     size: 20,
                      //   ),
                      // ),
                      subtitle: Text(
                        'Click here to update your profile',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.black45,
                              fontSize: 12,
                            ),
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(8),
                    //   child: ListTile(
                    //     onTap: ,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildButton(context, '4.8', 'Ranking'),
                          buildDivider(),
                          buildButton(context, '35', 'Following'),
                          buildDivider(),
                          buildButton(context, '50', 'Followers'),
                        ],
                      ),
                    ),
                    CustomCard(
                      title: 'My Posts',
                      subtitle: 'Click here to View / Update posts',
                      navigateTo: MyPostsPage(),
                    ),
                  ],
                ),
                ProfilePageWidget(title: 'Your Badge', widgets: [
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Style.nearlyDarkBlue.withOpacity(0.16),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Lottie.asset(
                                'assets/json/badge.json',
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'Winner Badge',
                                  style: Style.headline.copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 180,
                      //   margin: EdgeInsets.all(8),
                      //   padding: EdgeInsets.all(8),
                      //   decoration: BoxDecoration(
                      //     border:
                      //         Border.all(color: Colors.white10.withAlpha(80)),
                      //     borderRadius: BorderRadius.circular(20),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Style.nearlyDarkBlue.withAlpha(100),
                      //         blurRadius: 10.0,
                      //         spreadRadius: 0.0,
                      //       ),
                      //     ],
                      //     color: Colors.white.withOpacity(0.2),
                      //   ),
                      // ),
                    ],
                  ),
                ]),
                ProfilePageWidget(
                  title: 'We Are',
                  widgets: [
                    Card(
                      elevation: 10,
                      shape: CircleBorder(side: BorderSide.none),
                      borderOnForeground: true,
                      shadowColor: Style.nearlyDarkBlue.withOpacity(0.16),
                      clipBehavior: Clip.antiAlias,
                      color: Style.nearlyWhite,
                      child: CircleAvatar(
                        maxRadius: 110.0,
                        backgroundColor: Style.nearlyWhite,
                        foregroundImage: AssetImage('assets/images/jatayu.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Text(
                        '‘Be the change you seek’. We serve not just to help others but also to discover ourself in that process.',
                        textAlign: TextAlign.center,
                        style: Style.subtitle.copyWith(
                          fontFamily: Style.fontName,
                          color: Style.lightText.withOpacity(0.87),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                ProjectCard(
                  title: 'Ongoing Projects',
                  childWidget: CustomFutureBuilder<List<Project>>(
                    onSuccessWidget: (projects) => Column(
                      children: projects
                          .map(
                            (e) => ProjectWidget(
                              project: e,
                            ),
                          )
                          .toList(),
                    ),
                    futureFunction: Network.readOngoingProjects(),
                  ),
                ),
                ProjectCard(
                  title: 'Volunteer',
                  childWidget: CustomFutureBuilder<List<Project>>(
                    onSuccessWidget: (projects) => Column(
                      children: projects
                          .map(
                            (e) => ProjectWidget(
                              project: e,
                            ),
                          )
                          .toList(),
                    ),
                    futureFunction: Network.getAllVolunteer(),
                  ),
                ),
                ProjectCard(
                  title: 'Upcoming Projects',
                  childWidget: CustomFutureBuilder<List<Project>>(
                    onSuccessWidget: (projects) => Column(
                      children: projects
                          .map(
                            (e) => ProjectWidget(
                              project: e,
                            ),
                          )
                          .toList(),
                    ),
                    futureFunction: Network.getAllUpcomingProjects(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDivider() => Container(
        height: 24,
        child: VerticalDivider(),
      );

  Widget buildButton(BuildContext context, String value, String text) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              value,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.black87,
                  ),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
            ),
          ],
        ),
      );
}

class ProfilePageWidget extends StatelessWidget {
  final String title;
  final List<Widget> widgets;
  const ProfilePageWidget({
    Key? key,
    required this.title,
    required this.widgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          child: ThisPageTitle(title: title),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Column(
            children: widgets,
          ),
        ),
        SizedBox(
          height: 6,
        ),
      ],
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final Widget childWidget;
  const ProjectCard({
    Key? key,
    required this.title,
    required this.childWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ThisPageTitle(title: title),
        Card(
          margin: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 8,
            ),
            child: childWidget,
          ),
        ),
      ],
    );
  }
}

class ProjectWidget extends StatelessWidget {
  final Project project;
  const ProjectWidget({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          backgroundColor: Style.nearlyDarkBlue.withOpacity(0.032),
          iconColor: Style.nearlyDarkBlue.withOpacity(0.87),
          title: Text(
            project.title ?? '',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  fontSize: 16,
                  color: Style.nearlyDarkBlue.withOpacity(0.87),
                  fontWeight: FontWeight.w600,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 4,
            ),
            child: Text(
              project.desc ?? '',
              maxLines: 2,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.black45,
                    // fontWeight: FontWeight.bold,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.93),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: Style.nearlyDarkBlue.withOpacity(0.32),
                  width: 0.64,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                project.desc ?? '',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.black54,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Style.nearlyDarkBlue,
                onPressed: () {},
                label: Text(
                  'View More',
                  style: Style.button,
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Style.nearlyBlack.withOpacity(0.60),
          thickness: 0.16,
          endIndent: 16,
          indent: 8,
        )
      ],
    );
  }
}

class ThisPageTitle extends StatelessWidget {
  final String title;
  ThisPageTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontFamily: Style.fontName,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.5,
          color: Style.lightText,
        ),
      ),
    );
  }
}
