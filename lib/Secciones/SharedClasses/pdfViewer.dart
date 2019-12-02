import 'package:flutter/material.dart';

import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:tecmas/Temas/BaseTheme.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


class pdfViewer extends StatefulWidget {
  String fromURL;
  String fromAsset;


  pdfViewer({this.fromURL='', this.fromAsset=''});

  @override
  _pdfViewerState createState() => _pdfViewerState(fromURL: fromURL, fromAsset: fromAsset);

}

class _pdfViewerState extends State<pdfViewer> {


  bool _isLoading=true;
  PDFDocument Document;

  String fromURL;
  String fromAsset;


  _pdfViewerState({this.fromURL='', this.fromAsset=''});

  void loadDocument() async{





    if(fromURL!=''){
      try{
        Document= await PDFDocument.fromURL(fromURL);
      }catch(e){

      }

    }else{
      Document= await PDFDocument.fromAsset(fromAsset);
    }

    setState(() {
      _isLoading=false;
    });

    



  }

  @override
  void initState() {

    super.initState();
    loadDocument();
  }

  bool networkerror=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          children:<Widget>[
               _isLoading ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: Document, showPicker: true, showIndicator: true, showNavigation: true,indicatorBackground: BaseThemeColor_DarkBlue,),

            Positioned(
                right: 20,
                bottom: 50.0,
                child: new Container(


                  child: FlatButton(
                      color: BaseThemeColor_DarkBlue,
                      shape: CircleBorder(),
                      child: Icon(Icons.refresh, color: Colors.white,size: 30,),
                        onPressed: (){
                          DefaultCacheManager().removeFile(fromURL);
                          Future.delayed(Duration(milliseconds: 100),(){
                            setState(() {
                            _isLoading=true;
                            });
                            loadDocument();
                          }
                          );
                        }
                )
            )


            )
          ]
      ),



    );
  }
}

