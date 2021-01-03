---
title: Swift Observer Pattern - 2
date: 2020-09-12 12:00
tags: Swift, Software
description: Bazı durumlarda oluşan bir olay ile istediğimiz yerin tetiklenmesi ve bir işlem yapması gerekebilir. Bu durumda nasıl yapabileceğimize bakalım.

---
Bir önceki yazımda SwiftUI ile Observer Pattern'in uygulamasını anlatmştım. Okumak isterseniz [şu linki](/blogs/observerPattern/) kullanabilirsiniz.
Bu yazımda ıse mevcut UIKit uygulamalarınızda Observer Pattern'i nasıl kullanabileceğinizi anlatacağım.

&nbsp;
&nbsp;
### Başlayalım
Burada izleyeceğimiz yaklaşım Notification Center ile değişiklerde uygulamamızı tetiklemek olacak.
&nbsp;
```swift
class DataManager {
    var value = 0 {
        didSet{ updateState() }
    }
    
    func change() {
        value = Int.random(in: 1...100)
    }
}

extension DataManager {
    internal func updateState() {
    
    }
}
```
Basit şekilde bir sınıf ve bu sınıfa yazdığım extension bulunuyor. Value değişkenini değiştirmek için bir fonksiyon ve value her değiştiğinde çalışan bir fonksiyon daha var.

Şimdi bu sınıfımıza notification center eklemeliyiz.
```swift
class DataManager {
    var value = 0 {
        didSet{ updateState() }
    }
    private let notificationCenter: NotificationCenter
    
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
    
    func change() {
        value = Int.random(in: 1...100)
    }
}

extension Notification.Name {
    static var valueChanged: Notification.Name {
        return .init("DataManager.ValueChanged")
    }
}
```

Notification Center init fonsiyonunda ayarlandı ve çalışmaya hazır bekliyor.
> Uygulamanızda Notification Name gibi String ifadeleri sürekli elle vermek yerine extension ile tek bir yerden alabilirsiniz. Daha ileriye götürmek isterseniz bunları sınıfınıza göre enum'da toplayabilirsiniz.

```swift
extension DataManager {
    internal func updateState() {
        notificationCenter.post(name: .valueChanged, object: value)
    }
}
```
Son olarak value değiştiğinde bir notification atacak şekilde güncelledik.

```swift
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = String(dataManager.value)
        addObserver()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(forName: .valueChanged, object: nil, queue: .main) { [weak self] (notification) in
            if let value = notification.object as? Int {
                self?.label.text = String(value)
            }
        }
    }
    
    @IBAction func changeButton(_ sender: Any) {
        dataManager.change()
    }
}
```
StoryBoard kullanarak bir label ve bir buton tanımladım. Butona basıldğı zaman DataManager sınıfımızda bulunan change metodunu çalıştırıyor.
addObserver fonksiyonu ise gönderdiğimiz notificationu dinlemek için. İçerisindeki object ile gönderdiğimiz veriyi alıp label'ı güncelledik.
&nbsp;
&nbsp;
Peki bu  `[weak self]` neyin nesi?
Bunu ekleme sebebim memory leak denilen olayı önlemeye yönelik. Eğer `[weak self]` eklemeseydik observer self'i yani ViewController'ı sürekli elinde tutmak isteyecekti. ViewController deinit olması gerektiği zaman observer onu sıkı sıkıya tuttuğu için deinit olamayıp bellekte uyulama kapanana kadar kalacaktı. `[weak self]` ile bu bağlatıyı sıkı sıkıya yapmamıza gerek kalmadı. ViewController deinit olası gerektiği zaman onu tutan bir şey olmadığı için deinit olabildi ve ayrıca iOS 8 sonrasında ViewController deinit olduğu zaman observer'da dinlemeyi otomatik olarak bıraktı. Bu şekilde memory leak olmadı.
&nbsp;

------------

&nbsp;
&nbsp;
Bu yazımda kısaca Observer Pattern konusunu UIKit ve Notification Center ile anlatmaya çalıştım. Bana sorularınız için [iletişim]("/contact") sayfasını kullanabilirsiniz, teşekkür ederim :)
