set http_proxy=http://127.0.0.1:1080
set https_proxy=https://127.0.0.1:1080
flutter pub publish --dry-run
flutter packages pub publish --server=https://pub.dartlang.org
