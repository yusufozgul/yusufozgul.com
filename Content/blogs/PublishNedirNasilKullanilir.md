---
title: Swift ile Web Site Oluşturmak
date: 2021-03-20 10:08
tags: Swift, Publish
description: Swift'i kullanarak nasıl statik web sayfaları oluşturabiliriz, nasıl hiç js kullanmadan bu yazıyı okuduğunuz site gibi siteler oluşturabiliriz?

---

Swift'i kullanarak nasıl statik web sayfaları oluşturabiliriz, nasıl hiç js kullanmadan bu yazıyı okuduğunuz site gibi siteler oluşturabiliriz?

Daha önce yazdığım blog yazılarını kurduğum wordpress tabanlı blog'umda yazıyordum. Ancak hiç bilmediğim PHP ile yapmak istediğim bazı şeyleri yapamamak ve ara ara sorunlarla karışlaşıp bunları çözmekte bir hayli zorlanmam nedeniyle Wordpress'ten kurtulmak istedim. Web konusunda neredeyse hiç bilgim olmadığı için ya bana Gatsby gibi static html verecek ve herhangi bir ekstra kurulum yapmadan kolayca sunmamı sağlacak bir şeye ihtiyacım vardı. Elbette Medium'a da ara ara yazıyorum ancak projeler için bu domaini tutmak ve burada da yazmak istiyorum. 

Bu arayışlarım sırasında daha önce gördüğüm ama çok incelemediğim için unuttuğum bir projeyi tekrar buldum, [Publish](https://github.com/johnsundell/publish). Tam istediğim gibi static html çıktısı veriyordu ve üstelik Swift ile yazılmıştı. Aslında Swift olması sizi yanıltmasın label, scroll view tarzı şekilde yazmıyorsunuz, gidip html'i swift ile yazıyorsunuz. Küçük bir örnek:

```swift
.wrapper(   
    .a(
        .href("./blogs"),
        .h1("🚀 Latest articles")),
    .itemList(
        for: Array(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == SectionID.blogs.rawValue }.prefix(3)),
        on: context.site),
    .a(
        .class("browse-all"),
        .href("./blogs"),
        .text("Browse all \(context.allItems(sortedBy: \.date, order: .descending).filter { $0.sectionID.rawValue == SectionID.blogs.rawValue }.count) articles"))
),
```

Görüldüğü gibi html tag'lerini kullanıyoruz ama swift'in kendi özelliklerini de kullanabiliyoruz.  Örnek kodda ben ana sayfada 3 tane blog yazısı listelensin istemişim, bunun için tüm yazıların sadece ilk üçünü al demem yeterli oldu. İkinci kısımda da tüm yazıları göstermek için kaç yazı olduğunu saydırdım.

### Kurulum ve Kullanım

Peki bu proje nasıl çalışıyor. Öncelikle aslında bu proje bir Swift Package şeklinde çalışıyor. Kendi içinde default dark/light tema desteği var. Sizin sadece web sitesi için başlık gibi bazı alanları girmeniz isteniyor. Tüm blog yazıları ise markdown formatında yazıyoruz. Çalıştırmak için publish'i kurmamız gerekiyor, brew yardımıyla kolayca kurabiliriz.

`brew install publish`

Ardından terminale gidip `publish run` komutunu verdiğimiz anda projemiz derleniyor ve local host üzerinde serve ediliyor. Belirtmek isterim bu debug aşaması, yayınlamak istediğimizde static html olarak çıktı verecek.

Ben yazılarımı taslak olarak tutmak ve kalıcı olarak saklamak için Notion uygulamasını kullanıyorum, en önemlisi ise Notion'ın yazıları markdown formatında export edebilmesi işime geliyor 🙂 

### Eklenti Desteği

Bu kadar anlattıklarımdan sonra bazı eksikler göze çarpıyor, embed edilen şeylere nasıl çözüm bulacağız? Publish için bir çok güzel extension yayınlanmış durumda.  package.swift dosyasına gidip eklemek kadar zorlukta. Benim kullandığım bazı extension'lar şu şekilde:

- [ReadingTimePublishPlugin](https://github.com/alexito4/ReadingTimePublishPlugin): Adından da anlaşıldığı gibi yazının okunma süresini hesaplıyor. Tabi dakikada okunabilecek kelime sayısını sizden istiyor ve böylece hemen her dilde kullanılabilir oluyor.
- [TwitterPublishPlugin](https://github.com/insidegui/TwitterPublishPlugin) - [GistPublishPlugin](https://github.com/thomaslupo/GistPublishPlugin) - [YoutubePublishPlugin](https://github.com/tanabe1478/YoutubePublishPlugin.git) : İsimleri kendilerini tanıtıyor.
- [SplashPublishPlugin](https://github.com/johnsundell/splashpublishplugin) : Bu eklenti yazı içinde paylaşılan kodları güzel bir biçimde renklendiriyor ve sayfayı taşırmadan ekliyor. Örnek hemencecik yukarıda.
- [ImageAttributesPublishPlugin](https://github.com/finestructure/ImageAttributesPublishPlugin): Static html olduğu için görselleri yerleştirmek problem oluyor, özellikle ekrana sığdırma gibi bu eklenti ile `![](IMAGE-URL width=100%)` gibi basit eklemelerle düzenleyebiliyoruz.

Elbette bir çok eklenti var farklı işlerinizi görebilecek. Bunları [https://github.com/topics/publish-plugin](https://github.com/topics/publish-plugin) etiketinden daha kolay bulabilirsiniz. 

### Deploy

Son olarak yayınlama kısmına geldik. Yayınlamak için default olarak kendi içinde bazı metotlar mevcut. Ben oluşturduğum private bir Github reposuna göndermesini sağladım. Bu repoya Github Action'ı kullanarak server'ımda otomatik olarak deploy etmeye yaran go kodu yazdım. Böylece yazıyı ekledikten sonra yapmam gereken terminalde `publish deploy` komutunu çalıştırmak.

### Son Olarak:

Temel hatlarıyla Publish'i anlatmaya çalıştım. Github üzerinde çeşitli sitelerin kaynak kodları açık olarak mevcut. Tabiki de bu sitenin kaynak kodları da mevcut. Dilerseniz [Github](https://github.com/yusufozgul) hesabımdan erişebilirsiniz.

Publish hakkında bir iki yazı daha yazma planım var, ihtiyacıma yönelik bir eklenti yazmaca ya da Publish hakkında işe yarayacak ip uçları olabilir.  İhtiyacım olan bir eklenti var aslında her yazının soruna bir sonraki ve bir önceki yazıyı ya da etiketler ile benzer yazıları getirme.

Okuduğumuz için teşekkür ederim 🙂
