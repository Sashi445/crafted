import 'package:crafted/services/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:crafted/models/downloadable_apps.dart';


class DownloadPage extends StatelessWidget {
  Future<void> _launchUrl(String url) async{
    if(await canLaunch(url)){
      await launch(url);
    }else{
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: FutureBuilder(
          future: Provider.of<DataBase>(context).getDownloadableApps(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              List<App> _apps = snapshot.data;
              return  ListView.builder(
                  itemCount: _apps.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () async{
                          _launchUrl(_apps.elementAt(index).url);
                        },
                        trailing: Icon(Icons.file_download, color: Colors.black, size: 30,),
                        leading: Text('${index + 1}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
                        title: Text(_apps.elementAt(index).appName, style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),),
                        subtitle: Text(_apps.elementAt(index).description, style: GoogleFonts.varelaRound(fontWeight: FontWeight.w500),),
                      ),
                    );
                  }
              );
            }else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),);
            }return Center(child: CircularProgressIndicator(),);
          },
        )
    );
  }
}
