import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsAndUpdatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News and Updates'),
      ),
      // body: StreamBuilder(
      //   //stream: FirebaseFirestore.instance.collection('news').snapshots(),
      //   stream: FirebaseFirestore.instance
      //       .collection('news')
      //       .orderBy('timestamp', descending: true)
      //       .snapshots(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //
      //     var newsList = snapshot.data!.docs;
      //
      //     return ListView.builder(
      //       itemCount: newsList.length,
      //       itemBuilder: (context, index) {
      //         var newsItem = newsList[index].data();
      //         return Card(
      //           margin: EdgeInsets.all(8.0),
      //           child: ListTile(
      //             title: Text(newsItem['title']),
      //             subtitle: Text(newsItem['content']),
      //             trailing: Text(newsItem['timestamp'].toString()),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
      body: Column(
        children: [
          AnyLinkPreview(
            link: "https://cupofjo.com/2023/10/04/my-favorite-fall-outfits-are-black-and-white/",
            displayDirection: UIDirection.uiDirectionHorizontal,
            showMultimedia: false,
            bodyMaxLines: 5,
            bodyTextOverflow: TextOverflow.ellipsis,
            titleStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
            errorBody: 'Show my custom error body',
            errorTitle: 'Show my custom error title',
            errorWidget: Container(
              color: Colors.grey[300],
              child: Text('Oops!'),
            ),
            errorImage: "https://google.com/",
            cache: Duration(days: 7),
            backgroundColor: Colors.grey[300],
            borderRadius: 12,
            removeElevation: false,
            boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
            onTap: (){}, // This disables tap event
          ),

          AnyLinkPreview(
            link: "https://feedly.com/i/subscription/feed%2Fhttp%3A%2F%2Ffeeds.feedburner.com%2Fpalsolidarity",
            displayDirection: UIDirection.uiDirectionHorizontal,
            showMultimedia: false,
            bodyMaxLines: 5,
            bodyTextOverflow: TextOverflow.ellipsis,
            titleStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
            errorBody: 'Show my custom error body',
            errorTitle: 'Show my custom error title',
            errorWidget: Container(
              color: Colors.grey[300],
              child: Text('Oops!'),
            ),
            errorImage: "https://google.com/",
            cache: Duration(days: 7),
            backgroundColor: Colors.grey[300],
            borderRadius: 12,
            removeElevation: false,
            boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
            onTap: (){}, // This disables tap event
          ),

          AnyLinkPreview(
            link: "https://www.bornfitness.com/what-is-a-calorie/",
            displayDirection: UIDirection.uiDirectionHorizontal,
            showMultimedia: false,
            bodyMaxLines: 5,
            bodyTextOverflow: TextOverflow.ellipsis,
            titleStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
            errorBody: 'Show my custom error body',
            errorTitle: 'Show my custom error title',
            errorWidget: Container(
              color: Colors.grey[300],
              child: Text('Oops!'),
            ),
            errorImage: "https://google.com/",
            cache: Duration(days: 7),
            backgroundColor: Colors.grey[300],
            borderRadius: 12,
            removeElevation: false,
            boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
            onTap: (){}, // This disables tap event
          ),

          AnyLinkPreview(
            link: "https://www.bornfitness.com/how-to-fix-muscle-imbalances/",
            displayDirection: UIDirection.uiDirectionHorizontal,
            showMultimedia: false,
            bodyMaxLines: 5,
            bodyTextOverflow: TextOverflow.ellipsis,
            titleStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
            errorBody: 'Show my custom error body',
            errorTitle: 'Show my custom error title',
            errorWidget: Container(
              color: Colors.grey[300],
              child: Text('Oops!'),
            ),
            errorImage: "https://google.com/",
            cache: Duration(days: 7),
            backgroundColor: Colors.grey[300],
            borderRadius: 12,
            removeElevation: false,
            boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
            onTap: (){}, // This disables tap event
          ),

          AnyLinkPreview(
            link: "https://www.bornfitness.com/sentenced-to-life/",
            displayDirection: UIDirection.uiDirectionHorizontal,
            showMultimedia: false,
            bodyMaxLines: 5,
            bodyTextOverflow: TextOverflow.ellipsis,
            titleStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            bodyStyle: TextStyle(color: Colors.grey, fontSize: 12),
            errorBody: 'Show my custom error body',
            errorTitle: 'Show my custom error title',
            errorWidget: Container(
              color: Colors.grey[300],
              child: Text('Oops!'),
            ),
            errorImage: "https://google.com/",
            cache: Duration(days: 7),
            backgroundColor: Colors.grey[300],
            borderRadius: 12,
            removeElevation: false,
            boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey)],
            onTap: (){}, // This disables tap event
          ),
        ],
      ),
    );
  }
}
