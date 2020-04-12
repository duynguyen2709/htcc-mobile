import 'package:flutter/material.dart';

class InfoLine extends StatelessWidget {
  final String title;
  final String content;
  final TextStyle textStyle;

  const InfoLine({Key key, this.title, this.content, this.textStyle = const TextStyle(fontSize: 16)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Text(
              "$title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Flexible(
              flex: 2,
              child: Text(
                ": " + content,
                style: textStyle,
                maxLines: 100,
              ))
        ],
      ),
    );
  }
}

class ChatFormCard extends StatelessWidget {
  final String title;
  final List<String> content;
  final List<String> response;
  final String avatar;

  const ChatFormCard({Key key, this.title, this.content, this.response, this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChatLine> listChatLine = List();

    for (int i = 0; i < content.length; i++) {
      listChatLine.add(ChatLine(
        content: content[i],
        avatar: avatar,
      ));
      if (response.length > i)
        listChatLine.add(ChatLine(
          content: response[i],
          isResponse: true,
          avatar: avatar,
        ));
    }

    return Card(
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Column(
                children: listChatLine,
              ),
            ],
          )),
    );
  }
}

class ChatLine extends StatelessWidget {
  final String content;

  final bool isResponse;

  final String avatar;

  ChatLine({this.content, this.isResponse = false, this.avatar});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isResponse ? Alignment.centerRight : Alignment.centerLeft,
      child: !isResponse
          ? Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: (avatar == null)
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue[700]),
                                child: Center(
                                    child: Text(
                                  "M",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 5, bottom: 5, right: 15),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[200],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(50)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/gif/loading.gif',
                                    image: avatar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Bạn",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            content,
                            textAlign: TextAlign.start,
                            maxLines: 50,
                          )
                        ],
                      ),
                    )
                  ],
                ),
            ),
          )
          : Card(elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Hệ thống",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            content,
                            textAlign: TextAlign.start,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5,top: 5, left: 15),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red[700]),
                        child: Center(
                            child: Text(
                          "S",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ],
                ),
            ),
          ),
    );
  }
}
