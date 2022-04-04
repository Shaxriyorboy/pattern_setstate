import 'package:flutter/material.dart';
import 'package:pattern_setstate/models/post_model.dart';

import '../services/http_service.dart';
class DetailPage extends StatefulWidget {
  static const String id = "/detail_page";
  Post? post;
  DetailPage({Key? key,this.post}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void _apiEdit(){
    String title = titleController.text;
    String body = bodyController.text;
    if(widget.post != null){
      Post post = Post(id: widget.post!.id,title: title,body: body,userId: widget.post!.userId);
      Network.PUT(Network.API_UPDATE+post.id.toString(), Network.paramsUpdate(post)).then((value){
      });
    }
  }

  void _apiCreate(){
    String title = titleController.text;
    String body = bodyController.text;
    if(widget.post != null){
      Post post = Post(title: title,body: body,userId: title.hashCode);
      Network.POST(Network.API_CREATE.toString(), Network.paramsCreate(post)).then((value){
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.post != null){
      titleController.text = widget.post!.title!;
      bodyController.text = widget.post!.body!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detaile Page"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              if(widget.post != null){
                _apiEdit();
              }else{
                _apiCreate();
              }
              setState(() {});
              Navigator.of(context).pop(true);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Title",
              ),
            ),
            TextFormField(
              controller: bodyController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Body",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
