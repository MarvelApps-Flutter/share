import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_module/constants/string_constants.dart';
import 'package:flutter_share_module/model/casts_model.dart';
import 'package:flutter_share_module/model/screenshots_model.dart';
import 'package:flutter_share_module/utils/star_display.dart';
import 'package:flutter_share_module/widgets/custom_appbar_delegate.dart';

class ShareTextScreen extends StatefulWidget {
  final bool? isPersistentHeader;
  final bool?  isShareImageVisible;
  final bool? isShareTextVisible;
  final bool? isShareTextWithImage;
  const ShareTextScreen(
      {Key? key,
        this.isPersistentHeader,
      this.isShareImageVisible,
      this.isShareTextVisible,
      this.isShareTextWithImage})
      : super(key: key);

  @override
  _ShareTextScreenState createState() => _ShareTextScreenState();
}

class _ShareTextScreenState extends State<ShareTextScreen> {
  Size? size;

  @override
  void initState() {
    super.initState();
    print("widget.isShareImageVisible is ${widget.isShareImageVisible}");
    print("widget.isShareTextVisible is ${widget.isShareTextVisible}");
    print("widget.isShareTextWithImage is ${widget.isShareTextWithImage}");
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: body(),
        floatingActionButton: buildFloatingButton());
  }

  Widget body() {
    return CustomScrollView(
      slivers: <Widget>[
      SliverPersistentHeader(
          delegate: CustomSliverAppBarDelegate(expandedHeight: 300, isImageShare: widget.isShareImageVisible),
          pinned: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "THE BATMAN",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Rubik'),
                      textAlign: TextAlign.center,
                    ),
                    widget.isShareTextWithImage == true ? IconButton(onPressed: () async {
                      print("share icon");
                      var request = await HttpClient().getUrl(Uri.parse('https://image.tmdb.org/t/p/original/e66tM5YOawXLxhDAfWkR7sxpb3h.jpg'));
                      var response = await request.close();
                      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
                      await Share.file('Share Module', 'share.jpg', bytes, 'image/jpg',text: "The Batman");
                    },
                        icon: Icon(Icons.share)) : Container(),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Adventure,Family and Fantasy",
                  style: TextStyle(
                    color: Colors.black54,
                    fontFamily: 'NeueHaasDisplay',
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Align(
                alignment: Alignment.center,
                child: IconTheme(
                  data: IconThemeData(
                    //color: Colors.red,
                    size: 20,
                  ),
                  child: StarDisplay(value: 4),
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Year',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'NeueHaasDisplay',
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          "2019",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NunitoSans',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Country',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'NeueHaasDisplay',
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          "USA",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NunitoSans',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Length',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'NeueHaasDisplay',
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          '118 min',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'NunitoSans',
                          ),
                        ),
                      ],
                    ),
                  ]),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 2),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Story line',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Rubik'),
                          ),
                          widget.isShareTextVisible == true? IconButton(onPressed: () async {
                            print("share icon");

                              final url = 'https://www.themoviedb.org/';
                              Share.text(StringConstants.storyline, '${StringConstants.storyline} $url', 'text/plain');

                          }, icon: Icon(Icons.share , color: Colors.black54,)) : Container()
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Container(
                  //height: 35,
                  child: Text(
                    StringConstants.storyline,
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black54,
                        //  fontWeight: FontWeight.w600,
                        fontFamily: 'NeueHaasDisplay'),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Row(
                  children: [
                    Text(
                      'Screenshots',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Rubik'),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Container(
                  height: 155,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => VerticalDivider(
                      color: Colors.transparent,
                      width: 5,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: screenshotImageList.length,
                    itemBuilder: (context, index) {
                      // Backdrop image =
                      // backdropList[index];
                      return Container(
                        child: Card(
                          elevation: 3,
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://image.tmdb.org/t/p/w500${screenshotImageList[index]}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Text(
                  'Casts',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Rubik'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                child: Container(
                  height: 110,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => VerticalDivider(
                      color: Colors.transparent,
                      width: 5,
                    ),
                    itemCount: castImageList.length,
                    itemBuilder: (context, index) {
                      //Cast cast = castList[index];
                      return Container(
                        child: Column(
                          children: <Widget>[
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              elevation: 3,
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                  'https://image.tmdb.org/t/p/w200${castImageList[index].imageName}',
                                  imageBuilder: (context, imageBuilder) {
                                    return Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100)),
                                        image: DecorationImage(
                                          image: imageBuilder,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/img_not_found.jpg'),
                                          ),
                                        ),
                                      ),
                                ),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  castImageList[index].name!,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 8,
                                      fontFamily: 'NeueHaasDisplay'),
                                ),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  castImageList[index].character!,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 8,
                                      fontFamily: 'NeueHaasDisplay'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  FloatingActionButton buildFloatingButton() {
    return FloatingActionButton(
        elevation: 0.0,
        child: const Icon(Icons.favorite),
        backgroundColor: Colors.blueAccent.shade700,
        onPressed: () {});
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.blueAccent.shade700,
      expandedHeight: 300,
      // shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(40))),
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          // borderRadius:
          //     const BorderRadius.vertical(bottom: Radius.circular(40)),
          child: Image.network(
            "https://image.tmdb.org/t/p/original/e66tM5YOawXLxhDAfWkR7sxpb3h.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
