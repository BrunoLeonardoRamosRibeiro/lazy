class Produto {
  String codigo;
  String codigobarras;
  String produto;
  String pesquisa;
  String preco;
  String unidade;
  String codigocategoria;
  String imagem;
  String records;

  Produto(
      {this.codigo,
        this.codigobarras,
        this.produto,
        this.pesquisa,
        this.preco,
        this.unidade,
        this.codigocategoria,
        this.imagem,
        this.records});

  Produto.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    codigobarras = json['codigobarras'];
    produto = json['produto'];
    pesquisa = json['pesquisa'];
    preco = json['preco'];
    unidade = json['unidade'];
    codigocategoria = json['codigocategoria'];
    imagem = json['imagem'];
    records = json['records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['codigobarras'] = this.codigobarras;
    data['produto'] = this.produto;
    data['pesquisa'] = this.pesquisa;
    data['preco'] = this.preco;
    data['unidade'] = this.unidade;
    data['codigocategoria'] = this.codigocategoria;
    data['imagem'] = this.imagem;
    data['records'] = this.records;
    return data;
  }
}
