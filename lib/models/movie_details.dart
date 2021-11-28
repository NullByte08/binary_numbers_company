import 'package:flutter/material.dart';

class MovieDetails extends StatefulWidget {
  final String title;
  final String url;

  const MovieDetails({Key? key, required this.title, required this.url}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.url,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Text(widget.title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  color: Colors.grey[900],
                  padding: const EdgeInsets.all(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
