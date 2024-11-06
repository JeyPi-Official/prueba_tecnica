import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_tecnica/pages/photo_page.dart';
import 'package:prueba_tecnica/services/unsplash_service.dart';
import 'package:prueba_tecnica/widgets/photo_card.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({super.key});

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMorePhotos();
    }
  }

  Future<void> _loadMorePhotos() async {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      final photos = await Provider.of<UnsplashProvider>(context, listen: false)
          .searchPhotos("nature", _currentPage);
      setState(() {
        _isLoading = false;
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final unsplashProvider = Provider.of<UnsplashProvider>(context);
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: unsplashProvider.photos.length + (_isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == unsplashProvider.photos.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final photo = unsplashProvider.photos[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PhotoPage(),
              ),
            );
          },
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black45,
              title: Text(photo.titulo),
            ),
            child: Image.network(photo.imageUrl, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
