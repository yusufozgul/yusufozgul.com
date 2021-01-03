---
title: Compositional Layout
date: 2020-12-31 14:08
tags: Swift, CollectionView
description: Genellikle uygulamamızda bir sayfaya tüm içeriğimiz sığmaz, soldan sağa ya da yukarıdan aşağıya sürekli kaydırmamız gerekir. Peki her ikisini aynı anda yapmamız gerekiyorsa? Bu yazımda 2019 WWDC'de tanıtılan Compositional Layout nedir bakalım.

---

Genellikle uygulamamızda bir sayfaya tüm içeriğimiz sığmaz, soldan sağa ya da yukarıdan aşağıya sürekli kaydırmamız gerekir. Peki her ikisini aynı anda yapmamız gerekiyorsa? Bu yazımda 2019 WWDC'de tanıtılan Compositional Layout nedir bakalım.

Collection View iOS 6'dan beri hayatımızda, table view'un aksine çok daha esnek yapılar sunmamıza olanak sağlayan collection view günümüzdeki bir çok uygulamanın çeşitli yerlerinde kullanılıyor. Ancak collection view'un da kendine göre sorunları ve problemleri var. Örneğin Bir collection view'un sadece tek akış yönü vardır. Bir sayfada hem dikey hem de yatay kayan alanları iç içe kullanmak istersek genellikle yapılan dikey kayan bir cell'in içine bir collection view daha ekleyip bunu yatay kaydırmak olur. Peki bu ne kadar kolay 😔

![](/upload-images/Compositional-Layout/upload-688730711.png width=100%)

Böyle bir sayfayı tek collection view'da nasıl oluşturursunuz?

WWDC 2019'da tanıtılan ve biraz da SwiftUI'ın gölgesinde kalmış olan bir yenilik olan Compositional Layout adından da anlaşılabileceği üzere karma bir layout yapabiliyoruz.

Başlamadan önce kavramamız gereken şeyler var. Grup, Section, Item nedir gibi. Bunu anlamak için aşağıda bulunan görsel yardımcı olacak.

![](/upload-images/Compositional-Layout/upload-959451082.png width=100%)

- En dıştaki kısım yani Layout aslında bizim Collection View'umuz. Son durumda bir collection view'un bir layoutu olacak.
- Bir layout içerisinde section'lar bulundurur. Bu section'ların sayısı esnektir.
- Her section içerisinde Grup ve grup içerisinde item'ları tutar. Bir grup içinde bir item olabilir. Bir sectionda da bir grup olabilir. Bu bizim tasarımımıza kalmış bir durum.

Bu yapıyı aklımızda tutalım çünkü layout'u tasarlarken buna göre tasarlayacağız. Bir section içerisinde kodumuzda olması gereken bir kaç şey var. 

- Her item bir size'a sahip olmak zorunda,
- Her item bir grubun içerisinde olmalı,
- Her section içerisinde grup barındırmalı.

Bu şartları yerine getirmemiz gerekiyor.

Temel şekilde bir section şu yapıda:

```swift
private func productCellLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(1)) 
                // Genişlik: Sahip olabileceği maksimum genişliğin yarısı, Yükseklik: sahip olacabileceği maksimum genişlik

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                // Her kenarından inset verdik
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
                // Genişlik: Sahip olabileceği maksimum genişlikte, Yükseklik: Sahip olabileceği maksimum genişlikte
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        return layoutSection
    }
```

Bu kod parçası ile her satıra iki item gelecek şekilde aşağıya doğru akan bir collection view tasarlayabiliriz. Burada yükseklikleri belirlerken genişliği kullandım, bu kafa karıştırmasın düzgün bir dikdörtgen yapıda olmasını sağlayacak.

Peki yazımın başında belirttiğim collection view vertical hareket ederken, horizontal hareket eden section nasıl yapılır. Aslında yukarıdaki kod'a ekleyeceğimiz tek satır ile bunu yapabiliriz, sadece layout section'a vereceğimiz kod yetecek.

```swift
layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
```

Bu durumda vertical hareket eden section artık horizontal hareket edecek.

2020 yılının son yazısı olan bu yazımda kısaca compositional layout'tan bahsettim, eğer daha fazlasını merak ediyorsanız aşağıdaki linkler işinize yarayabilir.

- [https://www.youtube.com/watch?v=SR7DtcT61tA](https://www.youtube.com/watch?v=SR7DtcT61tA)
- [https://developer.apple.com/videos/play/wwdc2019/215/](https://developer.apple.com/videos/play/wwdc2019/215/)
