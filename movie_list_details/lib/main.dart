

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list_details/movies.dart';

void main() {
  runApp(MoviesListView());
}

class MoviesListView extends StatelessWidget {
  final List<Movie> movielist = Movie.getMovies();
  final List Movies = [
    'Airlift ',
    'Aiyaary',
    'Bhaag Milkha Bhaag',
    'Ghazi attack',
    'Kesari',
    'Lakshya',
    'Parmanu: The Story of Pokhran',
    'Rustom',
    'Shershaah',
    'Uri: The Surgical Strike'
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Movies')),
          backgroundColor: Colors.blueGrey.shade900,
        ),
        backgroundColor: Colors.blueGrey.shade400,
        body: ListView.builder(
            itemCount: movielist.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Moviecard(movielist[index], context),
                  Positioned(
                    top: 10,
                    child: movieImage(movielist[index].poster),
                  ),
                ],
              );
            }),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

Widget Moviecard(Movie movie, BuildContext context) {
  return InkWell(
    child: Container(
      margin: EdgeInsets.only(left: 60),
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: Card(
        color: Colors.black45,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 54),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Text(
                      movie.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Rating : ${movie.rated}",
                    style: mainTextStyle(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(' ${movie.released}', style: mainTextStyle()),
                  Text(
                    movie.runtime,
                    style: mainTextStyle(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieListViewDetails(
                  movie: movie,
                ))),
  );
}

TextStyle mainTextStyle() {
  return TextStyle(
    fontSize: 15,
    color: Colors.grey,
  );
}

Widget movieImage(String ImageUrl) {
  return Container(
    margin: EdgeInsets.only(left: 4),
    width: 100,
    height: 100,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(ImageUrl ??
                'https://media.istockphoto.com/vectors/male-profile…=0&h=fLLvwEbgOmSzk1_jQ0MgDATEVcVOh_kqEe0rqi7aM5A='),
            fit: BoxFit.cover)),
  );
}

class MovieListViewDetails extends StatelessWidget {
  final Movie movie;

  const MovieListViewDetails({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(movie.title)),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
          MovieDetailsThumbnail(
            thumbnail: movie.images[1],
          ),
          MovoeDetailsHeaderWithPoster(movie: movie),
          HorizontalLine(),
          MovieDetailsCast(movie: movie),
          HorizontalLine(),
          MovieDetailsWithextraPoster(
            poster: movie.images
          ),
        ],
      ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  final String thumbnail;

  const MovieDetailsThumbnail({Key? key, required this.thumbnail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(thumbnail), fit: BoxFit.cover)),
            ),
            Icon(
              Icons.play_circle_outline,
              size: 100,
              color: Colors.white70,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          height: 80,
        ),
      ],
    );
  }
}

class MovoeDetailsHeaderWithPoster extends StatelessWidget {
  final Movie movie;

  const MovoeDetailsHeaderWithPoster({Key? key, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          MoviePoster(
            Poster: movie.images[0],
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: MovieDetailsHeader(
              movie: movie,
            ),
          )
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String Poster;

  const MoviePoster({Key? key, required this.Poster}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(Poster), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  final Movie movie;

  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${movie.year} . rated : ${movie.rated}'.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan),
        ),
        Text(
          movie.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32,
          ),
        ),
        Text.rich(TextSpan(
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
          children: [
            TextSpan(text: movie.plot),
            TextSpan(
                text: "More.......",
                style: TextStyle(color: Colors.indigoAccent))
          ],
        ))
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {
  final Movie movie;

  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieFields(
            field: 'Cast ',
            value: movie.actors,
          ),
          MovieFields(field: 'Director', value: movie.director),
          MovieFields(field: 'Awards', value: movie.awards),
        ],
      ),
    );
  }
}

class MovieFields extends StatelessWidget {
  final String field;
  final String value;

  const MovieFields({Key? key, required this.field, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w200,
            fontSize: 12,
          ),
        ),
        Expanded(
            child: Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ))
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        height: 0.5,
        color: Colors.black,
      ),
    );
  }
}

class MovieDetailsWithextraPoster extends StatelessWidget {
  final List<String> poster;

  const MovieDetailsWithextraPoster({Key? key, required this.poster})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0,),
          child: Text(
            "More Movie Pictures......".toUpperCase(),
            style: TextStyle( fontSize: 14,color: Colors.black,),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
height: 170,
padding: EdgeInsets.symmetric(vertical: 16),



child: ListView.separated(
  scrollDirection: Axis.horizontal,
  separatorBuilder: (context,index)=> SizedBox(width: 8,),
  itemCount: poster.length,
  itemBuilder: (context,index) => ClipRRect(
    borderRadius:BorderRadius.all(Radius.circular(10)
  ),
  child: Container(
    width: MediaQuery.of(context).size.width / 4 ,
    height: 160,
    decoration: BoxDecoration(
      image: DecorationImage(
          image: NetworkImage(poster[index]),
          fit: BoxFit.cover,
      )
    ),
  ),
          ),
          ),),
        ),
      ],
    );
  }
}
