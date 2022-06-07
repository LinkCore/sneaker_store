import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sneaker_store/common/app_colors.dart';
import 'package:flutter_sneaker_store/common/app_text_styles.dart';
import 'package:flutter_sneaker_store/scenes/gallery/viewer_page.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../generated/l10n.dart';

class AlbumPage extends StatefulWidget {
  final Album album;
  final Function indexes;

  const AlbumPage({Key? key, required this.album, required this.indexes})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => AlbumPageState();
}

class AlbumPageState extends State<AlbumPage> {
  final List<int> _selectedIndex = [];
  final List<File> _selectedFiles = [];

  Future<List<Medium>> initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    return mediaPage.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.of(context).pop()),
            title: Text(widget.album.name ?? S.current.unnamedAlbum),
            elevation: 0,
            actions: [
              IconButton(
                  icon: const Icon(Icons.check, size: 30),
                  onPressed: () async {
                    List<File> base64Files = [];
                    for (var element in _selectedFiles) {
                      base64Files.add(element);
                    }

                    List<FileImage> images = [];
                    for (var element in _selectedFiles) {
                      FileImage image = FileImage(element);
                      images.add(image);
                    }
                    setState(() {
                      widget.indexes(images, base64Files);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  })]),
        body: FutureBuilder<List<Medium>>(
            future: initAsync(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Medium>? data = snapshot.data;
                if (data != null) {
                  return GridView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return ViewerPage(data[index]);
                                })),
                            child: Stack(children: [
                              Positioned.fill(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5.0),
                                      child: Container(
                                          color: Colors.grey[300],
                                          height: MediaQuery.of(context).size.height / 10,
                                          width: MediaQuery.of(context).size.height / 10,
                                          child: FadeInImage(
                                              fit: BoxFit.cover,
                                              placeholder: MemoryImage(kTransparentImage),
                                              image: ThumbnailProvider(
                                                  mediumId: data[index].id,
                                                  mediumType: data[index].mediumType,
                                                  highQuality: true))))),
                              Positioned(
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                          child: Container(
                                              margin: const EdgeInsets.all(3),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: _selectedIndex.contains(index)
                                                      ? AppColors.actionButtonColor
                                                      : Colors.black.withOpacity(0.1),
                                                  border: Border.all(
                                                      color: _selectedIndex.contains(index)
                                                          ? AppColors.actionButtonColor
                                                          : Colors.white, width: 1.5),
                                                  borderRadius: BorderRadius.circular(15)),
                                              child: Visibility(
                                                  child: const Icon(Icons.check),
                                                  visible: _selectedIndex.contains(index))),
                                          onTap: () async {
                                            File file = await data[index].getFile();
                                            if (_selectedIndex.contains(index)) {
                                              setState(() {
                                                _selectedFiles.removeWhere(
                                                    (element) => element.path == file.path);
                                                _selectedIndex.remove(index);
                                              });
                                            } else if (_selectedIndex.length != 4) {
                                              setState(() {
                                                _selectedFiles.add(file);
                                                _selectedIndex.add(index);
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text(
                                                          S.current.youCanChooseOnlyFourPictures,
                                                          style: AppTextStyles.plainTextStyle)));
                                            }})))
                            ]));
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5),
                      itemCount: snapshot.data!.length);
                } else {
                  throw Exception();
                }
              } else {
                return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
              }}));
  }
}