import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:yt_popular/models/vdsSearcher.dart';
import 'common.dart';

class SearchUi extends StatefulWidget {
  @override
  _SearchUiState createState() => _SearchUiState();
}

class _SearchUiState extends State<SearchUi> {
  final queryCtrl = TextEditingController();
  int stackToShow = 0; //0=blank, 1=search result

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    queryCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            //text field
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: TextField(
                autofocus: true,
                controller: queryCtrl,
                decoration: InputDecoration(
                  focusColor: Colors.redAccent,
                  fillColor: Colors.redAccent,
                  prefixIcon: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    ),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      queryCtrl.text = '';
                    },
                    child: Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                  hintText: 'Search any videos...',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onSubmitted: (val) async {
                  //if the keyword was not provided, show dialog
                  if (queryCtrl.text == '') {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('No keyword entered!'),
                        content: const Text(
                            'Please provide a keyword to search. You haven\'t typed any keyword.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'OK',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  //keyword provided
                  else {
                    //change stack if the current one is blank one
                    if (stackToShow == 0) {
                      setState(() {
                        stackToShow = 1;
                      });
                    }
                    //search vds
                    await context
                        .read<VdsSearcher>()
                        .searchVideos(queryCtrl.text);
                  }
                },
              ),
            ),
            //result list
            Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                child: IndexedStack(
                  index: stackToShow,
                  children: [
                    //blank
                    Text(''),
                    //search result
                    SearchResultUi(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //display videos list from var at model vdsSearcher
    final VdsSearcher vs = context.watch<VdsSearcher>();
    final String r = vs.loadResult;
    //loaded
    if (r == '1') {
      //vds list
      return ListView.builder(
        itemCount: vs.vds.length + 1,
        itemBuilder: (BuildContext context, int i) {
          //last item
          if (i == vs.vds.length) {
            return Padding(
              padding: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Center(
                child: LoadMoreBtn(),
              ),
            );
          }
          //else, normal list item
          int index = i;
          return YtVdItem(vs.vds[index]);
        },
      );
    }
    //loading
    else if (r == 'l') {
      return Center(
        child: MyProgressIndicator(''),
      );
    }
    //no result
    else if (r == 'nsr') {
      return Center(
        child: DescTxt('No result', true),
      );
    }
    //error
    else {
      return Center(
          child: ErrorMessage(
        //lead, desc, icon, myan
        'Error',
        'Cannot search videos: $r',
        Icons.error,
        false,
      ));
    }
  }
}

class LoadMoreBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final VdsSearcher vs = context.watch<VdsSearcher>();
    final String r = vs.loadMoreResult;
    //should show
    if (vs.nextPageToken != null) {
      //initial or loaded
      if (r == '1') {
        return InkWell(
          onTap: () async {
            vs.searchMoreVideos();
          },
          child: ActionButton(Icons.more_horiz, 'Load more videos'),
        );
      }
      //loading
      else if (r == 'l') {
        return MyProgressIndicator('Loading...');
      }
      //no more videos
      else if (r == 'nmv') {
        return DescTxt('You are all caught up! Take a rest :)', true);
      }
      //err
      else {
        return DescTxt('Error: $r', true);
      }
    }
    //no more videos
    else {
      return Text('');
    }
  }
}
