import 'package:flutter/material.dart';
import 'package:my_flutter_app_dl/network_utils/api.dart';

import './add_content_page.dart';
import '../models/content.dart';
import 'content_article_detail_page.dart';
import 'content_detail_page.dart';
import 'menu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Contents> _contentsList = [];
  @override
  void initState() {
    super.initState();
    // Load contents when the widget is initialized
    _loadContents();
  }

  Future<void> _loadContents() async {
    try {
      List<Contents> contentsList = await DashboardServices.teacherDashboard();
      setState(() {
        _contentsList = contentsList;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //final contents = Contents.map(() => {}).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: _contentsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contentsList.length,
              itemBuilder: (context, index) {
                final content = _contentsList[index];
                return GestureDetector(
                  onTap: () {
                    content.cntType == 3
                        ? (
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContentDetailsPage(content: content),
                              ),
                            ),
                          )
                        : (
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ContentArticleDetailPage(content: content),
                              ),
                            ),
                          );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    color: Colors.white,
                    child: ListTile(
                      leading: content.cntType == 3
                          ? const Icon(Icons.video_library, color: Colors.blue)
                          : const Icon(Icons.article, color: Colors.blue),
                      title: Text(
                        content.cntTitle ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        content.cntChapter ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                        ),
                      ),

                      trailing: Text(
                        'Class: ${content.cntClass ?? ''}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                      // Display cntClass as a subtitle
                      // You can add other properties to display here, if needed
                    ),
                  ),
                );
              },
            ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          backgroundColor: Colors.blue,
          heroTag: 'Add',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddContentPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ]),
      drawer: const Menu(),
    );
  }
}
