enum SecureStorageKey {
  googleAccessToken,
}

extension SecureStorageKeyExtension on SecureStorageKey {
  String get value {
    switch (this) {
      case SecureStorageKey.googleAccessToken:
        return 'google_access_token';
    }
  }
} 