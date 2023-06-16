# görme engelli bireyler için nesne algılama ve metin tanıma 

A new Flutter project.

## ÖZET

Görme engelli bireyler, dünya nüfusunda önemli bir çoğunluğa sahiptir. Dünya 
Sağlık Örgütünün raporuna göre dünyada 284 milyon görme engelli insan var ve bunların 39 
milyonu tamamen görme engellidir. Görme yetisinde belirgin şekilde kayıpları olan görme 
engelli bireyler, doğuştan veya sonradan gerçekleşen bazı sebeplerden dolayı etraflarında 
olanları göremezler veya görmelerinde bazı engellerle yüzleşebilirler. Bu engellerden dolayı 
günlük hayatta bazı sorunlarla karşılaşan bireyler, sağlık, ekonomik ve psikolojik bazı 
sorunlarla karşılaşabilmektedir. Görme engelli bireyler için kendi hayatlarını kendi başlarına 
idame ettirmeleri güçtür. Geçmişten günümüze görme engelli bireyler için geliştirilen buluş 
ve cihazları gelişen teknolojiyle yenilemek ve bu bireylerin kullanımına sunarak 
karşılaşacakları engelleri en aza indirmek onlar için çok önemlidir. Halihazırda görme engelli 
bireyler için yapılmış birçok çalışma ve uygulama vardır. Geliştirilen mobil uygulama görme 
engelli bireylerin hayatını kolaylaştırmayı ve daha iyi bir deneyim sunmayı amaçlamaktadır. 
Uygulama etraftaki nesneleri kamera yardımı ile algılar ve eğitilmiş bir model yardımı ile bu 
nesneleri tespit ederek görme engelli bireye sesli bir çıkış sunar. Uygulama Flutter 
framework’ü kullanılarak geliştirilmiştir, model eğitimi kısmında ise Tensorflow 
kullanılmıştır.

![image](https://github.com/tunhnt2/flutter-gorme-engelli-bireyler-icin-nesne-algilama-ve-metin-tanima/assets/118447298/dea56d9f-15ae-4ca1-8f29-4b17c81ebe29)

## Model Eğitim Aşaması
Model, Google Colab ürünü içerisinde yer alan ücretsiz sunucuları kullanarak 
Tensorflow Lite ile eğitilmiştir.

### Veri Seti Toplama 
41 tane etiketten oluşan veri seti eğitilirken, modeli doğru bir şekilde eğitmek için objeler farklı açılardan, farklı arka planlarda çekilmiştir. Ayrıca bazı etiketlerin bir arada olmasına dikkat edilmiştir. Veri setinde kullanılan objelerin, görme engelli bir bireyin sık karşılaşabileceği objeler olmasına dikkat edilmiştir.
![image](https://github.com/tunhnt2/flutter-gorme-engelli-bireyler-icin-nesne-algilama-ve-metin-tanima/assets/118447298/64af225d-1153-4942-a66d-fb71887f5a5e)
![image](https://github.com/tunhnt2/flutter-gorme-engelli-bireyler-icin-nesne-algilama-ve-metin-tanima/assets/118447298/e038d97c-7588-4dd5-a5cd-17e472f2eea3)
![image](https://github.com/tunhnt2/flutter-gorme-engelli-bireyler-icin-nesne-algilama-ve-metin-tanima/assets/118447298/85755322-8d92-4195-bba0-c6591b465c36)

## Flutter kısmında kullanılan paketler
  #### cupertino_icons: ^1.0.2
  #### camera: ^0.10.4
  #### tflite: ^1.1.2
  #### flutter_tts: ^3.6.3
  #### flutter_mobile_vision_2: ^0.1.15
  #### device_apps: ^2.2.0
  #### google_mlkit_text_recognition: ^0.6.0
  #### image_cropper: ^4.0.1
  #### image_picker: ^0.8.7+5

Uygulama tensorflow paketindeki uyumluluk sorunundan dolayı android 12 sürüm cihazlarda çalışmamaktadır.

## ARAŞTIRMA SONUÇLARI 
Uygulama temel olarak iki işlevden oluşmaktadır bunlar nesne tanıma ve metin tanımadır. Uygulamanın ana ekranında kullanıcıyı basit bir arayüz karşılamaktadır. Bu arayüz yardımı ile nesne tanıma ve metin tanıma arayüzleri arasında geçiş yapılabilmektedir. Kullanıcı görme engelli bir birey olacağı için mümkün olduğunca basit bir arayüz tasarlamak hedeflenmiştir.
[Uygulamanın nasıl çalıştığını Youtube'dan görüntüleyebilirsiniz.](https://www.youtube.com/watch?v=97pEIXFbhqg&list=PL08JtCwv3HqONaQuNFOX6G2YbKkbTOpuD)


## TARTIŞMA
Geliştirilen projenin amacı nesneleri, engelleri, insanları ve metinleri algılayıp görme 
engelli bireyler için sesli bir dönüş sağlayan bir uygulama oluşturmaktı. Her ne kadar görme 
engelli bir bireyin günlük hayatta bir mobil uygulama kullanabilmesi zor olsa da 
geliştirdiğimiz sistem sayesinde bir nebze de olsa görme engelli bireylerin hayatlarını 
kolaylaştırmak ve yaşadığı sorunları en aza indirmek hedeflenmiştir. Projeyi geliştirirken 
cihaz platformundan bağımsız geliştirme (hem Android hem IOS cihazlarda çalışma) 
sağlayabileceğimiz ve geliştirilen modelin uyumlu çalışabilmesi için Flutter mimarisi seçildi.
Eğitilen modelde, görme engelli bireylerin günlük hayatta karşılaşabileceği nesneler 
eğitmeyi ön plana alınmıştır. Ne kadar fazla nesne eğitilirse bireylerin hayatının da o kadar 
kolaylaşacağı açıktır. Geliştirilen proje nesne ve metin algılama olmak üzere iki amaç için 
de gerçeğe yakın ve başarılı sonuçlar vermiştir. Geliştirilen uygulama çalışmak için mobil 
cihaz hariç herhangi bir ek donanıma ihtiyaç duymayacağı için kullanıcı dostu, taşınabilir ve 
ekonomik olarak nitelendirilebilir. 
Bunun yanı sıra geliştirilen proje bir takım geliştirilme ve iyileştirmelere ihtiyaç 
duymaktadır. Daha yüksek doğruluk oranına sahip modeller geliştirmek, görme engelli bir 
bireyin daha verimli kullanabileceği bir arayüz oluşturmak, ekran kare hızını arttırarak 
kameradaki donma ve gecikme gibi sorunları daha aza indirerek daha gerçekçi sonuçlar elde 
etmek, görme engelli birey için daha anlaşılır bir sesli çıkış sunmak, kullanılan veri setini 
genişleterek algılanan nesne sayısında arttırıma gitmek, farklı dil seçenekleri eklemek örnek 
olarak verilebilir. Bir diğer iyileştirme IOS cihazlarda uygulamanın uyumluluk sorunlarını 
gidermek olacaktır. Geliştirilen uygulama çıktısı Android cihazlarda test edilmiş olup, Flutter 
dilinin sağladığı iki ortama da ürün geliştirme özelliği sayesinde yazılan kodda bir kaç 
düzeltme yapılarak uygulamanın IOS sürümünün oluşturulması ve test edilmesi 
gerekmektedir. Geliştirilen uygulama her ne kadar 300MB boyutlarında olsa da kullanılan 
modelin büyüklüğü artarsa bulut tabanlı bir sistem kullanmak gerekliliği ortaya çıkabileceği 
saptanmıştır.
