class AuthException implements Exception {
  AuthException(this.key);

  static const Map<String, String> error = {
    'EMAIL_EXISTS': 'e-mail já cadastrado',
    'OPERATION_NOT_ALLOWED': 'operação não permitida',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'acesso bloqueado temporariamente, tente novamente mais tarde',
    'EMAIL_NOT_FOUND': 'e-mail não encontrado',
    'INVALID_PASSWORD': 'senha informada não confere',
    'USER_DISABLED': 'a conta do usuário foi desabilitada',
  };

  final String key;

  @override
  String toString() {
    return error[key] ?? 'ocorreu um erro no processo de autenticação';
  }
}
