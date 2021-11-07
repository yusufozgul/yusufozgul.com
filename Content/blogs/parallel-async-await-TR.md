---
title: Swift Paralel Async İstekler
date: 2021-11-07 14:00
tags: Swift, Async-Await
description: Async Await ile birden fazla isteği aynı anda nasıl atabilirsiniz?
---

Swift 5.5 ile hayatımıza giren ve geriye uyumluluk desteği ile iOS 13 ve üzerinde kullanabildiğimiz Async Await ile nasıl aynı anda birden fazla istek atabiliriz?

### Async İstek Nasıl Atılır

Aşağıdaki örnek tipik bir async istek için kullanılabilecek fonksiyon tanımlanması

```swift
func fetchMovie() async throws -> MovieResponse {
    // ...
}
```

Fonksiyonun içerisini ise şu şekilde doldurabiliriz

```swift
func fetchMovie() async throws -> MovieResponse {
    let (data, response) = try await URLSession.shared.data(from: url)
        return try decoder.decode(MovieResponse.self, from: data)
}
```

Bu fonksiyonu çağırmak için ise normal fonksiyon çağrısı yapıp başına await eklememiz olacak.

Peki yukarıdaki şekilde her seferinde tek istekten veri alabiliriz aynı anda istek atıp tüm istekler gelince aynı anda nasıl alabiliriz?

```swift
func fetchAllMovies() async {
    var movies: [MovieResponse] = []
    
    try await withThrowingTaskGroup(of: MovieResponse.self, body: { taskGroup in
      for movieId in movies {
            taskGroup.addTask { try await self.fetchMovie(movieId: movieId) }
        }
        while let movie = try await taskGroup.next() {
            movies.append(movie)
        }
    })

    movies .... // all movies fetched
}
```

Şimdi adım adım inceleyelim, başlangıç olarak elimizde boş array var, ardından bir task group içinde bazı işlemler yaptık adından da anlaşılacağı üzere içinde birden fazla aynı iş yapmamızı ve hepsi bitince geriye dönmesini sağlıyor. For ile tüm isteklerimizi addTask diyerek ekledik, ardından while içinde task'ın sonucunun gelmesini bekledik. Tüm istekler sonuçlanınca array'imiz dolmuş oldu.

> Burada önemli bir noktayı belirtmek istiyorum bu withThrowingTaskGroup isteklerinizin attığımız sırayla gelmesini garanti etmez, bunun için sizin sonradan sıralama yapmanız gerekmektedir.


Bu blog yazısında nasıl aynı anda birden fazla istek atıp sonuçlarını await ile alabilirizi anlattım, okuduğunuz için teşekkür ederim, bu konuyu araştırırken okuduğum yazıları aşağıda bulabilirsiniz.

https://www.avanderlee.com/swift/async-await/
https://tanaschita.com/20210630-how-to-call-async-await-functions-concurrently/
https://www.avanderlee.com/swift/async-let-asynchronous-functions-in-parallel/
