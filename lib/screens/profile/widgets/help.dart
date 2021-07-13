import 'package:flutter/material.dart';


class HelpWidget extends StatefulWidget {
  @override
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends State<HelpWidget> {


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
            length:3,
            child: SafeArea(
                          child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                  bottom: TabBar(
                    tabs: List.generate(3, (index) {
                      return Tab(text: 'Category $index');
                    }),
                    labelColor: Theme.of(context).primaryColor,
                  ),
                  title: Text(
                   'FAQ',
                    style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
                  ),
                  // actions: <Widget>[
                  //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).primaryColor, labelColor: Theme.of(context).accentColor),
                  // ],
                ),
                body: TabBarView(
                  children: List.generate(3, (index) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          // SearchBarWidget(),
                          SizedBox(height: 15),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            leading: Icon(
                              Icons.help,
                              color: Theme.of(context).hintColor,
                            ),
                            title: Text(
                              'Help Support',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: 5,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15);
                            },
                            itemBuilder: (context, indexFaq) {
                              return FaqItemWidget(index: indexFaq,);
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
  }
}



class FaqItemWidget extends StatelessWidget {
 int index;
 FaqItemWidget({this.index});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.green.withOpacity(0.15),
          offset: Offset(0, 5),
          blurRadius: 15,
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration:
                BoxDecoration(color: Theme.of(context).focusColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: Text(
              'Question $index',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.only(bottomRight: Radius.circular(5), bottomLeft: Radius.circular(5))),
            child: Text(
              'Answer $index',
              style: Theme.of(context).textTheme.bodyText2.copyWith(color:Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
