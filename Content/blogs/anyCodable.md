---
title: Any Codable
date: 2023-02-01 20:00
tags: Swift, Codable, Json, Decode, Encode
description: Any tipini decode veya encode etmemiz gerekirse nasıl yaparız?

---

Swift codable kolayca data-model arasında decode veya encode işlemi yapmamızı sağlıyor. Peki elimizdeki generic şekilde decode veya encode nasıl yapabiliriz.

İlk olarak neden böyle bir şeye ihtiyacımız olsun ki sorusunu cevaplayalım, geliştirdiğim bir request mocking uygulaması tek bir dosya içine json formatında request body, response body, header gibi verileri formatlı şekilde saklama isteğim ile başta string olarak dosyaya ekledim ancak string olarak saklamak hem okuması zor hem de bu veriyi gösterirken sürekli ekstra encode decode yapmak gerekiyordu. Çözüm olarak Any tipini encode ve decode işlemi yapmam gerekti.

Swiftte Any tüm tipleri kapsayan bir tiptir, kullanabildiğimiz bütün tipler aslında Any’dir. Ancak Any encodable veya codable desteklemez. Ancak encode ve decode methodlarını kendimiz yazarak destek sağlayabiliriz. Temelde Any üzerinden decode veya encode yapacağız ama bu işlem sırasında Any tipini codable bir tip’e cast edip yapmalıyız.

### Decode

Decode işlemi data tipini alıp elimizdeki bir modele çevirebiliriz, datayı tek tek okuyup tipini belirleyip decode işlemi yapabiliriz. Json root olarak iki tipte olabilir, Array veya key value şeklinde dictionary.

1. İlk olarak gelen datanın Dictionary ya da Array olduduğunu belirlemek gerekir

```swift
func decode(_ type: Any.Type, forKey key: K) throws -> Any {
        if let container = try? self.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key),
           let value = try? container.decode([String: Any].self) {
            return value
        } else if var container = try? self.nestedUnkeyedContainer(forKey: key),
                  let value = try? container.decode([Any].self) {
            return value
        } else {
            throw EncodingError.invalidValue(key, .init(codingPath: codingPath, debugDescription: "Invalid JSON value"))
        }
    }
```

2. Dictionary datayı decode etmek, for loop yardımıyla if let ile tipi belirleyip decode işlemi yapılıyor

```swift
func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        var dictionary = [String: Any]()

        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = boolValue
            } else if let stringValue = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = stringValue
            } else if let intValue = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = intValue
            } else if let doubleValue = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = doubleValue
            } else if let nestedDictionary = try? decode([String: Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionary
            } else if let nestedArray = try? decode([Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedArray
            } else {
                do {
                    if try decode(String?.self, forKey: key) == nil {
                        dictionary[key.stringValue] = nil
                    }
                } catch { }
            }
        }
        return dictionary
    }
```

3. Array decode etmek ise Dictionary ile oldukça yakın, for loop ile listeyi dönüp tipini belirleyip decode etmek yeterli

```swift
func decode(_ type: [Any].Type) throws -> Any {
        var array = [Any?]()

        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                array.append(boolValue)
            } else if let stringValue = try? decode(String.self, forKey: key) {
                array.append(stringValue)
            } else if let intValue = try? decode(Int.self, forKey: key) {
                array.append(intValue)
            } else if let doubleValue = try? decode(Double.self, forKey: key) {
                array.append(doubleValue)
            } else if let nestedDictionary = try? decode([String: Any].self, forKey: key) {
                array.append(nestedDictionary)
            } else if let nestedArray = try? decode([Any].self, forKey: key) {
                array.append(nestedArray)
            } else {
                do {
                    if try decode(String?.self, forKey: key) == nil {
                        array.append(nil)
                    }
                } catch { }
            }
        }
        return array
    }
```

### Encoding

Encode işlemi decode işleminin tam tersidir, ancak mantık olarak oldukça yakın, tipi belirle encode et

1. Root tipi belirlemek

```swift
mutating func encode(_ value: Any, forKey key: Key) throws {
        if let jsonValue = value as? [Any] {
            var unkeyedContainer = self.nestedUnkeyedContainer(forKey: key)
            try unkeyedContainer.encode(jsonValue)
        } else if let jsonValue = value as? [String: Any] {
            var keyedContainer = self.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
            try keyedContainer.encode(jsonValue)
        } else if let jsonValue = value as? EmptyResponse {
            var unkeyedContainer = self.nestedUnkeyedContainer(forKey: key)
            try unkeyedContainer.encode(jsonValue)
        } else {
            throw EncodingError.invalidValue(key, .init(codingPath: codingPath, debugDescription: "Invalid JSON value"))
        }
    }
```

2. Dictionary tipi encode etmek, for loop yardımıyla key value şeklinde dönüp tipi belirleyip encode edebiliriz

```swift
mutating func encode(_ value: [String: Any]) throws {
        try value.forEach({ (key, jsonValue) in
            let key = JSONCodingKeys(stringValue: key)
            switch jsonValue {
            case let value as Bool where (type(of: jsonValue) == type(of: NSNumber(booleanLiteral: true)) || type(of: jsonValue) == Swift.Bool.self):
                try encode(value, forKey: key)
            case let value as Int:
                try encode(value, forKey: key)
            case let value as String:
                try encode(value, forKey: key)
            case let value as Double:
                try encode(value, forKey: key)
            case let value as CGFloat:
                try encode(value, forKey: key)
            case let value as [String: Any]:
                try encode(value, forKey: key)
            case let value as [Any]:
                try encode(value, forKey: key)
            case Optional<Any>.none, is NSNull:
                try encodeNil(forKey: key)
            default:
                throw EncodingError.invalidValue(value, .init(codingPath: codingPath, debugDescription: "Invalid JSON value"))
            }
        })
    }
```

3. Array tipi ise yine aynı şekilde for loop ile dönüp tipi belirleyip encode edebiliriz

```swift
mutating func encode(_ value: [Any]) throws {
        try value.enumerated().forEach({ (index, jsonValue) in
            switch jsonValue {
            case let value as Bool where (type(of: jsonValue) == type(of: NSNumber(booleanLiteral: true)) || type(of: jsonValue) == Swift.Bool.self):
                try encode(value)
            case let value as Int:
                try encode(value)
            case let value as String:
                try encode(value)
            case let value as Double:
                try encode(value)
            case let value as CGFloat:
                try encode(value)
            case let value as [String: Any]:
                try encode(value)
            case let value as [Any]:
                var unkeyedContainer = self.nestedUnkeyedContainer()
                try unkeyedContainer.encode(value)
            case Optional<Any>.none, is NSNull:
                try encodeNil()
            default:
                let keys = JSONCodingKeys(intValue: index).map({ [ $0 ] }) ?? []
                throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath + keys, debugDescription: "Invalid JSON value"))
            }
        })
    }
```

Elbette bu kod parçaları doğrudan Any tipini decode veya encode etmeye yeterli değil. Tamamını bir swift package şeklinde Github hesabım üzerinden yayınladım. Dilerseniz basit dependency’i projenize ekleyip kullanabilirsiniz. Link: [https://github.com/yusufozgul/AnyCodable](https://github.com/yusufozgul/AnyCodable). 
Okuduğunuz için teşekkür ederim, sonraki yazıda görüşmek dileğiyle.

