import 'dart:convert';

import 'package:binary_numbers_company/models/movie_api_response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApplicationModel extends ChangeNotifier{

  Future<MovieAPIResponseModel> getMovieList() async{
    var response = await http.get(Uri.parse("http://www.omdbapi.com/?i=tt3896198&apikey=c4033450&s=Movies"));
    if(response.statusCode == 200){
      return MovieAPIResponseModel.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception("Cannot fetch movie list. Status code: ${response.statusCode}");
    }

  }
}