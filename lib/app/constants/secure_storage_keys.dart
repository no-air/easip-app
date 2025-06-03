enum SecureStorageKey {
  googleAccessToken,
  googleIdToken,
}

extension SecureStorageKeyExtension on SecureStorageKey {
  String get value {
    switch (this) {
      case SecureStorageKey.googleAccessToken:
        return 'google_access_token';
      case SecureStorageKey.googleIdToken:
        return 'google_id_token';
    }
  }
} 