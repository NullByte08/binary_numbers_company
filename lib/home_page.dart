import 'package:binary_numbers_company/models/application_model.dart';
import 'package:binary_numbers_company/models/movie_api_response_model.dart';
import 'package:binary_numbers_company/models/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late Future<MovieAPIResponseModel> fetchMovieList;
  MovieAPIResponseModel? _movieAPIResponseModel;
  bool apiCalledOnce = false;
  bool initializedOnce = false;
  int currentIndexOfBNB = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<String> dummyText = ["Favourites", "Bookmark", "Menu"];

  @override
  Widget build(BuildContext context) {
    if (!apiCalledOnce) {
      apiCalledOnce = true;
      fetchMovieList = Provider.of<ApplicationModel>(context, listen: false).getMovieList();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double screenWidth = constraints.maxWidth;
        return Scaffold(
          key: _key,
          endDrawer: const Drawer(
            child: Center(
              child:Text("Drawer"),
            ),
          ),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: currentIndexOfBNB == 0
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.1,
                          ),
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.red,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("Chelsie Brett"),
                          const Spacer(),
                          Container(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.05,
                            color: Colors.grey[900],
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                ),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _tabController.animateTo(0);
                              });
                            },
                            child: _tabController.index == 0
                                ? Container(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.055,
                                    decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(5), boxShadow: [
                                      BoxShadow(color: Colors.pink[400]!, blurRadius: 1, spreadRadius: 2),
                                    ]),
                                    child: Center(
                                      child: Text(
                                        "Movies",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: screenWidth * 0.25,
                                    height: screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Movies",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _tabController.animateTo(1);
                              });
                            },
                            child: _tabController.index == 1
                                ? Container(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.055,
                                    decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(5), boxShadow: [
                                      BoxShadow(color: Colors.pink[400]!, blurRadius: 1, spreadRadius: 2),
                                    ]),
                                    child: Center(
                                      child: Text(
                                        "Shows",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: screenWidth * 0.25,
                                    height: screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Shows",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _tabController.animateTo(2);
                              });
                            },
                            child: _tabController.index == 2
                                ? Container(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.055,
                                    decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(5), boxShadow: [
                                      BoxShadow(color: Colors.pink[400]!, blurRadius: 1, spreadRadius: 2),
                                    ]),
                                    child: Center(
                                      child: Text(
                                        "Music",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: screenWidth * 0.25,
                                    height: screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900],
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Music",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        child: FutureBuilder<MovieAPIResponseModel>(
                          future: fetchMovieList,
                          builder: (context,snapshot) {

                            if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                              if (!initializedOnce) {
                                initializedOnce = true;
                                _movieAPIResponseModel = snapshot.data;
                              }
                            }

                            return TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _tabController,
                                children: [
                                  snapshot.hasError
                                      ? Center(
                                          child: Text(snapshot.error.toString()),
                                        )
                                      : (snapshot.connectionState == ConnectionState.done && snapshot.data != null)
                                          ? Container(
                                              height: screenHeight * 0.6,
                                              width: screenWidth,
                                              padding: const EdgeInsets.only(left: 20),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "NEW",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight * 0.3,
                                                      width: screenWidth,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: _movieAPIResponseModel!.search.length,
                                                        itemBuilder: (context, index) {
                                                          return MovieCard(
                                                            screenWidth: screenWidth,
                                                            screenHeight: screenHeight,
                                                            imageUrl: _movieAPIResponseModel!.search[index].poster,
                                                            title: _movieAPIResponseModel!.search[index].title,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      "POPULAR",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight * 0.3,
                                                      width: screenWidth,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: _movieAPIResponseModel!.search.length,
                                                        itemBuilder: (context, index) {
                                                          return MovieCard(
                                                            screenWidth: screenWidth,
                                                            screenHeight: screenHeight,
                                                            imageUrl: _movieAPIResponseModel!.search[index].poster,
                                                            title: _movieAPIResponseModel!.search[index].title,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      "TRENDING",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight * 0.3,
                                                      width: screenWidth,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: _movieAPIResponseModel!.search.length,
                                                        itemBuilder: (context, index) {
                                                          return MovieCard(
                                                            screenWidth: screenWidth,
                                                            screenHeight: screenHeight,
                                                            imageUrl: _movieAPIResponseModel!.search[index].poster,
                                                            title: _movieAPIResponseModel!.search[index].title,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const Center(child: CircularProgressIndicator()),
                                  snapshot.hasError
                                      ? Center(
                                          child: Text(snapshot.error.toString()),
                                        )
                                      : (snapshot.connectionState == ConnectionState.done && snapshot.data != null)
                                          ? Container(
                                              height: screenHeight * 0.6,
                                              width: screenWidth,
                                              padding: const EdgeInsets.only(left: 20),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "NEW",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight * 0.3,
                                                      width: screenWidth,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: _movieAPIResponseModel!.search.length,
                                                        itemBuilder: (context, index) {
                                                          return MovieCard(
                                                            screenWidth: screenWidth,
                                                            screenHeight: screenHeight,
                                                            imageUrl: _movieAPIResponseModel!.search[index].poster,
                                                            title: _movieAPIResponseModel!.search[index].title,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      "POPULAR",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight * 0.3,
                                                      width: screenWidth,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index) {
                                                          return MovieCard(
                                                            screenWidth: screenWidth,
                                                            screenHeight: screenHeight,
                                                            imageUrl: _movieAPIResponseModel!.search[index].poster,
                                                            title: _movieAPIResponseModel!.search[index].title,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      "TRENDING",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight * 0.3,
                                                      width: screenWidth,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index) {
                                                          return MovieCard(
                                                            screenWidth: screenWidth,
                                                            screenHeight: screenHeight,
                                                            imageUrl: _movieAPIResponseModel!.search[index].poster,
                                                            title: _movieAPIResponseModel!.search[index].title,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const Center(child: CircularProgressIndicator()),
                                  snapshot.hasError
                                      ? Center(
                                          child: Text(snapshot.error.toString()),
                                        )
                                      : (snapshot.connectionState == ConnectionState.done && snapshot.data != null)
                                          ? Container(
                                              height: screenHeight * 0.6,
                                              width: screenWidth,
                                              padding: const EdgeInsets.only(left: 20),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      "NEW",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight * 0.3,
                                                      width: screenWidth,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount: _movieAPIResponseModel!.search.length,
                                                        itemBuilder: (context, index) {
                                                          return MovieCard(
                                                            screenWidth: screenWidth,
                                                            screenHeight: screenHeight,
                                                            imageUrl: _movieAPIResponseModel!.search[index].poster,
                                                            title: _movieAPIResponseModel!.search[index].title,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      "POPULAR",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight * 0.3,
                                                      width: screenWidth,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index) {
                                                          return MovieCard(
                                                            screenWidth: screenWidth,
                                                            screenHeight: screenHeight,
                                                            imageUrl: _movieAPIResponseModel!.search[index].poster,
                                                            title: _movieAPIResponseModel!.search[index].title,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    const Text(
                                                      "TRENDING",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: screenHeight * 0.3,
                                                      width: screenWidth,
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemBuilder: (context, index) {
                                                          return MovieCard(
                                                            screenWidth: screenWidth,
                                                            screenHeight: screenHeight,
                                                            imageUrl: _movieAPIResponseModel!.search[index].poster,
                                                            title: _movieAPIResponseModel!.search[index].title,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : const Center(child: CircularProgressIndicator()),
                                ],
                              );
                            }
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(dummyText[currentIndexOfBNB - 1]),
                  ),
          ),
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.grey[900],
              onTap: (index) {
                setState(() {
                  if(index != 3) {
                    currentIndexOfBNB = index;
                  }
                });
                if(index == 3){
                  _key.currentState!.openEndDrawer();
                }
              },
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              currentIndex: currentIndexOfBNB,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.grey[800]!,
                  ),
                  activeIcon: const Icon(
                    Icons.home,
                    color: Colors.pink,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star,
                    color: Colors.grey[800]!,
                  ),
                  activeIcon: const Icon(
                    Icons.star,
                    color: Colors.pink,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark,
                    color: Colors.grey[800]!,
                  ),
                  activeIcon: const Icon(
                    Icons.bookmark,
                    color: Colors.pink,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.grey[800]!,
                  ),
                  activeIcon: const Icon(
                    Icons.menu,
                    color: Colors.pink,
                  ),
                  label: "",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(title: title, url: imageUrl)));
      },
      child: Container(
        width: screenWidth * 0.4,
        height: screenHeight * 0.3,
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.red,
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
