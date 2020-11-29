import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GetVoiceCommand extends StatefulWidget {
  GetVoiceCommand({Key key}) : super(key: key);

  _GetVoiceCommandState createState() => _GetVoiceCommandState();
}

class _GetVoiceCommandState extends State<GetVoiceCommand> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Center(
        child: RaisedButton(
          child: Text("我要喊话"),
          onPressed: () async {
            const url = "https://red.hulian100.cn/ui/#!/0";
            if (await canLaunch(url)) {
              await launch(url, forceWebView: true, enableJavaScript: true, enableDomStorage: true);
            } else {
              throw "Could not launch $url";
            }
          },
        ),
      ),
    );
  }
}
