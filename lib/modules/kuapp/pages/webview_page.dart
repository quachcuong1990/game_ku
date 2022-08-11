import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebviewPage extends StatefulWidget {
  String? url;
  WebviewPage({Key? key, this.url}) : super(key: key);

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final _key = UniqueKey();
  var _url;
  @override
  void initState() {
    _url = widget.url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color:
              Colors.black,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: WebView(
            key: _key,
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: _url,
          ),
        ),
      ),
    );
  }
}
