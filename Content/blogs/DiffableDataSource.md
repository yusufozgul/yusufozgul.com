---
title: Diffable Data Source
date: 2021-01-04 14:08
tags: Swift, CollectionView
description: Daha güvenilir, daha kullanışlı ve daha performanslı data source:  UICollectionViewDiffableDataSource

---

Bir önceki yazımda Collection View'da daha rahat daha esnek ve daha performanslı layout tasarlamayı anlatmıştım. Eğer okumadıysanız:

[Compositional Layout)](https://yusufozgul.com/blogs/CompositionalLayout/)

Bu yazımda ise Collection View'un bir diğer yönü olan data kısmındaki yeni Diffable Data Source'u anlatacağım.

### Bu zamana kadar nasıldı?

Collection View ya da Table View'u oluştururken ona data source veriyorduk, bu temelde bir protokol'ü implemente eden herhangi bir class. Bu içerisinde kaç cell olacağını, hangi index / section için nasıl bir view ve verisi olacağını belirlemeyi sağlıyordu. Bu açıdan oldukça kolay ve her türlü view'u kullanmak oldukça kolay. Ancak bazı kusurları var, öncelikle bu yapıda datanın güvenliğini sağlamak bizim görevimiz. Ona dersek ki sana 10 tane data ekledim, ancak elimizdeki modeli güncelleme sırasında bir sorun oluşursa crash, bir sebepten ötürü reload sırasında data silinir ya da başka bir şey olursa olmayan bir index'e erişmeye  çalışıp crash edebilir. Peki diffable data source?

### Diffable Data Source

> Bunu collection view üzerinden anlatacağım ama table view için isim değişikliği haricinde aynı şekilde kullanılabilir.

Bize lazım olan iki şey var, birincisi bir data source ikincisi aynı yapıda bir snapshot.

1) Data Source:

```swift
UICollectionViewDiffableDataSource<Section, Data>

// Section: Hashable
// Data: Hashable 
```

tipinde bir değişiklik, burada dikkat edilmesi gereken konu datanın aynı zamanda identifiable olduğunu sağlamak gerekiyor, buna göre data ayrıt edilip değişiklikler buna göre alınıyor.

```swift
dataSource = .init(collectionView: productListCollectionView, cellProvider: { (collectionView, indexPath, data) -> UICollectionViewCell? in
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier", for: indexPath) as? BannerCell
    cell?.image.loadImage(from: data.imageURL)
    return cell
})
```

Data source'u init ederken ona bizim collection view'umuzu verdik. Data source yaşadığı sürece bunu tutacak ve güncellemeleri yapacak. O ise bize collection view, indexPath, data bilgilerini veriyor. Burada asıl önemli detay bize datanın gelmesi, çünkü oraya gelen data kesin ve doğru olduğuna eminiz. Klasik şekilde cell'imizi oluşturduk ve datayı kullanarak içerisine gönderdik. Geriye kaldı tek bir şey.

2) Update:

Nispeten daha kolay bir olay yapmamız gereken bir snap shot oluşturmak ve data source'a göndermek.

```swift
NSDiffableDataSourceSnapshot<Section, Data>

// Section: Hashable
// Data: Hashable 
```

```swift
func updateView(sections: [Section]) {
    var snapShot = WidgetsSnapshot() // Snapshot oluştur
    snapShot.appendSections(sections) // Kullanılacak tüm section'ları ekle

    for section in sections {
        snapShot.appendItems(section.items, toSection: section) // her section'a verisini ekle
    }

    dataSource.apply(snapShot) // apply ederek güncellenmesini sağla ( animasyon seçeneği gönderilebilir, varsayılan true )
}
```

## Sonuç

Basit anlatımıyla bu şekilde olan diffable data source bize güzel şeyler sunuyor, değişenleri otomatik alıp bunu animasyonlu yapması, arkaplanda çok hızlı yapması, çökmelere karşı güvenilir olması gibi gibi. Eklemek isteiğim son bir iki şey ise bunun minimum iOS 13'te kullanılabiliyor olması dezavantaj olabilir, bir diğeri ise section ve data tanımlamalarında enum kullanabilirsiniz, özellikle section için enum kullanmak işleri kolaylaştırır.

### Daha fazlası:

[yusufozgul/DeezerSampleApp](https://github.com/yusufozgul/DeezerSampleApp)
