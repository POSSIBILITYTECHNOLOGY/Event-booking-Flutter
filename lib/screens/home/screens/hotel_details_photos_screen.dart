import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_booking/utils/loader.dart';
import 'package:event_booking/utils/widgets/common_Widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeDetailPhotos extends StatelessWidget {
  final List? imagesList;
  final String? image;

  const HomeDetailPhotos({
    super.key,
    required this.imagesList,
    this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: const CommonBackButtom(),
        backgroundColor: Colors.black,
        // backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SizedBox(
          width: Get.width,
          child: imagesList!.isEmpty
              ? SizedBox(
                  height: 350,
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: NetworkImage(image!),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  child: InteractiveViewer(
                    panEnabled: false, // Set it to false
                    // boundaryMargin: const EdgeInsets.all(100),
                    minScale: 1,
                    maxScale: 3,
                    child: Image.network(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ))
              : SingleChildScrollView(
                  // physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GridView.custom(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        physics: const ScrollPhysics(),

                        // semanticChildCount: controller.imgListPhotos.length,
                        semanticChildCount: imagesList!.length,
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: [
                            const QuiltedGridTile(2, 2),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 1),
                            const QuiltedGridTile(1, 2),
                          ],
                        ),
                        padding: const EdgeInsets.only(bottom: 20),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: imagesList!.length,
                          // childCount: controller.imgListPhotos.length,
                          // childCount: controller.imgList.length,
                          (context, index) => InkWell(
                              onTap: () {
                                Get.to(() => ImageZoomView(
                                      url: imagesList![index]['image'],
                                      urlList: imagesList!,
                                      tappedPhotoIndex: index,
                                    ));
                              },
                              child: CachedNetworkImage(
                                imageUrl: imagesList![index]['image'],
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: Loader()),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              )
                              // Image.network(
                              //   // controller.imgListPhotos[index],
                              //   // controller.hotelPhotos[index]['url_1440'],
                              //   // controller.hotelPhotos[index]['url_square60'],
                              //   imagesList![index]['image'],
                              //   fit: BoxFit.cover,
                              // ),
                              ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class ImageZoomView extends StatelessWidget {
  final String url;
  final List<dynamic> urlList;
  final int tappedPhotoIndex;
  const ImageZoomView({
    required this.url,
    required this.urlList,
    required this.tappedPhotoIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const CommonBackButtom(),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: SizedBox(
          // decoration: const BoxDecoration(color: Colors.red),
          // height: double.infinity,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: CarouselSlider.builder(
              itemCount: urlList.length,
              itemBuilder: (BuildContext? context, int index, int pageIndex) {
                return InteractiveViewer(
                  panEnabled: false,
                  minScale: 0.1,
                  maxScale: 3,
                  child: Center(
                      child: CachedNetworkImage(
                    imageUrl: urlList[index]["image"],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(child: Loader()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )

                      // Image.network(
                      //   urlList[index]["image"],
                      //   fit: BoxFit.cover,
                      //   height: 380,
                      // ),
                      ),
                );
              },
              options: CarouselOptions(
                viewportFraction: 1,
                initialPage: tappedPhotoIndex,
                aspectRatio: 0.7,
                enlargeCenterPage: false,
                // padEnds:
                //     false, // take full width, remove padding from all size
                onPageChanged: (index, reason) {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
