import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medicineinventory/Constants/StringConstants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../Constants/app_constants.dart';

class PdfViewer extends StatefulWidget {
  const PdfViewer({super.key});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(strings.PdfViewTitle)),
        body: SfPdfViewer.file(File(AppConstants.filePath)));

    // return SfPdfViewer.network(
    //   'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
    //   key: _pdfViewerKey,
    // );
  }
}
