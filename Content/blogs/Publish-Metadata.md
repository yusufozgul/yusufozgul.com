---
title: Publish Metadata
date: 2021-03-21 10:08
tags: Swift, Publish
description: Publish'e metadata kullanarak yeni özellikler ekleyelim.
---

Bir önceki yazımda Publish ile nasıl swift ile static web siteleri oluşturabilirizden bahsetmiştim, okumadıysanız: [https://yusufozgul.com/blogs/PublishNedirNasilKullanilir/](https://yusufozgul.com/blogs/PublishNedirNasilKullanilir/). Publish'e draft ve zamanlanmış yazılar özelliğini nasıl getirebiliriz? Benim kullandığım eklentilerin nasıl kullanılacağını yazdığım samples adında bir yazı var, haliyle bu yazının yayınlanmasını istemiyorum. Bu sorunu çözmek için Publish'e iki adet pr açılmış ancak her ikiside kabul edilmemiş. Sebebi ise bunun zaten kolayca yapılabiliyor olması. Hadi nasıl yapılır bakalım.

Bir yazı oluştururken en başına aşağıdaki gibi bir alan ekliyoruz. Bu alan başlık, açıklama, tarih ve tag'lerden oluşuyor.

```
---
title: Swift ile Web Site Oluşturmak
date: 2021-03-20 10:08
tags: Swift, Publish
description: Swift'i kullanarak nasıl statik web sayfaları oluşturabiliriz, nasıl hiç js kullanmadan bu yazıyı okuduğunuz site gibi siteler oluşturabiliriz?
---
```

Bu girdiler aslında birer metadata, peki biz burayı zenginleştiremez miyiz? Elbette yapabiliriz.

### Draft Özelliği:

Sık yazı yazıyorsanız bazen bir yazı devam ederken bir yazı yazıyor olabilirsiniz ya da benim gibi eklentilerin nasıl kullanılacağını belirten örnek bir yazınız olabilir, her iki durumda da bu yazıların deploy edilmemesi gerekir.

1. Yeni bir metadata ekleyelim:

Yazının metadatalar kısmına yeni bir metadata ekleyelim.

```
isDraft: true
```

1. Metadatayı tanımlayalım:

WebSite struct'ının içerisinde metadata için bir struct daha bulunacak. Buraya yeni metadatayı ekleyelim.

```swift
struct ItemMetadata: WebsiteItemMetadata {
			let isDraft: Bool?
}
```

Nullable yaptım çünkü sadece draft olan yazıları belirmek yeterli olsun diye.

1. Metadata kontrolü yapalım:

Publish derlenirken eklentileri verdiğimiz, adımları belirlediğimiz kısma yeni bir alan ekleyeceğiz.

```swift
try YusufozgulCom().publish(withTheme: .yusufozgulcom,
                            rssFeedSections: [.blogs, .projects],
                            additionalSteps: [...
                                                .removeAllItems(in: .blogs, matching: .init(matcher: { item in
                                                    item.metadata.isDraft ?? false
                                                }))
                            ],
                            plugins: [...])
```

RemoveAllItems ile geriye bool dönerek yazının silinmesini ya da silinmemesini belirtiyoruz. Böylece yazı draft ise deploy ederken yazıyı göndermemiş oluyoruz.

### Zamanlanmış Yazılar:

Bu özellik aslında yukarıdaki adımlarla birebir aynı şekilde. Yazılarımızda zaten date metadatasını kullanıyoruz. Kendi Metadata struct'ımıza da date ekleyip removeAllItems kısmında bu date'i formatlayıp bulunduğumuz günden ileride ise yazının yayınlanmasını engelleyebiliriz. Başka bir senaryoda belirli süreden sonra yazıları arşivleyebiliriz ya da yazıları arşivler kısmında göstermek gibi işlemler yapabiliriz.

Bu yazıda ihtiyacım olan bir özelliği nasıl getirdiğimi paylaşmak istedim. Yukarıda bahsettiğim iki pr'ın linklerini aşağıya ekliyorum, dilerseniz oradaki konuşmaları okuyabilirsiniz. Teşekkür ederim.

---

---

[Add draft support for Markdown Content by mimorocks · Pull Request #89 · JohnSundell/Publish](https://github.com/JohnSundell/Publish/pull/89)

[Allow user to have draft content excluded from Output by Kilo-Loco · Pull Request #94 · JohnSundell/Publish](https://github.com/JohnSundell/Publish/pull/94)
