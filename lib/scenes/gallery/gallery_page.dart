import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

import '../auth/widgets/bootom_sheet_anchor.dart';
import 'album_page.dart';

class GalleryPage extends StatefulWidget {
  final Function indexes;

  const GalleryPage({Key? key, required this.indexes}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<Album> _albums = [];

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
      await PhotoGallery.listAlbums(mediumType: MediumType.image);
      setState(() {
        _albums = albums;
      });
    }
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
        await Permission.storage.request().isGranted &&
        await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.66,
        expand: false,
        maxChildSize: 0.66,
        builder: (BuildContext builder, ScrollController scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35), topLeft: Radius.circular(35)),
              color: AppColors.backgroundColor,
            ),
            child: Column(
              children: [
                const BottomSheetAnchor(margin: EdgeInsets.only(left: 165, right: 165, bottom: 10, top: 10)),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return AlbumPage(
                                indexes: widget.indexes, album: _albums[index]);
                          })),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    color: Colors.grey[300],
                                    height:
                                    MediaQuery.of(context).size.height / 10,
                                    width:
                                    MediaQuery.of(context).size.height / 10,
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      placeholder:
                                      MemoryImage(kTransparentImage),
                                      image: AlbumThumbnailProvider(
                                        albumId: _albums[index].id,
                                        mediumType: _albums[index].mediumType,
                                        highQuality: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: AppColors.backgroundColor,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    height:
                                    MediaQuery.of(context).size.height / 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            _albums[index].name ??
                                                "Unnamed Album",
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            _albums[index].count.toString(),
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: _albums.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
