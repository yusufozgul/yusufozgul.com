---
title: Swift kod bloklarına etiket vermek
date: 2019-09-29 12:00
tags: Swift, Software
description: İç içe for döngüsü yazıp belirli senaryolarda en dıştaki for döngüsünü kırıp ya da atlamayı nasıl yapabiliriz?

---

Başlık biraz karışık oldu farkındayım ancak detaylı anlatınca daha iyi anlaşılacaktır. Bu yazıda kod bloklarımıza etiket nasıl verebileceğimize bakacağız.

İç içe for döngüsü yazıp belirli senaryolarda en dıştaki for döngüsünü kırıp ya da atlamayı nasıl yapabiliriz? Elbette uzun uzadıya if blokları yazmak pek mantıklı olmayacaktır, bunun basit çözümü olmalı değil mi? Kod bloklarımıza etkilet vererek değişken adı verir gibi onları yönetebiliriz.

### Nasıl Yapılır?

```swift
forLabel: for element in array  {
    // İşlemler
}
ifLabel: if statement1 == statement2  {
    // İşlemler
}
swichLabel: switch(myEnum) {
    // İşlemler
}
```

Yukardaki örnekler basit kullanımları, şimdi iç içe (nested) for döngümüze gelelim.

```swift 
outerFor: for each in array // Döngümüze etiket verdik {
    for eachSubItem in subArray  {
        switch statement   {
        case one:
            continue outerFor // İstediğimiz durum gerçekleşince dışardaki döngümüzü sonraki döngüye atladık, bu sayede aşağıdaki işlemler yapılmayacak.
        // İşlemler
        }
     }
    // İşlemler
}
```

Yukardaki kod bloğunu istediğiniz şekilde kullanabilirsiniz, etiket vermek için blok başına ` etiketi_ismi: ` eklemeniz yeterli.

Bir yazının sonuna daha geldik, okuduğunuz için teşekkür ederim, diğer yazılarıma göz atabilir iletişim kısmından bana ulaşabilirsiniz ??

---

Kaynaklar:

https://docs.swift.org/swift-book/ReferenceManual/Statements.html 

https://medium.com/@rwgrier/swift-labeled-statements-3624ff30e0e7
