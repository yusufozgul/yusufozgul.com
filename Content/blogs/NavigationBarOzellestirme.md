---
title: NavigationBar’ı Nasıl Özelleştiririz?
date: 2020-08-21 18:46
tags: Swift
descriptions: İOS uygulamalarında sayfa geçişlerinin çatısını oluşturan NavigationController bize bir navigasyon bar‘ı sunuyor. Buraya başlık, geri butonu, diğer işlemler için buton ekleyebiliyoruz. Aynı zamanda NavigationController‘ın bize sunduğu kaydırarak geri gelmek oldukça işlevsel. Öyleyse şimdi biraz bu bar’ı nasıl özelleştirebiliriz bakalım.

---
# NavigationBar’ı Nasıl Özelleştiririz?
İOS uygulamalarında sayfa geçişlerinin çatısını oluşturan NavigationController bize bir navigasyon bar‘ı sunuyor. Buraya başlık, geri butonu, diğer işlemler için buton ekleyebiliyoruz. Aynı zamanda NavigationController‘ın bize sunduğu kaydırarak geri gelmek oldukça işlevsel. Öyleyse şimdi biraz bu bar’ı nasıl özelleştirebiliriz bakalım.


![](/upload-images/NavigationBarOzellestirme/upload-391177605.png width=100%)
kaynak: developer.apple.com



Geri butonu ile başlayalım. Geri butonu bir ikon ve text‘ten oluştur. Eğer bir önceki sayfanın başlığı varsa text olarak onu alır. Eğer yoksa sistem tarafından lokalize edilen Geri ( Back ) adını alır. Geri butonunu kendimize göre şu şekilde özelleştirelim:

Farklı bir ikon
Herhangi bir text bulunmayan
Önce bir Navigation Bar temel olarak hangi kısımlardan oluşuyor göz atalım:


![](/upload-images/NavigationBarOzellestirme/upload-493393184.png width=100%)

Görüntüden de anlaşılacağı üzere bizim ilgilenmemiz gereken kısım left item.

ViewWillAppear fonksiyonunda küçük bir işlemle düzenleyelim.


![](/upload-images/NavigationBarOzellestirme/upload-671530495.png width=100%)

Düzenlenmiş geri butonu
Eklediğimiz kod ile geri butonumuzu düzenledik, action ile ne yapması gerektiğini ayarladıktan sonra test edebiliriz.

Geri butonunu istediğimiz şartlara göre düzenledik, ancak bir sorun var. iOS kullanıcılarının alıştığı kaydırarak geri gelme özelliği artık çalışmıyor.

Bunun çalışmama sebebi otomatik ayarlanan geri butonunu kaldırmış yerine custom bir buton koymuş olmamız, butonu kendimiz ayarladığımıza göre gesture‘ı aktif etmemiz de gerekir.

Bunun için eklememiz gereken kısımlar var. Ekledikten sonra kaydırarak geri gelebilir halde olacak.


![](/upload-images/NavigationBarOzellestirme/upload-021908818.png width=100%)

NavigationController içinde bulunan interactivePopGestureRecognizer‘a erişip bunun delegesini ve aktifliğini ayarladık. Delegate’i üzerimize alır almaz Xcode bize kızdı haliyle, hemen fixleyelim ve sonuca göz atalım.

Sonuç tam istediğimiz gibi, varsayılan özellikleri bozmadan, özelleştirmeyle birlikte bar’ı düzenledik.

Bu konu hakkında yazmaya devam edeceğim ancak left ya da right item kısmına birden fazla buton eklemek isterseniz .leftBarButtonItems şeklinde erişip array olarak butonlarınızı ekleyebilirsiniz.

Bir yazımın daha sonuna geldik, dilerseniz başka yazılarıma göz atabilirsiniz, bana sorularınızı yorum ya da iletişim sayfası üzerinden sorabilirsiniz teşekkür ederim.

Kaynak ve Destekler:
Ahmet Keskin: https://twitter.com/_Ahmettkeskin


