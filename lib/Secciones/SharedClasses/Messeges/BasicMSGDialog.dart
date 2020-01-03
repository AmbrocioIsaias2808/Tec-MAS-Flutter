import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class BasicMSGDialog extends StatefulWidget {

  final int MessegeType;
  final String imagelocation;
  final bool fromNetwork;
  final String Title;
  final String Description;
  final String ButtonText;
  final dynamic ButtonColor;
  final Function  ButtonAction;
  final dynamic ButtonTextColor;
  final dynamic DescriptionTextColor;
  final dynamic TitleTextColor;


  BasicMSGDialog({this.MessegeType=0, this.imagelocation="", this.fromNetwork=false, this.Title="Dialog", this.Description="Description", this.ButtonText="OK", this.ButtonAction=null,this.ButtonColor=Colors.green, this.ButtonTextColor=Colors.black, this.DescriptionTextColor=Colors.black, this.TitleTextColor=Colors.black});

  @override
  _BasicMSGDialogState createState() => _BasicMSGDialogState(MessegeType: MessegeType, imagelocation: imagelocation, fromNetwork: fromNetwork, Title: Title, Description: Description, ButtonText: ButtonText, ButtonAction: ButtonAction, ButtonColor: ButtonColor,ButtonTextColor: ButtonTextColor,DescriptionTextColor: DescriptionTextColor, TitleTextColor: TitleTextColor);
}

class _BasicMSGDialogState extends State<BasicMSGDialog> {

  final int MessegeType;
  String imagelocation;
  final bool fromNetwork;
  final String Title;
  final String Description;
  final String ButtonText;
  final dynamic ButtonColor;
  final Function  ButtonAction;
  final dynamic ButtonTextColor;
  final dynamic DescriptionTextColor;
  final dynamic TitleTextColor;

  /*MessegeType=1: */static const String wifierrorImage="assets/Imagenes/wifierror.gif";
  /*MessegeType=2: */static const String error404Image="assets/Imagenes/404Error.gif";
  /*MessegeType=3: */static const String InternalErrorImage="assets/Imagenes/internalError.gif";
  /*MessegeType=4: */static const String LoadingImage="assets/Imagenes/loading.gif";
  _BasicMSGDialogState({this.MessegeType=0, this.imagelocation="", this.fromNetwork=false, this.Title="Dialog", this.Description="Description", this.ButtonText="OK", this.ButtonAction=null,this.ButtonColor=Colors.green, this.TitleTextColor=Colors.black, this.DescriptionTextColor=Colors.black, this.ButtonTextColor=Colors.black});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(MessegeType==1){
      imagelocation=wifierrorImage;
    }else if(MessegeType==2){
      imagelocation=InternalErrorImage;
    }else if(MessegeType==3){
      imagelocation=error404Image;
    }else if(MessegeType==4){
      imagelocation=LoadingImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AssetGiffyDialog(
      image: fromNetwork? Image.network(imagelocation): Image.asset(imagelocation),
      title: Text(Title,
        style: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.w600, color: TitleTextColor),
      ),
      description: Text(Description,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: DescriptionTextColor),
      ),
      entryAnimation: EntryAnimation.DEFAULT,
      onlyOkButton: true,
      onOkButtonPressed: ButtonAction,
      buttonOkText: Text(ButtonText, style: TextStyle(color: ButtonTextColor)),
      buttonOkColor: ButtonColor,
    );
  }
}
