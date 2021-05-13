---
title: Dependency Injection - 1
date: 2021-04-4 10:08
tags: Swift
description: Temiz kodlar, daha iyi test edilebilirlik ve daha iyi kod: Dependency injection
---

# Dependency Injection - 1

Dependency injection'ın tanımı wikipedia'ya göre şöyle:

> In software engineering, dependency injection is a technique in which an object receives other objects that it depends on. These other objects are called dependencies. In the typical "using" relationship the receiving object is called a client and the passed object is called a service.

Yani sizin kodunuzun içerisinde bağımlı olduğunuz bir şeyin kodunuzun içerisinde doğrudan kullanmak yerine bağımlılığınızı kodun bir değişkenine, kodunuzun başlangıç fonksiyonuna (init, constructor) veya parametre olabilir bu şekilde aktararak kullanmak olacak. Bu sayede hem gerektiğinde bağımlılıklarımızı kolayca değiştirebileceğiz hem de test yazarken daha güvenilir ve kolay testler yazmamızı sağlayacak. Bu yazıda ise init fonksiyonunda inject etmenin nasıl olduğuna bakacağız.

### Ama Neden?

Bir class'ın içerisinde başka bir class'ı doğrudan kullanmamızın ne zararı olabilir ki? Sonuç olarak işlemi her iki class doğru yazıldıysa yapacaktır.

Burada problemimiz şu, bir kodu test etmek istediğinizde kodun içerisindeki bağımlılıklar sizin test etmenizi engelleyebilir ya da testin her koşulda doğru sonuçlar vermesini engelleyebilir. Bir örnek ile başlayalım. Elimizde bir kod olsun ve bu kodun içerisinde Dispatch Queue ile bir işlem yapalım. Bu kodun testini yazdığımızda bu Dispatch Queue bize problem çıkartacak. Çünkü test yapılırken bu çalışmaya devam ediyor. Bizim isteğimiz ise işlemler bittikten sonra doğru sonuçlar verip vermediğini kontrol etmek. Bunun çözümü nispeten kolay. XCTest'in içerisinde bu durumlar için `Expectations` ile testin doğru çalışmasını ayarlayabiliriz. 

Bir başka örnek, örneğin elimizde cihazla ilgili bilgiler veren bir class olsun. Kodumuzun içerisinde de cihaza göre işlem yapacak olalım. Doğrudan bu cihaz bilgilerini veren sınıfı kullanırsak bu durumda testimizi hangi cihazla yapıyorsak ona göre kod yazmış olalım. Peki farklı cihazda ne olacak? Çünkü bu unit test her koşulda doğru şekilde çalışmalı yoksa yazdığımız testin bir anlamı kalmıyor.

### Peki Nasıl?

Kısa bir kod örneği ile açıklayayım:

```swift
import UIKit

class Device {
    var screenSize: Size {
        UIScreen.main.bounds.size
    }
}

/// LOGIC

class XYZPresenter {
    func prepareView() {
        view.prepareView(size: Device.screenSize)
    }
}

/// TEST

import XCTest

class XYZPresenterTest {
    var presenter: XYZPresenter = .init()
    
    func test_prepareView_InvokesView() {
        XCTAssertFalse(view.isPrepareViewInvokes)
        
        presenter.prepareView()
        
        XCTAssertTrue(view.isPrepareViewInvokes)
        XCTAssertEqual(view.prepareViewParameter.size, CGSize(width: 100, height: 100))
    }
}
```

Bir Device class'ımız var ve bunu doğrudan kullanmışız, test ederkende doğrudan elle değer verip test etmişiz peki farklı cihazlarda bu test çalışır mı?

Test ederkende bir if yazıp kontrol edebiliriz diyebilirsiniz ancak test'in içinde işlem yaparsanız o zaman testin testini yazmak gerekecek doğruluğundan emin olmak için.

### Çözüm:

```swift
import UIKit

class Device {
    var screenSize: Size {
        UIScreen.main.bounds.size
    }
}

/// LOGIC

class XYZPresenter {
    var screenSize: Size
    
    init(screenSize: Size = Device.screenSize) {
        self.screenSize = screenSize
    }
    
    func prepareView() {
       view.prepareView(size: screenSize)
    }
}

/// TEST

import XCTest

class XYZPresenterTest {
    var presenter: XYZPresenter = .init(screenSize: Size(100, 100))
    
    func test_prepareView_InvokesView() {
        XCTAssertFalse(view.isPrepareViewInvokes)
        
        presenter.prepareView()
        
        XCTAssertTrue(view.isPrepareViewInvokes)
        XCTAssertEqual(view.prepareViewParameter.size, CGSize(width: 100, height: 100))
    }
}
```

Çözüm olarak `XYZPresenter`'ın init yani başlangıç fonksiyonunda bir parametre aldık, bu parametre bizim ihtiyacımız olan screenSize bilgisi. Böylece testimizi yaparken istediğimiz değeri verdik ve bizim verdiğimiz değere göre işlem yapılıp yapılmadığını anlamış olduk.

Buradaki işlem sadece bir örnek, çok çeşitli şekilde uygulayabilirsiniz.  Özellikle Viper gibi mimariler kullanırken orada oldukça fazla protocol yazmanız ve bütün injection'larınızı protokoller üzerinden yapmalısınız. Bu konuyla alakalı bir video'yu aşağıya bırakıyorum.

[YouTube: Mimari 6: VIPER 🐍](https://www.youtube.com/watch?v=jsrkIPfGStc)
