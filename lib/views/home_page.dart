import 'package:flutter/material.dart';
import 'package:gapopa/controllers/image_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'dart:async'; // Import dart:async to use Timer
import 'image_grid_view.dart';
import '../controllers/pixabay_api.dart';
import '../models/image_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PixabayApi api = PixabayApi();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<ImageData> images = [];
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
        title: Padding(
          padding:  EdgeInsets.only(
            left: MediaQuery.of(context).size.width/4,
          ),
          child: TextField(

            controller: _searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.red,
              hintText: "Search images",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white),
            ),
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/4),
            child: IconButton(
              icon: Icon(Icons.clear, color: Colors.white,),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
        ],
      ),
      body: images.isNotEmpty
          ? ImageGridView(images: images, controller: _scrollController)
          : Center(child: isLoading ? CircularProgressIndicator() : Text("No images found")),
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
