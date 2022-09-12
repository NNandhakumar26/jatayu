import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jatayu/Widgets/EmptyPage.dart';

class CommentContainer extends StatelessWidget {
  final _hasData = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CommentContainer')),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              child: _hasData == false
                  ? ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.35,
                        ),
                        EmptyPage(
                          icon: Icons.comment,
                          message: 'no comments found',
                          message1: 'Be the first to comment',
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: EdgeInsets.all(15),
                      // controller: controller,
                      physics: AlwaysScrollableScrollPhysics(),
                      // itemCount: _data.length != 0 ? _data.length + 1 : 10,
                      itemCount: 10,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (_, int index) {
                        // if (index < _data.length) {
                        //   // return _commentCard(_data[index]);
                        // }

                        //TODO: DO SOMETHING HERE
                        return Container();
                        // return Opacity(
                        //   opacity: _isLoading ? 1.0 : 0.0,
                        //   child: _lastVisible == null
                        //       ? LoadingCard(height: 100)
                        //       : Center(
                        //           child: SizedBox(
                        //               width: 32.0,
                        //               height: 32.0,
                        //               child: new CupertinoActivityIndicator()),
                        //         ),
                        // );
                      },
                    ),
              onRefresh: () async {
                // onRefreshData();
              },
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black26,
          ),
          // SafeArea(
          //   child: Container(
          //     height: 65,
          //     padding: EdgeInsets.only(top: 8, bottom: 10, right: 20, left: 20),
          //     width: double.infinity,
          //     color: Theme.of(context).primaryColorLight,
          //     child: Container(
          //       decoration: BoxDecoration(
          //           color: Theme.of(context).splashColor,
          //           borderRadius: BorderRadius.circular(25)),
          //       child: TextFormField(
          //         decoration: InputDecoration(
          //             errorStyle: TextStyle(fontSize: 0),
          //             contentPadding:
          //                 EdgeInsets.only(left: 15, top: 10, right: 5),
          //             border: InputBorder.none,
          //             hintText: 'write a comment'.tr(),
          //             suffixIcon: IconButton(
          //               icon: Icon(
          //                 Icons.send,
          //                 size: 20,
          //               ),
          //               onPressed: () {
          //                 handleSubmit();
          //               },
          //             )),
          //         controller: textCtrl,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget _commentCard(Comment d) {
  //   return InkWell(
  //     child: Container(
  //         child: Row(
  //       children: <Widget>[
  //         Container(
  //           alignment: Alignment.bottomLeft,
  //           child: CircleAvatar(
  //             radius: 25,
  //             backgroundColor: Colors.grey[300],
  //             backgroundImage: CachedNetworkImageProvider(d.imageUrl),
  //           ),
  //         ),
  //         Flexible(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Container(
  //                 margin:
  //                     EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 3),
  //                 padding: EdgeInsets.all(15),
  //                 decoration: BoxDecoration(
  //                     //border: Border.all(color: Colors.grey[700], width: 0.5),
  //                     color: Theme.of(context).primaryColorLight,
  //                     borderRadius: BorderRadius.circular(5)),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     Text(
  //                       d.name,
  //                       maxLines: 1,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: TextStyle(
  //                           fontSize: 15, fontWeight: FontWeight.w600),
  //                     ),
  //                     context
  //                             .read<CommentsBloc>()
  //                             .flagList
  //                             .contains(d.timestamp)
  //                         ? Text('comment flagged').tr()
  //                         : Text(
  //                             d.comment,
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.w400,
  //                               color: Theme.of(context).primaryColorDark,
  //                             ),
  //                           ),
  //                   ],
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(left: 15),
  //                 child: Text(
  //                   d.date,
  //                   style: TextStyle(
  //                       fontSize: 11,
  //                       fontWeight: FontWeight.w300,
  //                       color: Colors.grey[600]),
  //                 ),
  //               )
  //             ],
  //           ),
  //         )
  //       ],
  //     )),
  //     onLongPress: () {
  //       // openPopupDialog(d);
  //     },
  //   );
  // }

}
