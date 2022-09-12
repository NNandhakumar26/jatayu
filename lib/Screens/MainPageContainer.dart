import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Network/data_fetching.dart';
import 'package:jatayu/Screens/custom_future_builder.dart';
import 'package:lottie/lottie.dart';

import 'package:async/async.dart';

import 'package:jatayu/Theme.dart';

class MainPageContainer extends StatefulWidget {
  @override
  State<MainPageContainer> createState() => _MainPageContainerState();
}

class _MainPageContainerState extends State<MainPageContainer> {
  final _closeMemo = AsyncMemoizer();

  Future<List<Quotes>> close() async {
    return await _closeMemo.runOnce(
      () async {
        return await Network.getAllQuotes();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: Get.height / 6.5,
          left: Get.width / 5,
          child: Opacity(
            opacity: 0.2,
            child: RoundedLogoCard(),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                // height: 16,
                height: Get.height / 28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Opacity(
                  opacity: 0.18,
                  child: Lottie.asset(
                    'assets/json/leaves.json',
                    animate: true,
                    repeat: true,
                    height: 160,
                    width: 240,
                  ),
                ),
              ),
              CustomFutureBuilder<List<Quotes>>(
                onSuccessWidget: (data) => Container(
                  height: 160,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    margin: EdgeInsets.all(16),
                    elevation: 4,
                    borderOnForeground: true,
                    color: Colors.white.withOpacity(0.90),
                    shadowColor: Style.nearlyDarkBlue.withOpacity(0.60),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: DefaultTextStyle(
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: Style.subtitle.copyWith(
                                fontStyle: FontStyle.italic,
                                wordSpacing: 0.8,
                                letterSpacing: 0.8,
                                color: Style.darkText.withOpacity(0.87),
                              ),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  ...data.map(
                                    (e) => FadeAnimatedText(e.quote),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: 250.0,
                            child: DefaultTextStyle(
                              textAlign: TextAlign.right,
                              style: Style.subtitle.copyWith(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      ...data.map(
                                        (e) => FadeAnimatedText(
                                          '~ ${e.author}',
                                          textStyle: Style.subtitle.copyWith(
                                            color: Style.nearlyDarkBlue
                                                .withOpacity(0.87),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w600,
                                            wordSpacing: 0.8,
                                            letterSpacing: 0.8,
                                            // color: Style.darkText
                                            //     .withOpacity(0.87),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                futureFunction: Network.getAllQuotes(),
              ),
              // FutureBuilder<List<Quotes>>(
              //   future: close(),
              //   builder: (context, AsyncSnapshot<List<Quotes>> snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return CircularProgressIndicator();
              //     }
              //     if (snapshot.connectionState == ConnectionState.done) {
              //       return Container(
              //         height: 160,
              //         alignment: Alignment.center,
              //         margin: EdgeInsets.symmetric(horizontal: 12),
              //         child: Card(
              //           margin: EdgeInsets.all(16),
              //           elevation: 4,
              //           borderOnForeground: true,
              //           color: Colors.white.withOpacity(0.90),
              //           shadowColor: Style.nearlyDarkBlue.withOpacity(0.60),
              //           child: Padding(
              //             padding: EdgeInsets.all(16),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 SizedBox(
              //                   width: double.infinity,
              //                   child: DefaultTextStyle(
              //                     textAlign: TextAlign.center,
              //                     maxLines: 4,
              //                     overflow: TextOverflow.ellipsis,
              //                     style: Style.subtitle.copyWith(
              //                       fontStyle: FontStyle.italic,
              //                       wordSpacing: 0.8,
              //                       letterSpacing: 0.8,
              //                       color: Style.darkText.withOpacity(0.87),
              //                     ),
              //                     child: AnimatedTextKit(
              //                       repeatForever: true,
              //                       animatedTexts: [
              //                         ...snapshot.data!.map(
              //                           (e) => FadeAnimatedText(e.quote),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 8,
              //                 ),
              //                 SizedBox(
              //                   width: 250.0,
              //                   child: DefaultTextStyle(
              //                     textAlign: TextAlign.right,
              //                     style: Style.subtitle.copyWith(),
              //                     maxLines: 1,
              //                     overflow: TextOverflow.ellipsis,
              //                     child: Row(
              //                       mainAxisAlignment: MainAxisAlignment.end,
              //                       children: [
              //                         AnimatedTextKit(
              //                           repeatForever: true,
              //                           animatedTexts: [
              //                             ...snapshot.data!.map(
              //                               (e) => FadeAnimatedText(
              //                                 '~ ${e.author}',
              //                                 textStyle:
              //                                     Style.subtitle.copyWith(
              //                                   color: Style.nearlyDarkBlue
              //                                       .withOpacity(0.87),
              //                                   fontStyle: FontStyle.italic,
              //                                   fontWeight: FontWeight.w600,
              //                                   wordSpacing: 0.8,
              //                                   letterSpacing: 0.8,
              //                                   // color: Style.darkText
              //                                   //     .withOpacity(0.87),
              //                                 ),
              //                               ),
              //                             )
              //                           ],
              //                         ),
              //                         SizedBox(
              //                           width: 8,
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     }
              //     return Text('Nothing fits in here');
              //   },
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

class RoundedLogoCard extends StatelessWidget {
  const RoundedLogoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: CircleBorder(side: BorderSide.none),
      borderOnForeground: true,
      shadowColor: Style.nearlyDarkBlue.withOpacity(0.60),
      clipBehavior: Clip.antiAlias,
      color: Style.nearlyWhite,
      child: CircleAvatar(
        maxRadius: 110.0,
        backgroundColor: Style.nearlyWhite,
        foregroundImage: AssetImage('assets/images/jatayu.png'),
      ),
    );
  }
}

class Quotes {
  String quote;
  String author;

  Quotes({
    required this.quote,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'author': author,
    };
  }

  factory Quotes.fromMap(Map<String, dynamic> map) {
    return Quotes(
      quote: map['quote'] ?? '',
      author: map['author'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Quotes.fromJson(String source) => Quotes.fromMap(json.decode(source));

  @override
  String toString() => 'Quotes(quote: $quote, author: $author)';
}
