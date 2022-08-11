import 'package:demo_bloc_ku/modules/kuapp/blocs/list_link_bloc.dart';
import 'package:demo_bloc_ku/modules/kuapp/models/link.dart';
import 'package:demo_bloc_ku/modules/kuapp/pages/game_page.dart';
import 'package:demo_bloc_ku/modules/kuapp/pages/game_screen.dart';
import 'package:demo_bloc_ku/modules/kuapp/pages/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _linkBloc = ListLinkRxDartBloc();
  Links? mlinks;
  String zoneName = "";
  @override
  void initState(){
    super.initState();
    _linkBloc.getLinks();
    DateTime dateTime = DateTime.now();
    zoneName = dateTime.timeZoneName;
  }
  void _eventButton(BuildContext context,String url){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>WebviewPage(url: url,),
        ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<Links>(
          stream: _linkBloc.linksStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              Links? links = snapshot.data;
              mlinks = links;
              return  Center(
                child: Column(
                  children:  [
                    const SizedBox(height: 20.0,),
                    Image.asset('assets/images/kubet2.png'
                      ,width: 200
                      ,height: 200,),
                    const SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.only(left: 60,right: 60),
                      child: ElevatedButton(onPressed: (){
                        String home = "";
                        int a = zoneName.compareTo("+07");
                        a == 0? home = links?.linkHome??"null":home = links?.linkPolicy??"null";
                        _eventButton(context,home);
                        print(links?.linkHome??"null");
                      },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)
                          )
                        ),
                          child: const Text('Trang chu',
                          style: TextStyle(fontSize: 19),
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.only(left: 60,right: 60),
                      child: ElevatedButton(onPressed: (){
                        _eventButton(context,links?.linkHelp??"null");

                      },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)
                              )
                          ),
                          child: const Text('Ho tro 24/7',
                            style: TextStyle(fontSize: 19),
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.only(left: 60,right: 60),
                      child: ElevatedButton(onPressed: (){
                        _eventButton(context,links?.linkPolicy??"null");

                      },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)
                              )
                          ),
                          child: const Text('Policy',
                            style: TextStyle(fontSize: 19),
                          )
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      margin: const EdgeInsets.only(left: 60,right: 60),
                      child: ElevatedButton(onPressed: (){
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context)=> const GameScreenPage(),
                        ),
                        );
                      },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)
                              )
                          ),
                          child: const Text('Play',
                            style: TextStyle(fontSize: 19),
                          )
                      ),
                    ),
                  ],
                ),
              );
            }
            if(snapshot.hasError){
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              )
            );
          }
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.chat_bubble_outlined),
          onPressed: (){
            print(mlinks?.linkZalo??"null");
            Uri uriZalo = Uri.parse(mlinks?.linkZalo??"null");
            _openBrowerUrl(uriZalo);

          },
        ),
      ),
    );
  }
  Future<void> _openBrowerUrl(Uri url)async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url,mode: LaunchMode.externalNonBrowserApplication);
    }
  }
}
