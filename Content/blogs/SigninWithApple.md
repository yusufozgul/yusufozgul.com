---
title: Sign in with Apple Nasıl Kullanılır?
date: 2019-06-05 12:00
tags: Swift, Apple, Sign in with Apple, Auth
description: Sign in with Apple özelliği WWDC 2019’da tanıtıldığında diğer bir çok üçüncü parti giriş servislerinden çok daha iyi özellikleriyle geldi. Vermek istediğiniz bilgileri kontrol edebilmek araya bir email yönlendirmesi koymak gibi. Gizlilik konusunda atılan bu güzel adımda Apple’a güvenebildiğimiz kadar gizliliğimizi korumuş oluyoruz.

---

Sign in with Apple özelliği WWDC 2019’da tanıtıldığında diğer bir çok üçüncü parti giriş servislerinden çok daha iyi özellikleriyle geldi. Vermek istediğiniz bilgileri kontrol edebilmek araya bir email yönlendirmesi koymak gibi. Gizlilik konusunda atılan bu güzel adımda Apple’a güvenebildiğimiz kadar gizliliğimizi korumuş oluyoruz. Artık kullanmadığımız, hesabımızı kapattığımız hizmetlerden spam mailler almayacağız. Birde hangi uygulamalar bilgilerimizi satıyor görebileceğiz 🙂

Yıl sonuna kadar bu özellik uygulamada üçüncü parti giriş hizmeti kullananlar için zorunlu olacak, Apple bazen gerekli konularda iyi yaptırımlar uyguluyor. Hadi şimdi bu özelliği nasıl kolayca uygulamamıza ekleyebileceğimize bakalım.

Başlamadan eklemek istediğim şeyler var:

- Bu özellik iOS 13 ve daha üst sürüm gerektirir.
- Uygulamanız UIKit kullansa bile kullanabilirsiniz.
- Xcode 11 kullanmanız gerekmektedir.
- Son olarak yayınlanmış son Apple Geliştirici Şartlarını kabul etmelisiniz.

Bu arada karşılaştığım bir sorun bu özellik ücretsiz hesap ile geliştirme yapıyorsanız kullanılamıyor. developer.apple.com’da son Geliştirici Şartları görünmüyor. Developer hesabında ise herhangi bir sorun yok.

### Başlayalım

Xcode 11 beta’yı açıp bir proje oluşturun. Bu yazıda uygulama UIKit ile geliştirilmiş olacak dilerseniz SwiftUI’da kullanabilirsiniz herhangi bir fark bulunmuyor.

Proje ayarlarımızı yapalım.
![](/upload-images/SigninWithApple/upload-270232875.png width=100%)

![](/upload-images/SigninWithApple/upload-299754126.png width=100%)

Proje ayarlarımızdan sonra kodumuza başlayabiliriz. Yapacağımız ilk iş AuthenticationServices’ı ViewController’ımıza import etmek
```swift
import AuthenticationServices
```
Şimdi AuthenticationServices’ten ASAuthorizationAppleIDButton’u kullanacağız, esasında bu bir buton ve UIControl kütüphanesine bağlı. Bu da demek oluyor ki bunu bir buton gibi düşüneceğiz ve target verip farklı bir fonksiyonda bunun işlemlerini yapacağız.
> gist 5451b0c844f8c627aeca642387f0747d

Butonumuzu oluşturduk, aksiyon işlemini nerede yapacağını söyledik ve hangi event ile tetikleneceğini belirledik. Ardından view’umuzun merkezine ekledik.

#### Bir göz atalım nasıl görünüyor ?

![](/upload-images/SigninWithApple/upload-899708053.png width=100%)

Şimdi sıra geldi bu işin merkezine. Butonumuzun aksiyon metoduna gelelim.

Burda ilk olarak AppleID Provider kullanacağız. Bu bize Bilgileri sağlayacak. Buna bir request oluşturarak hangi bilgileri alabileceğimizi belirliyoruz. Şu an kullanılabilir iki veri bulunuyor. Biri e-Posta diğeri tam isim. AppleID Provider’e bir request oluşturduk ve buna bize email ve tam isimi vermesini istedik. Sonra bir Controller oluşturduk. Bu controller’a gereken delegasyon ve içerik sağlayıcısını ( presentationContextProvider ) self olarak verdik.

> gist ba1b4e12c525c6c6a3285c6c35cecfc9

Şimdi aslında işlem bitti ancak daha da iyileştirmek en iyisi. Bir extension ekleyelim. Bu extension ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding’dan kalıtımını alsın.

Xcode’un istediğini yapalım ve presentationAnchor fonksiyonunu implementde edelim. İçine geri dönüş değerini verelim.

```swift
return self.view.window!
```

Şimdi de giriş yapılma işleminde hata oluşup olmadığını, başarılı giriş yapılmışsa eğer kullanıcı bilgilerini alalım.

> gist e1b7de6b9095265568fac3dc2b5bddd5

İşleminizin bir sorunla karşılaşmadığını doğrulamak için guard let ile kontrolümüzü yaptık. Eğer sorun yoksa kayıt yapan kullanıcının verilerini konsola yazdırdık.

![](/upload-images/SigninWithApple/upload-558219504.png width=100%))

Bilgilerimizi gerçek email ile kullanırsak ne oluyor, Apple’ın gizlilik için oluşturduğu mail ile kullanırsak kullanıcı bilgileri aşağıdaki gibi oluyor.

![](/upload-images/SigninWithApple/upload-403950479.png width=100%)

Apple’ın bu WWDC’de tanıttığı güzel bir özelliği elimden geldiğince anlattım, sorularınız olursa yorum kısmına ya da blogumun iletişim kısmından bana ulaşabilirsiniz, bugsız günler 🙂

Kodlar İçin [GitHub Hesabım](http://https://github.com/yusufozgul/SignWithAppleTutorial "GitHub Hesabım")

---

Kaynaklar:

https://medium.com/q42-engineering/sign-in-with-apple-e45325cd9d0

https://developer.apple.com/sign-in-with-apple/get-started/
