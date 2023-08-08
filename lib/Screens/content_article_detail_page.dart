import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../models/content.dart';
import '../models/content_details.dart';
import '../network_utils/api.dart';

class ContentArticleDetailPage extends StatefulWidget {
  final Contents content;
  const ContentArticleDetailPage({Key? key, required this.content})
      : super(key: key);

  @override
  State<ContentArticleDetailPage> createState() =>
      _ContentArticleDetailPageState();
}

class _ContentArticleDetailPageState extends State<ContentArticleDetailPage> {
  String? filepath;

  @override
  void initState() {
    super.initState();
    _fetchVideoId();
  }

  Future<void> _fetchVideoId() async {
    try {
      ContentDetails contentDetails =
          await ContentDetailsService.getContentDetails(widget.content.id!);

      setState(() {
        filepath = 'http://127.0.0.1:8000/${contentDetails.fileUrl}';
        print(filepath);
      });
    } catch (e) {
      print('Error fetching content details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Content Details'),
        ),
        body: PDFView(
          filePath: filepath ?? '',
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          pageSnap: true,
          defaultPage: 0,
          fitPolicy: FitPolicy.BOTH,
          preventLinkNavigation: false,
          onRender: (pages) {
            print('PDF Pages: $pages');
          },
          onError: (error) {
            print('Error: $error');
          },
          onPageError: (page, error) {
            print('Error on page $page: $error');
          },
          onViewCreated: (PDFViewController controller) {
            // You can use the controller to perform various actions on the PDF view
          },
        ));
  }
}
