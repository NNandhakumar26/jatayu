import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/modals/Activity.dart';
import 'package:jatayu/Theme.dart';

class IndividualActivity extends StatelessWidget {
  final Activity thisActivity;
  IndividualActivity({
    required this.thisActivity,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              SizedBox.expand(
                child: Image(
                  image: CachedNetworkImageProvider(
                    thisActivity.image ?? '',
                  ),
                  height: Get.height,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    color: Colors.white54,
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              thisActivity.title ?? '',
                              style: Style.title.copyWith(
                                fontFamily: Style.fontName,
                                color: Colors.white.withOpacity(0.72),
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.white60,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 24,
                                ),
                                Icon(
                                  Icons.share_rounded,
                                  color: Colors.white60,
                                  size: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          thisActivity.desc ?? '',
                          style: Style.subtitle.copyWith(
                            fontFamily: Style.fontName,
                            color: Colors.white60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
