import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jatayu/Theme.dart';
import 'package:lottie/lottie.dart';

class LeaderBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Style.nearlyDarkBlue.withOpacity(0.87),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/leaderBackground.jpg'),
                    opacity: 0.6,
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Style.nearlyDarkBlue,
                    width: 0.32,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 12,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //TODO:CHECK HERE
                          // DropDownMenuFb1(
                          //   menuList: [
                          //     const PopupMenuItem(
                          //       child: ListTile(
                          //         leading:
                          //             Icon(Icons.add, color: Color(0xff4338CA)),
                          //         title: Text('Add video'),
                          //       ),
                          //     ),
                          //     const PopupMenuDivider(),
                          //     const PopupMenuItem(child: Text('Settings')),
                          //     const PopupMenuItem(
                          //         child: Text('More Information')),
                          //   ],
                          // ),
                          Text(
                            'LeaderBoard',
                            style: Style.subtitle.copyWith(
                              fontFamily: Style.fontName,
                              color: Colors.white.withOpacity(0.80),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                              fontSize: 18,
                            ),
                          ),
                          CustomDropDown(
                            listOfItems: [
                              'Classwise',
                              'Schoolwise',
                              'Plant-Category',
                              'Activity'
                            ],
                            selectedItem: 'Classwise',
                            voidCallBack: (value) {},
                          ),
                          // Icon(
                          //   Icons.search_rounded,
                          //   color: Colors.black54,
                          // )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Stack(
                      children: [
                        firstno(context),
                        secondno(context),
                        thirdno(context)
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        elevation: 4,
                        // shadowColor: Colors.black26,
                        shadowColor: Style.nearlyDarkBlue.withOpacity(0.16),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: CircleAvatar(
                                radius: 24.0,
                                backgroundColor: Style.nearlyDarkBlue,
                                child: CircleAvatar(
                                  radius: 23.0,
                                  backgroundColor: Colors.grey[200],
                                  backgroundImage: AssetImage(
                                    'assets/images/girl.jpg',
                                  ),
                                ),
                              ),
                            ),
                            dense: false,
                            minLeadingWidth: 0,
                            trailing: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Style.nearlyDarkBlue.withOpacity(0.16),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '250.0 Pts',
                                style: TextStyle(
                                  fontFamily: Style.fontName,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Style.nearlyDarkBlue,
                                ),
                              ),
                            ),
                            title: FittedBox(
                              fit: BoxFit.contain,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${(index + 4).toString()} . Nandha Kumar',
                                        textAlign: TextAlign.left,
                                        style: Style.title.copyWith(
                                          color: Style.darkerText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'Good going',
                                        textAlign: TextAlign.left,
                                        style: Style.subtitle.copyWith(
                                          color:
                                              Style.lightText.withOpacity(0.60),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget firstno(context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 4.5),
            height: 100,
            width: 100,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white70,
            ),
            child: CircleAvatar(
              // foregroundImage: CachedNetworkImageProvider(
              //   listCat[0]["image"],
              // ),
              foregroundImage: AssetImage('assets/images/girl.jpg'),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 45),
            padding: EdgeInsets.only(bottom: 34),
            height: 145,
            width: 164,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Lottie.asset(
                'assets/json/winner.json',
                // repeat: false,
                reverse: true,
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 132),
            child: Text(
              'Priya',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  Widget secondno(context) {
    return Container(
      margin: EdgeInsets.only(
        right: (MediaQuery.of(context).size.width / 2) + 40,
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 56),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white60,
                shape: BoxShape.circle,
              ),
              height: 80,
              width: 80,
              child: CircleAvatar(
                // foregroundImage: CachedNetworkImageProvider(
                //   listCat[0]["image"],
                // ),
                foregroundImage: AssetImage('assets/images/girl.jpg'),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 120),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://smartkit.wrteam.in/smartkit/images/two.png",
                  fit: BoxFit.cover,
                  width: 35,
                  height: 25,
                ),
              )),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 156.0),
              child: Text(
                'Second',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget thirdno(context) {
    return Container(
      margin:
          EdgeInsets.only(left: (MediaQuery.of(context).size.width / 2) + 40),
      child: Stack(
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 56),
              height: 80,
              width: 80,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white54,
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                // foregroundImage: CachedNetworkImageProvider(
                //   listCat[0]["image"],
                // ),
                foregroundImage: AssetImage('assets/images/girl.jpg'),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 120),
              child: Center(
                child: CachedNetworkImage(
                  imageUrl:
                      "https://smartkit.wrteam.in/smartkit/images/three.png",
                  fit: BoxFit.cover,
                  width: 35,
                  height: 25,
                ),
              )),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 156.0),
              child: Text(
                'Third',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropDown extends StatefulWidget {
  final List<String> listOfItems;
  final String selectedItem;
  final voidCallBack;

  CustomDropDown({
    required this.listOfItems,
    required this.selectedItem,
    required this.voidCallBack,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 120,
      // margin: EdgeInsets.symmetric(vertical: 2,),
      padding: EdgeInsets.symmetric(
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white.withOpacity(0.60),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonFormField<String>(
        iconEnabledColor: Style.nearlyDarkBlue.withOpacity(0.87),
        style: Style.overline.copyWith(
          letterSpacing: 0.2,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Style.nearlyDarkBlue,
        ),
        hint: Text(
          'Select',
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: Style.overline.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Style.nearlyDarkBlue.withOpacity(0.32),
          ),
        ),

        value: widget.selectedItem,
        isExpanded: true,
        validator: (value) => value == null ? 'Cannot Be Null' : null,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        items: widget.listOfItems.map(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  style: Style.caption.copyWith(
                    color: Style.nearlyDarkBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ).toList(),
        onChanged: (value) {},
        // onChanged: widget.voidCallBack,
      ),
    );
  }
}

// Padding customDropDown() {}
class DropDownMenuFb1 extends StatelessWidget {
  final List<PopupMenuEntry> menuList;
  final Color color;
  final Widget icon;
  const DropDownMenuFb1(
      {required this.menuList,
      this.color = Colors.white,
      this.icon = const Icon(
        Icons.more_vert,
        color: Color(0xff4338CA),
      ),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: color,
      icon: icon,
      itemBuilder: (BuildContext context) => menuList,
    );
  }
}
