class Header {
  static final Map<String, String> _header = {
    'Access-Control-Allow-Origin': 'true',
    'Access-Control-Allow-Methods': '*',
    'Access-Control-Allow-Headers': '*',
    'Content-Type': 'application/json; charset=UTF-8',
    'Charset': 'utf-8',
    'x-token': '31d2f29a1660086bbe71f58dd3af4af3',
    'x-interface': 'App',
  };

  static Map<String, String> buildHeadersLoggedUser() {
    // String jwToken = LoginSession.getLoginModel().accessToken!;
    final Map<String, String> header = <String, String>{};
    // header.addAll({'x-token': jwToken});
    header.addAll({'x-token': ''});
    header.addAll({'x-user': '1'});
    // header.addAll({'x-user': LoginSession.getLoginModel().usuario!.usuaId.toString()});
    header.addAll(_header);
    return header;
  }

  static Map<String, String> buildHeaders() {
    final Map<String, String> header = <String, String>{};
    header.addAll({'x-token': '0'});
    header.addAll({'x-user': '0'});
    header.addAll(_header);
    return header;
  }
}
