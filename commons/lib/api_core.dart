import 'hosts.dart';

enum ApiCore {
  // cep('/73252200/json/', 'https://viacep.com.br/ws', 'https://viacep.com.br/ws', false);
  cep('/ws', kCepDesHost, kCepPrdHost, false),
  traducao('/v1/traducao', kDesHost, kPrdHost, false),
  healt('', kDesHost, kPrdHost, false),
  register('/v1/acesso/registro', kDesHost, kPrdHost, false),
  login('/v1/acesso/login', kDesHost, kPrdHost, false),
  requestOtp('/api/v1/otp/send', kDesHost, kPrdHost, false),
  verifyOtp('/api/v1/otp/verify', kDesHost, kPrdHost, false);

  const ApiCore(this.endpoint, this.des, this.prd, this.isLogged);
  final String endpoint;
  final String des;
  // final String hm;
  final String prd;
  final bool isLogged;
}
