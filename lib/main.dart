import 'package:flutter/material.dart';
import 'package:lazy/produto.dart';
import 'package:lazy/produto_api.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Lazy Load'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Produto> produtos = new List<Produto>();

  List<Produto> data = [];
  int currentLength = 0;
  final int increment = 10;

  int pagina = 0;
  String pesquisa = '';

  bool isLoading = false;
  bool isSearching = false;

  @override
  void initState() {
    _loadMore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(produtos.length);

    return Scaffold(
      appBar: AppBar(
        //title: Text("Lazy Loading $pagina"),
        elevation: 2,
        title: Text("Lazy Loading $pagina"),
        actions: <Widget>[
          IconButton(
            icon: Icon(isSearching ? Icons.cancel : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          ),
        ],
        bottom: isSearching
            ? PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    onSubmitted: (texto) {
                      setState(() {
                        pagina = 0;
                        produtos.clear();
                        data = [];
                        pesquisa = texto;
                        isSearching = false;
                      });
                      _loadMore();
                    },
                    cursorColor: Colors.white,

                    //controller: controller,
                    //focusNode: focusNode,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    decoration: InputDecoration(
//                      fillColor: Colors.white,
//                      filled: false,
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
/*                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),*/
                      border: InputBorder.none,
                      labelText: "Pesquisar",
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: "digite sua pesquisa",
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding: const EdgeInsets.only(
                        left: 16,
                        right: 20,
                        top: 14,
                        bottom: 14,
                      ),
                    ),
                  ),
                ),
              )
            : null,
      ),
      body: LazyLoadScrollView(
        isLoading: isLoading,
        onEndOfPage: () => _loadMore(),
        child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (content, position) {
//            print("======== TAMANHO DO DADO ========");
//            print("tamanho->>>> ${data.length}");
//            print("records: ${data[position].records}");
//            print("posição: $position");

            if (data.length == int.parse(data[position].records) &&
                isLoading &&
                position == data.length) {
              return null;
            } else {
              if (isLoading && position == data.length) {
                return Center(child: CircularProgressIndicator());
              } else {
                return displayCardItem(data[position]);
              }
            }
          },
        ),
      ),
    );
  }

  Future _loadMore() async {
    setState(() {
      isLoading = true;
      pagina++;
    });

    ProdutosApi.getProdutosPesq(pagina, pesquisa).then((response) {
      if (response != null) {
        setState(() {
          Iterable lista = json.decode(response.body);
          produtos = lista.map((model) => Produto.fromJson(model)).toList();

          for (var item in produtos) data.add(item);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Widget displayCardItem(Produto data) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80,
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                data.codigo + ' - ' + data.produto,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            /*Container(
              child: Stack(
                children: <Widget>[
                  Image.network('https://images.pexels.com/photos/1713953/pexels-photo-1713953.jpeg'),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
