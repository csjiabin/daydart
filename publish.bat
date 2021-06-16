set http_proxy=http://127.0.0.1:10800
set https_proxy=https://127.0.0.1:10800
@REM flutter pub publish --dry-run
flutter packages pub publish --server=https://pub.dartlang.org
