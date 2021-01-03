---
title: Swift Observer Pattern
date: 2020-09-11 12:00
tags: Swift, Software
description: Bazı durumlarda oluşan bir olay ile istediğimiz yerin tetiklenmesi ve bir işlem yapması gerekebilir. Bu durumda nasıl yapabileceğimize bakalım.

---
Observer'ın Türkçe karşılığı gözlemci olarak geçiyor. Kodlarımızda gözlemci ise neyi gözleyebilir? Bu sorunun bir çok cevabı olabilir örneğin bir değişkenimizde değişiklik yaparız ve değişkenimiz değiştiği zaman bir başka işlem tetiklenebilir. Başka bir örnek olarak arayüzde bir metin olsun ve bu metin bir başka sınıftan gelen verilere göre sürekli güncellensin. Observer pattern'i kurarak değişkeni istediğimiz yerden değiştirsek bile sadece değiştirmemiz yetsin. Bu yazı ile basit şekilde bir SwiftUI projesi yaparak observer pattern'i inceleyelim.

#### Başlarken
&nbsp;
Her ne kadar bu yazıda SwiftUI vee Combine ikilisini kullanacak olsam da mevcut UIKit uygulamalarında değişkene verilecek **didSet** özelliği ya da **Notification Center** kullanarak yapılabilir.
&nbsp;

```swift
var value = 0 {
    didSet {
        print("Value changed, new value: \(value)")
    }
}

value = 10
```
Örnekte görüldüğü gibi value değişkeni değiştirildiği zaman **didSet** çalışıp içerisine yazdıklarımızı gerçekleştirecek.
&nbsp;
&nbsp;
------------

### Başlıyoruz
&nbsp;

SwiftUI ile gelen özellikler içerinde bu konuda işimize yarayacak iki **property wrapper** var. Bu **property wrapper** konusunda blog yazısı yazmayı planlıyorum ancak şimdilik kısaca bahsedeyim. **Property wrapper** bir değişkene ekstra özellikler katmamıza olanak sağlıyor. Değişken üzerinde yapılacak değişikliklerle ekstra özellikler katabiliyoruz. Şimdi bize hangileri lazım:

- ObservableObject
- @Published
- @ObservedObject

ObservableObject aslında bir  **Property wrapper** değil. O bir protokol. Biz hangi sınıfımızdaki değişiklikleri observe etmek istiyorsak bu sınıfımıza ObservableObject protokolünü implemente ederek observe edilebilirlik özelliğini kazandırıyoruz.
&nbsp;
@Published ise observe edilecek olan değişkenimiz yani bu değişkendeki değişiklikler sonrası aksiyon alınacak.
&nbsp;
Geldik sonuncusuna @ObservedObject bu bir sınıftan instance oluşturduğumuz zaman bu sınıfı observe et, değişiklikleri izle demiş oluyoruz.
&nbsp;
&nbsp;
İlk olarak basit bir data class oluşturalım.

```swift
import SwiftUI

class DataClass: ObservableObject {
    @Published var value = 0
    var value2 = 0
    
    func changeValue() {
        value = Int.random(in: 0...100)
    }
    
    func changeValue2() {
        value2 = Int.random(in: 0...100)
    }
}
```
Özellikle incelemek için iki adet değişken ekledim biri @Published diğeri değil. Olay oldukça basit fonksiyonlar çağırılır ve değişkenler random olarak bir sayı alırlar.

&nbsp;
&nbsp;
Şimdi ise arayüz kodlarımızı inceleyim:

```swift
import SwiftUI

struct ContentView: View {
    @ObservedObject var data = DataClass()
    
    var body: some View {
        VStack {
            Spacer()
            Text(String(data.value))
            Text(String(data.value2))
            Spacer()
            Button("Change 1") {
                data.changeValue()
            }
            Button("Change 2") {
                data.changeValue2()
            }
            Spacer()
        }
    }
}
```
Basit şekilde @ObservedObject ile DataClass'tan bir intance oluşturduk. Arayüzde bir VStack içerisinde İki adet text ve iki adet buton koyduk. Adım adım çalıştırıp neler oluyor bakalım:
&nbsp;
&nbsp;
1. Başlangıçta her ikisinden beklendiği gibi 0 olarak ekrana yazıldı.
2. *Change 1* butonuna bastığımız anda ilk metnimiz random bir değer ile değişti.
3. *Change 2* butonuna bastığımız anda ise ekranda herhangi bir değişiklik göremedik. 🤔
4. Tekrar *Change 1* butonuna bastığımız anda ise her iki metnimizin de değiştiğini gördük. 😯😯😯

&nbsp;
&nbsp;
Çıktıları inceleyelim. Beklendiği gibi *Change 1* butonu işlevini yerine getirdi. *value2* değişkeni @Published özelliğine sahip olmadığı için *Change 2* butonuna basmak pek bir anlam ifade etmedi. Ancak neden *Change 2* butonuna bastıktan sonra *Change 1* butonuna basınca ikinci metin değişti?

SwiftUI arayüz değişikliklerinde ilgili kısmı tekrar oluşturmak yerine arayüzün tamamını oluşturduğu için yeniden oluşturma sırasında *value2*  değişkeninin değerini gidip tekrar okuması gerekti ve veriyi alırken güncellenmiş haliyle aldı bu sebeple güncellendi.


------------
&nbsp;
&nbsp;

Bu yazımda kısaca Observer Pattern konusunu SwiftUI ile anlatmaya çalıştım. Bana sorularınız için [iletişim](/contact) sayfasını kullanabilirsiniz, teşekkür ederim :)

