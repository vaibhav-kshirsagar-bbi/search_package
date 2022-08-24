part of search_package;




class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchBox = TextEditingController();

  Future<List<Model>> _loadData() async {
    final gtsJson = await rootBundle.loadString('assets/gts.json');

    final gtsData = jsonDecode(gtsJson) as List<dynamic>;

    return gtsData.map((e) => Model.fromJson(e)).toList();
  }

  String searchText = '';

  List<Model> _allEntries = [];

  List<TypeModel> typeList = [];
  List<String> typeListString = [];

  @override
  initState() {
    _loadData().then((value) {
      for (var model in value) {
        for (var type in model.type) {
          if (!typeListString.contains(type)) {
            typeListString.add(type);
            typeList.add(TypeModel(type));
          }
        }
      }
      setState(() {
        _allEntries = value;
      });


    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context) => FilterBloc(),

      child: BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) {

          List checkBoxFilter=[];

          for (var element in typeList) {
            if (element.selected == true) {
              checkBoxFilter.add( element.name);
            }
          }

          var filteredItems = _allEntries.where((element) {

            bool check=true;

            if(checkBoxFilter.isNotEmpty ){
              check=  element.type.toSet().intersection(checkBoxFilter.toSet()).isEmpty?false:true;
            }

            return element.text.toLowerCase().contains(searchText) &&  check;

          }).toList();


          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black38,
              title: const Text(
                "Search",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                    onPressed: () {

                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SearchFilter(typeList)
                      );
                    },
                    icon: const Icon(
                      Icons.filter_list_rounded,
                      color: Colors.black,
                    )),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Padding(
                  padding:
                  const EdgeInsets.only(bottom: 20.0, left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18.0),
                          child: SizedBox(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 1.5,
                            height: 50,
                            child: TextField(
                              controller: searchBox,

                              decoration: InputDecoration(
                                  hintText: 'Search',

                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        // debugPrint(searchBox.text);
                                        searchBox.text = '';
                                        searchText = '';
                                      });
                                    },
                                    child: const Icon(
                                        Icons.cancel
                                    ),
                                  )
                              ),
                              onChanged: (value) {

                                setState(() {
                                  searchText = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();

                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
            body: Scaffold(
              body: Container(
                color: Colors.white,
                child: Padding(

                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Expanded(
                        child: filteredItems.isNotEmpty
                            ? ListView.builder(

                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                              .onDrag,
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) =>
                              Card(

                                color: Colors.white,
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10),
                                child: ListTile(
                                  title: Text(filteredItems[index].chapterName),
                                  subtitle: const Text("@guidelines"),
                                ),
                              ),
                        )
                            : const Text(
                          'No results found',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
