---
title: Swift Kontrol Yapıları
date: 2019-10-17 12:00
tags: Swift, Software
description: Merhaba, bu yazımda Swift’te kontrol yapıları nasıl kullanılır, farklı kontrol yapıları hakkında olacak. Kontrol yapıları kodlamamız içerisinde sıklıkla kullanmamız gereken kod parçacıkları oluyor. Gelin hep birlikte bakalım nasıl yapılıyor.

---

Merhaba, bu yazım Swift’te kontrol yapıları nasıl kullanılır, farklı kontrol yapıları hakkında olacak. Kontrol yapıları kodlamamız içerisinde sıklıkla kullanmamız gereken kod parçacıkları oluyor. Gelin hep birlikte bakalım nasıl yapılıyor.

### If Blokları

Kodlamaya ufak bir giriş yapmış olanların bile bileceği bu blok tahmin edersiniz ki yazdığımız kodun Boolean sonucuna göre işlem yapıyor ya da yapmıyor. Hemen bakalım:

```swift
if 10 == 5 {  // 10 değeri 5 değerine eşit mi? Sonuç: False işlem yapılmaz
}

if 10 > 5 {  // 10 değeri 5 değerinden büyük mü? Sonuç: True işlem yapılır.
}
```

Basit bir şekilde if kullanımı yukardaki gibi. Temel mantık operatörlerini kullanarak kontrollerimizi yapıyoruz. Ek olarak ve ( && ) ya da veya ( || ) gibi mantık operatörlerini de kullanabiliriz. Şimdi bir adım daha ileri gidelim ne dersiniz?

### If let Blokları

If tanıdık geldi, let’te tanıdık geldi değil mi? Bir farklılık var ama hemen ne olduğuna bakalım. Bu işlemde bir değeri işleyip bir değişkene atmaya çalışıyoruz. Eğer yapabilirsek bize sonuç Boolean olarak True gelecek, aksi taktirde False gelecek. Hemen bakalım:

```swift
if let myView = view.subviews.first as? MyCustomView {
 }
```

Buradaki işlemi hemen anlayalım. Diyoruz ki elimizde bir view var ve bu view’un alt viewlarından ilkini alıp eğer bu alt viewların ilkini MyCustomView şekilde alabildiysen myView değişkenine ata. Yapabilirse bu myView değişkenini bloğun içerisinde kullanabiliriz.

Bu işlemi çok sık kullanırız tableview prototip cell’lerimizi alırken if let yapısını kullanmamız gerekir. Asla yapmamamız gereken ise:

```swift
let myView = view.subviews.first as! MyCustomView
```

Bu işlem asla tavsiye edilmez çünkü eğer yapamazsa uygulamanız crash edecektir.

Peki if let kullanmamız gerekiyor ama if içerisine her şeyi yazmak istemiyorsak ne olacak? Çaremize Guard yapısı giriyor.

### Guard Blokları

Aslında gif’in tam tersi bir işlem yazıyorsunuz. If’te eğer olursa parantez içini işle. Eğer olmazsa isteğe bağlı olarak else kısmını işle. Guard yapımızda ise şartımız False dönerse zorunlu else kısmına girer. Gerçekleşirse problem yok devam eder.

```swift
guard 10 == 5 else { return }
```
Görüldüğü gibi guard kullandığımız zaman olmadığı durumda ne yapacağını söylüyoruz ve her şeyi parantez içine yazmıyoruz. Elbette burada parantez içine istediğiniz işlemi yazabilirsiniz.

If let yapısını kullanabildiğiniz gibi guard let yapısını da kullanabilirsiniz. Aralarındaki tek var birinde olursa ne olacağı diğerinde olmazsa ne olacağını yazmanız şart.


### Bu bloklarla başka neler yapılabilir?

- null check işlemi yani bir optional değişkenin nil olup olmadığı kontrol edilebilir. Bu uygulamamızın çökmemesi için şart.
- if let ya da guard let yapısında birden fazla let kullanılabilir. Hepsi yapılırsa True döner.
- if let yapısındaki değişken sadece parantez içinde kullanılabilirken guard let yapısında tanımladığınız değişken ilgili metot ya da classta her nerede tanımladıysanız kullanılabilir.
- Xcode’un bize kızdığı bu optional bir değişken dediği durumlarda kolaylık olsun diye Force-unwrap yapıp geçmeyip bu yapıları kullanırız.

Bir yazımın daha sonuna geldik, bana ulaşmak için iletişim sayfasını kullanabilirsin, soruların varsa da yorum olarak yazabilirsin. Keyifli kodlamalar 🙂
