import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gapopa/core/clients/index.dart';
import 'package:gapopa/core/extensions/index.dart';
import 'package:gapopa/features/image_gallery/controllers/image_controller.dart';
import 'package:gapopa/features/image_gallery/models/image_model.dart';
import 'package:gapopa/features/image_gallery/views/widgets/image_grid_view_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PixabayClient api = PixabayClient();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<ImageModel> images = [];
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _fetchImages();
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  void _fetchImages() async {
    if (isLoading) return;
    setState(() { isLoading = true; });

    var fetchedImages = await api.fetchImages(_searchController.text, page);
    setState(() {
      if (page == 1) images.clear();
      images.addAll(fetchedImages);
      Get.find<ImageController>(

      ).images = images;
      isLoading = false;
      page++;
    });
  }


  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _fetchImages();
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_searchController.text == "") {
        images.clear();
        page = 1;
        _fetchImages();  // Reset to initial state when search field is cleared
      } else {
        page = 1;  // Reset pagination on new search
        _fetchImages();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           SizedBox(
             width: context.screenWidth/4,
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search images",
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.white,),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ],
        ),
      ),
      body: images.isNotEmpty
          ? ImageGridViewWidget(images: images, controller: _scrollController)
          : Center(child: isLoading ? const CircularProgressIndicator() : const Text("No images found")),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}



