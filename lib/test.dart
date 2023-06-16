import 'dart:async';

import 'package:flutter/material.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  // Aşağıda oluşturduğumuz debouncer nesnesini tanımlıyoruz.
  // [milliseconds] parametresini istediğin değerde verebilirsin.
  final _debouncer = Debouncer(milliseconds: 500);

  // Örnek bir fun() fonksiyonu içerisinde:
  // '''
  // _debouncer.run(() {
  //  // Buraya yazdığın kodlar 500 milisaniye sonra çalışır.
  //  // Örneğin texttospeech çalıştırma fonksiyonu.
  // });
  // '''
  // şeklinde kullanabilirsin.

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/// [Debouncer] bir fonksiyonun çağırılma sıklığını kontrol edebilmemizi
/// sağlayan bir sınıftır. Bu sınıfın içerisinde bir [Timer] nesnesi
/// bulunmaktadır. Bu nesne sayesinde bir fonksiyonun çağırılması
/// istenilen süre kadar ertelenebilmektedir.
class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
