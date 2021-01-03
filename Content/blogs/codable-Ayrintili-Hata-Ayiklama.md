---
title: Swift Codable ayrıntılı hata ayıklama
date: 2020-08-24 16:14
tags: Swift, Codable, JSON, REST
description: İnternetten bir veriyi alıp ya da gönderirken JSON kullanarak aktarmak çok sık kullanılmaktadır. Swift 4 ile hayatımıza giren Codable aslında Decodable ve Encodable protokollerinin birleşiminden oluşmaktadır. Bu yazıda decode sırasında oluşan hataları ayrıntılı şekilde ele alacağız.

---
İnternetten bir veriyi alıp ya da gönderirken JSON kullanarak aktarmak çok sık kullanılmaktadır. Swift 4 ile hayatımıza giren Codable aslında Decodable ve Encodable protokollerinin birleşiminden oluşmaktadır. Bu yazıda decode sırasında oluşan hataları ayrıntılı şekilde ele alacağız.

JSON decode ederken bir çok farklı hata alabiliriz örneğin gelen data geçerli bir json olmayabilir ya da optional olmayan bir field nil gelmiş olabilir. Bunlar için bazı kod satırlarıyla hatanın tam hangi sebepten geldiğini anlayabileceğiz.

```swift
import UIKit

var jsonString: String = """
{
  "link": "https://yusufozgul.com",
  "data": [
    { "type": "comments", "content": "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir." },
    { "type": "comments", "content": "Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır." }
  ]
}
"""

struct CommentResponse: Codable {
    let link: String
    let data: [CommentResponseData]

    enum CodingKeys: String, CodingKey {
        case link
        case data
    }
}

struct CommentResponseData: Codable {
    let type: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case type
        case content
    }
}

let jsonData = jsonString.data(using: .utf8)

if let data = jsonData {
   
    do {
        
        /// json decode etmek için sınıfımızı oluşturuyoruz.
        let decoder = JSONDecoder()
        let response = try decoder.decode(CommentResponse.self, from: data) /// try ile deneyecek eğer başarısız olursa catch'e düşecek.
        print(response.link)
    } catch DecodingError.dataCorrupted(let context) {
        /// Eğer gelen data geçerli bir json değilse veya data ile ilgili başka bir sorun oluşmuşsa buradan hatayı yakalayabiliriz.
        
        print(context.debugDescription)
    } catch DecodingError.keyNotFound(let key, let context) {
        
        /// Struct'ta bir field var ancak bu optional değil. Gelen json'da bu field bulunamazsa hatamızı buradan yakalayabiliriz ve hangi field olduğunu anlayabiliriz.
        print("\(key.stringValue) was not found, \(context.debugDescription)")
    } catch DecodingError.typeMismatch(let type, let context) {
        
        /// Type safty önemli Struct'ı tanımlarken her field için tipini belirtiyoruz. Gelen json'daki field'ın tipi ile Struct'taki tip uyuşmadığı zaman hatayı buradan yakayabiliriz.
        print("\(type) was expected, \(context.debugDescription)")
    } catch DecodingError.valueNotFound(let type, let context) {
        
        /// Bir field ya optional'dır ya da değildir. Eğer Struct'ta optional tanımlamadınız ve json'da nil gelecek olursa hatayı buradan ele alabilirsiniz.
        print("no value was found for \(type), \(context.debugDescription)")
    } catch {
        
        /// En sonunda hata hala ele alınamamışsa burdan alıyoruz.
        print("Other Error")
    }
}
```


Umarım açıklayıcı olmuştur, bana sorularınız için iletişim sayfasını ya da yorumları kullanabilirsiniz, bir başka yazımda görüşmek üzere.

Proje Dosyası için: [GitHub hesabım](https://github.com/yusufozgul/Swift-Projects/tree/master/CodableDetailedDebugging.playground "GitHub hesabım")
