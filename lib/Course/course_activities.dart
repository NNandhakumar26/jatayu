import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jatayu/Theme.dart';

class CourseActivityWidget extends StatefulWidget {
  const CourseActivityWidget({Key? key}) : super(key: key);

  @override
  _CourseActivityWidgetState createState() => _CourseActivityWidgetState();
}

class _CourseActivityWidgetState extends State<CourseActivityWidget> {
  int _index = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final images = ValueNotifier<List<File>>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 24, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Activity',
                      style: Style.title.copyWith(
                        color: Color(0xFF090F13),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 4, 24, 24),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'All Activity from this past month.',
                      style: Style.body2.copyWith(
                        color: Color(0xFF8B97A2),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),

              //Start Steeper from here
              Stepper(
                currentStep: _index,
                physics: BouncingScrollPhysics(),
                onStepCancel: () {
                  if (_index > 0) {
                    setState(() {
                      _index -= 1;
                    });
                  }
                },
                onStepContinue: () {
                  if (_index <= 12) {
                    setState(() {
                      _index += 1;
                    });
                  }
                },
                controlsBuilder: (context, index) => SizedBox.shrink(),
                steps: <Step>[
                  Step(
                    title: SizedBox.shrink(),
                    content: CompletionWidget(),
                    isActive: true,
                  ),
                  const Step(
                    title: Text('Activity 2'),
                    isActive: true,
                    content: Text('Content for Step 2'),
                  ),
                  for (var i = 0; i < 10; i++)
                    Step(
                      title: Text('Upcoming Activity $i'),
                      state: StepState.disabled,
                      content: Text('Content for Step $i'),
                    ),
                ],
              ),
              // CustomCompletedWidget(
              //   activityName: 'Budding',
              //   status: 'Successfully Completed',
              //   date: '12/12/2019',
              // ),
              // CompletionWidget(),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Padding(
              //         padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              //         child: Column(
              //           mainAxisSize: MainAxisSize.max,
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Container(
              //               width: 16,
              //               height: 16,
              //               decoration: BoxDecoration(
              //                 color: Color(0xFFDBE2E7),
              //                 shape: BoxShape.circle,
              //               ),
              //             ),
              //             Container(
              //               width: 2,
              //               height: 100,
              //               decoration: BoxDecoration(
              //                 color: Color(0xFFDBE2E7),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
              //         child: Container(
              //           width: MediaQuery.of(context).size.width * 0.85,
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(8),
              //           ),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 mainAxisSize: MainAxisSize.max,
              //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                 children: [
              //                   Text(
              //                     '14, Sept. 2021',
              //                     style: Style.body1.copyWith(
              //                       color: Color(0xFF95A1AC),
              //                       fontSize: 12,
              //                       fontWeight: FontWeight.normal,
              //                     ),
              //                   ),
              //                   Icon(
              //                     Icons.chevron_right_rounded,
              //                     color: Color(0xFF95A1AC),
              //                     size: 24,
              //                   ),
              //                 ],
              //               ),
              //               Row(
              //                 mainAxisSize: MainAxisSize.max,
              //                 children: [
              //                   Text(
              //                     'Created Invoice',
              //                     style: Style.subtitle2.copyWith(
              //                       color: Color(0xFF151B1E),
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w500,
              //                     ),
              //                   ),
              //                   Padding(
              //                     padding: EdgeInsetsDirectional.fromSTEB(
              //                         4, 0, 0, 0),
              //                     child: Text(
              //                       '#402 - Contractor',
              //                       style: Style.subtitle.copyWith(
              //                         color: Color(0xFF4B39EF),
              //                         fontSize: 18,
              //                         fontWeight: FontWeight.w500,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Padding(
              //                 padding:
              //                     EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              //                 child: Row(
              //                   mainAxisSize: MainAxisSize.max,
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Container(
              //                       width: 30,
              //                       height: 30,
              //                       clipBehavior: Clip.antiAlias,
              //                       decoration: BoxDecoration(
              //                         shape: BoxShape.circle,
              //                       ),
              //                       child: Image.network(
              //                         'https://picsum.photos/seed/252/600',
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: EdgeInsetsDirectional.fromSTEB(
              //                           8, 0, 0, 0),
              //                       child: Text(
              //                         'Andrew F.',
              //                         style: Style.body1.copyWith(
              //                           color: Color(0xFF95A1AC),
              //                           fontSize: 12,
              //                           fontWeight: FontWeight.normal,
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Column(
              //       mainAxisSize: MainAxisSize.max,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Padding(
              //           padding: EdgeInsetsDirectional.fromSTEB(23, 0, 0, 0),
              //           child: Container(
              //             width: 2,
              //             height: 152,
              //             decoration: BoxDecoration(
              //               color: Color(0xFFDBE2E7),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
              //   child: Text(
              //     'Beginning of Activity',
              //     style: Style.subtitle.copyWith(
              //       color: Color(0xFF151B1E),
              //       fontSize: 18,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompletionWidget extends StatelessWidget {
  const CompletionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '14, Sept. 2021',
                style: Style.body1.copyWith(
                  color: Color(0xFF95A1AC),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF95A1AC),
                size: 24,
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Completed ',
                style: Style.subtitle2.copyWith(
                  color: Color(0xFF151B1E),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                child: Text(
                  'Base Plantation',
                  style: Style.subtitle.copyWith(
                    color: Color(0xFF39D2C0),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://picsum.photos/seed/252/600',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Text(
                    'Score : 4.5 / 5',
                    style: Style.body1.copyWith(
                      color: Color(0xFF95A1AC),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCompletedWidget extends StatelessWidget {
  final String status;
  final String activityName;
  final String date;
  //Should list the uploaded files...

  const CustomCompletedWidget({
    Key? key,
    required this.status,
    this.date = '14, Sept. 2021',
    required this.activityName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://picsum.photos/seed/252/600',
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Text(
                    'User Name',
                    style: Style.body1.copyWith(
                      color: Color(0xFF95A1AC),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '21 / 12 / 2012',
                style: Style.body1.copyWith(
                  color: Color(0xFF95A1AC),
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF95A1AC),
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
