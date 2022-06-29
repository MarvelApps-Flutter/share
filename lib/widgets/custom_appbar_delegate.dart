import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double? expandedHeight;
  final bool? isImageShare;
  const CustomSliverAppBarDelegate({this.expandedHeight, this.isImageShare});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var size = 60;
    final top = expandedHeight! - shrinkOffset - size / 2;

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      //overflow: Overflow.visible,
      children: [
        buildBackground(shrinkOffset, context),
        buildAppBar(shrinkOffset, context),
        isImageShare == true
            ? Positioned(
                top: top,
                left: 20,
                right: 20,
                child: buildFloating(shrinkOffset),
              )
            : Container(),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight!;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight!;

  Widget buildAppBar(double shrinkOffset, BuildContext context) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          backgroundColor: Colors.blueAccent.shade700,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            iconSize: 24,
            color: Colors.white,
          ),
          // title: Text(""),
          // centerTitle: true,
        ),
      );

  Widget buildBackground(double shrinkOffset, BuildContext context) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                iconSize: 24,
                color: Colors.white,
              ),
            ),
            Positioned.fill(
              child: Image.network(
                "https://image.tmdb.org/t/p/original/e66tM5YOawXLxhDAfWkR7sxpb3h.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );

  Widget buildFloating(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Card(
          child: Row(
            children: [
              Expanded(
                  child: buildButton(
                text: 'Share',
                icon: Icons.share,
              )),
              //Expanded(child: buildButton(text: 'Like', icon: Icons.thumb_up)),
            ],
          ),
        ),
      );

  Widget buildButton({
    @required String? text,
    @required IconData? icon,
  }) =>
      TextButton(
        child: InkWell(
          onTap: () async {
            print("iiii");
            var request = await HttpClient().getUrl(Uri.parse(
                'https://image.tmdb.org/t/p/original/e66tM5YOawXLxhDAfWkR7sxpb3h.jpg'));
            var response = await request.close();
            Uint8List bytes =
                await consolidateHttpClientResponseBytes(response);
            await Share.file('Share Module', 'share.jpg', bytes, 'image/jpg');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blueAccent.shade700),
              const SizedBox(width: 12),
              Text(text!, style: TextStyle(fontSize: 17, color: Colors.grey)),
            ],
          ),
        ),
        onPressed: () {},
      );

  @override
  double get maxExtent => expandedHeight!;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
