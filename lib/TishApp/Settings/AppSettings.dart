class Settings {
  static const String _backend_protocol = 'https';
  static const String _backend_domain_name = '10.0.2.2';
  static const String _backend_port_number = '5001';
  static const String _backend_url = _backend_protocol +
      '://' +
      _backend_domain_name +
      ':' +
      _backend_port_number +
      '/api';
  // static const String _backend_url = 'https://tishapi.codepickles.com/api';

  static const String _Realm_Name = 'TishAppRealm';
  static const String _domain_name = 'dev.mauto.co';
  static const String _grant_type_login = 'password';
  static const String _client_id_login = 'TishAppLogin';
  static const String _grant_type_register = 'client_credentials';
  static const String _client_id_register = 'TishAppRegister';
  static const String _client_secret_register =
      '2b396c90-f1c9-4c03-9e29-ebb3d4aa55e6';

  static const String _client_secret_login =
      'efc14a53-2655-42a5-9cb5-c0bd8bd2c6b6';
  static const String _login_url =
      'https://$_domain_name/auth/realms/$_Realm_Name/protocol/openid-connect/token';
  static const String _Register_url =
      'https://$_domain_name/auth/admin/realms/$_Realm_Name/users';
  static const String _logout_url =
      'https://$_domain_name/auth/realms/$_Realm_Name/protocol/openid-connect/logout';
  static const String _save_User_In_DB_url = "$_backend_url/Users";
  Settings();

  String get grant_type_login {
    return _grant_type_login;
  }

  String get client_id_login {
    return _client_id_login;
  }

  String get grant_type_register {
    return _grant_type_register;
  }

  String get client_id_register {
    return _client_id_register;
  }

  String get client_secret_register {
    return _client_secret_register;
  }

  String get login_url {
    return _login_url;
  }

  String get Register_url {
    return _Register_url;
  }

  String get logout_url {
    return _logout_url;
  }

  String get client_secret_login {
    return _client_secret_login;
  }

  String get backend_url {
    return _backend_url;
  }

  String get save_User_In_DB_url {
    return _save_User_In_DB_url;
  }
}
