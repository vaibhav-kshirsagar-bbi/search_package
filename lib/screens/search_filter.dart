part of search_package;

class SearchFilter extends StatefulWidget {
  final List<TypeModel> typeList;
  const SearchFilter(this.typeList, {Key? key}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomAppBar(



          child: Container(

            child: Padding(

              padding: const EdgeInsets.all(8.0),

              child: Row(

                mainAxisSize: MainAxisSize.max,

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [

                  InkWell(
                    onTap: (){

                      Navigator.of(context).pop();

                    },
                    child: Container(

                      decoration: BoxDecoration(

                        color: const Color(0xff5C5CFF),

                        borderRadius: BorderRadius.circular(12),

                      ),

                      child: Center(child: Text("Cancel",

                        style: TextStyle(

                            color: Colors.white,

                            fontWeight: FontWeight.bold

                        ),

                      )),



                      height: MediaQuery.of(context).size.height * 0.05,

                      width: MediaQuery.of(context).size.width * 0.4,

                    ),
                  ),

                  InkWell(
                    onTap: (){

                      Navigator.of(context).pop();
                      BlocProvider.of<FilterBloc>(context).reloadEvent();

                    },
                    child: Container(

                      decoration: BoxDecoration(

                        color: Color(0xff5C5CFF),

                        borderRadius: BorderRadius.circular(12),

                      ),

                      child: Center(child: Text("Apply",

                        style: TextStyle(

                            color: Colors.white,

                            fontWeight: FontWeight.bold

                        ),

                      )),

                      height: MediaQuery.of(context).size.height * 0.05,

                      width: MediaQuery.of(context).size.width * 0.4,

                    ),
                  )

                ],

              ),

            ),

          )

      ),

      body: Column(
        children: [
          SizedBox(height: 100,),
          Expanded(
            child: SizedBox(
              
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.typeList.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.white54,
                  child: CheckboxListTile(
                    title: Text(widget.typeList[index].name),
                    value: widget.typeList[index].selected,
                    autofocus: false,
                    controlAffinity: ListTileControlAffinity.platform,
                    onChanged: (bool? value) {

                      debugPrint('typeList: ${widget.typeList.toString()}');
                      setState(() {
                        widget.typeList[index].selected = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
