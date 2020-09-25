import 'package:http/http.dart' as http;

class ProdutosApi {
  static Future getProdutos(int pagina) async {

/*
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var host = prefs.getString('hostTexto');
*/

    var url =
        'http://boasvendasonline.com:520/datasnap/rest/TServerMethods1/produtospagina/$pagina/20';
        /*'http://boasvendasonline.com/cadami/servidor_dll.dll/datasnap/rest/TServerMethods1/produtospagina/$pagina/20';*/

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  static Future getProdutosPesq(int pagina, String pesquisa) async {

/*    SharedPreferences prefs = await SharedPreferences.getInstance();
    var host = prefs.getString('hostTexto');*/

    var url =
        'http://boasvendasonline.com:520/datasnap/rest/TServerMethods1/produtospagina/token/$pagina/20/$pesquisa';
        /*'http://boasvendasonline.com/cadami/servidor_dll.dll/datasnap/rest/TServerMethods1/produtospagina/$pagina/20/$pesquisa';*/

    var response = await http.get(url);

    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }



}