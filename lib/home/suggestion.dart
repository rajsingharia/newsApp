import 'package:api/home/specificNews.dart';
import 'package:flutter/material.dart';

class Suggestion extends StatefulWidget {
  Suggestion({Key key}) : super(key: key);

  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  var category = {
    "general",
    "entertainment",
    "Sports",
    "business",
    "technology",
    "health",
    "science",
  };
  var image = {
    "https://image.freepik.com/free-vector/top-headlines-news-themem-background_1017-14199.jpg",
    "https://scontent.fdel13-1.fna.fbcdn.net/v/t1.0-1/27459580_195474694377081_6522770594776514568_n.png?_nc_cat=101&_nc_sid=dbb9e7&_nc_ohc=lkKO-lYXXkEAX9PkRO1&_nc_ht=scontent.fdel13-1.fna&oh=01cad5f7c024c17205f300d5c70d186b&oe=5F23042D",
    "https://tcmedianouvelles.ca/wp-content/uploads/sites/75/2019/01/sports-news-300x169.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTIYB5bZhz6BURSM2zFbAwOfz8-LOJBzkaQOg&usqp=CAU",
    "https://www.nttdata.com/th/en/-/media/nttdataapac/common-images/foresight/technology-trend---the-current-status-of-open-api-technology-and-new-trend-towards-open-banking/the-current-status-of-open-api-technology-and-new-trend-towards-open-banking_imgcontent-1024x683.jpg?h=683&la=en-TH&w=1024&hash=662C97307F78326BD1AAA5E0CACF8E2EEA048705",
    "https://images.pexels.com/photos/588561/pexels-photo-588561.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://image.shutterstock.com/image-photo/hands-touching-science-network-connection-260nw-762804589.jpg",
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return specificNews(cat: category.elementAt(index));
                  }));
                },
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: NetworkImage(image.elementAt(index)),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: 40,
                        width: 100,
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              category.elementAt(index),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            )),
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class SpeificNews {}
