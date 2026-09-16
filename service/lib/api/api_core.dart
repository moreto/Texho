enum ApiCore {
  cep('/73252200/json/', 'https://viacep.com.br/ws', 'https://viacep.com.br/ws', false);

  const ApiCore(this.endpoint, this.des, this.prd, this.isLogged);
  final String endpoint;
  final String des;
  // final String hm;
  final String prd;
  final bool isLogged;
}
