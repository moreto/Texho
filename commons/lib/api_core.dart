import 'package:commons/commons.dart';

enum HeaderType { minimal, basicInfo, loggedArea }

const String kDesHost = 'http://192.168.1.70:3000/api';
const String kPrdHost = 'http://192.168.1.70:3000/api';

enum ApiCore {
  traducao('/v1/traducao', kDesHost, kPrdHost, HeaderType.minimal),
  healt('', kDesHost, kPrdHost, HeaderType.minimal),
  register('/v1/acesso/registro', kDesHost, kPrdHost, HeaderType.minimal),
  login('/v1/acesso/login', kDesHost, kPrdHost, HeaderType.basicInfo),
  menu('/v1/menu', kDesHost, kPrdHost, HeaderType.loggedArea),
  requestOtp('/v1/otp/send', kDesHost, kPrdHost, HeaderType.basicInfo),
  verifyOtp('/v1/otp/verify', kDesHost, kPrdHost, HeaderType.basicInfo),
  usuarioDetalheById('/v1/usuario/usuario-detalhe-by-id', kDesHost, kPrdHost, HeaderType.loggedArea);

  const ApiCore(this.endpoint, this.des, this.prd, this.headerType);
  final String endpoint;
  final String des;
  final String prd;
  final HeaderType headerType;
}

class Header {
  static final Map<String, String> header = {
    'Access-Control-Allow-Origin': 'true',
    'Access-Control-Allow-Methods': '*',
    'Access-Control-Allow-Headers': '*',
    'Content-Type': 'application/json; charset=UTF-8',
    'Charset': 'utf-8',
  };

  static Map<String, String> getHeader(HeaderType headerType) {
    switch (headerType) {
      case HeaderType.minimal:
        return header;
      case HeaderType.basicInfo:
        return buildHeaders();
      case HeaderType.loggedArea:
        return buildHeadersLoggedUser();
    }
  }

  static Map<String, String> buildHeadersLoggedUser() {
    final session = AuthSession.instance;
    final token = session.token;
    final userId = session.userId;
    if (token == null || userId == null) {
      throw StateError('headerInvalido');
    }

    return {...buildHeaders(), 'x-token': token, 'x-user': userId.toString()};
  }

  static Map<String, String> buildHeaders() {
    return {...header, 'x-access-interface': 'App', 'x-access-token': kAccessTokenId};
  }
}
