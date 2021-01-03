---
title: Swift ARC
date: 2020-10-28 14:06
tags: Swift, Software
description: Swift programlama dilinde bellek yönetimi nasıl yapılıyor, bellek yönetimi neden önemlidir?

---


Bir donanım üzerinde çalışan yazılımlar çalıştıkları sırada üzerinde bulunduğu donanım kaynaklarını kullanırlar. Yazılımların kullandığı kaynakların elbette bir sınırlaması olmalı çünkü genellikle bir donanım üzerinde birden fazla yazılım aynı anda çalışmakta ve sadece tek donanımı paylaşmaktadırlar. Burada en çok dikkat etmemiz gereken donanım bellek çünkü depolama birimleri eğer bir cache mekanizması kullanmıyorsak ya da sonradan depolama yapmıyorsak kurulduğu şekilden çok fazla artmazlar. Ancak kodumuz çalışırken bellekte yer kaplar ve çalıştığı süre boyunca farklı işlemler yaparak bellekte daha fazla yere ihtiyaç duyar aynı zamanda artık bir daha kullanmayacağımız alanlar oluşur. Kaynaklardan bir diğeri ise CPU. CPU zaten işletim sisteminin sahip olduğu CPU scheduling algorithms ( CPU zamanlama algoritmaları) sayesinde her işleme karşı belirli bir sınırın üzerinde çalışma izni vermemekte, çok ağır işlemlere zorlayacak olursak zaten kodumuz çalışmayacaktır. Sonuç olarak bizim bellek kullanımımızı sürekli kontrol altına almamız gerekiyor.
&nbsp;
&nbsp;

Eski programlama dillerinde bellek yönetimi otomatik olarak yapılmıyordu ve kodu yazan kişinin bellekte ayırdığı yer ile işi bittiği zaman temizlemesi gerekiyordu. Ancak modern diller ile bellek yönetimi otomatik hale getirildi ve artık ayrılan yere ihtiyaç duyulmayacaksa bellekten otomatik kaldırılıyor. Bunun için iki yöntem anlatacağım: Garbage Collector ( Çöp toplayıcısı ) ve Automatic Reference Counting ( Otomatik referans sayımı )
&nbsp;
&nbsp;
&nbsp;

#### Garbage Collector:
&nbsp;
Bellekte uygulamanın kullandığı alanları üç parçaya bölerek bunları kategorilendirir ve uygulama threadlerinin uygun olduğu durumlarda tüm threadleri durdurarak temizleme işlemi gerçekleştirir. (1)
Bu yazıda ARC konusuna odaklandığım için kaynaklardaki yararlandığım link üzerinden Garbage Collector hakkında ayrıntılara bakabilirsiniz.
&nbsp;
&nbsp;


#### Automatic Reference Counting
&nbsp;
Swift uygulamamızın çalışma sırasında bellek yönetimi için ARC kullanır. İşlem olarak Garbage Collector ile aynı amacı taşımaktadır artık kullanılmayan ayrılmış bellek alanlarını temizlemek. Peki bunu neye göre yapıyor?
&nbsp;
Elimizde bir değişken olsun ve bu değişkene bir sınıftan nesne üretelim ve bunu bir fonksiyon içinde tanımlayalım. Fonksiyon içerisinde işlemlerimizi tamamladığımız zaman ARC artık bu nesneye ihtiyaç duyan kimse olmadığı için otomatik olarak temizleyecektir.
&nbsp;
Örneğin elimizde bir class olsun ve bu class'ı bir değişkende nesnesini oluşturalım. Ardından oluşturduğumuz bu nesneyi farklı bir değişkene daha verelim. Elimizde aynı nesneyi referans eden iki adet değişkenimiz var. İlk oluşturduğumuz değişkeni artık nil yapalım. Bu durumda nesnemizi değişkenimize verirken ARC ilk oluşturma sırasında 1 olarak saydı ardından ikinci değişkene aynı nesneyi verdiğimiz için ARC bu değeri 2 yaptı son olarak ilk oluşturduğumuzu nil yaptık ARC bu sefer sayıyı bir azaltarak 1 olarak güncellendi. Bu durumda nesnemizi hala kaybetmedik. Eğer elimizdeki tek değişkeni de nil olarak eşitlersek toplam referans sayısı 0 olacak ve ARC temizleme işlemini yerine getirecek.
&nbsp;
&nbsp;
![](/upload-images/Swift-ARC/upload-008525674.png  width=100%)
&nbsp;
&nbsp;
Peki her şey bu kadar harika şekilde ilerliyor ve ARC bizim için tüm işlerimizi zahmetsiz şekilde yerine getiriyor mu? Elbette hayır bizim dikkat etmemiz gereken şeyler de var.
&nbsp;
&nbsp;


#### Weak Referanslar
&nbsp;
Bunu anlatmak için VIPER mimarisini örnek vereceğim. VIPER mimarisinde Presenter View'da güncelleme yapabilmesi için View referansını tutması gerekmektedir. Aynı zamanda View'da Presenter'a bazı şeyler söylemeli ki aralarında iletişim olsun. Bu durumda View'da Presenter'ın referansını tutacaktır. Sanki bir çıkmaza giriyoruz, biraz daha bakalım. Kullandığımız sayfada işimiz bitti kapattık. ARC kontrol edecek ve temizlemek isteyecektir ama View'u temizlemek için Presenter'ın temizlenmesi gerekiyor. Presenter'ı temizlemek istese bu sefer View'un temizlenmesi gerekiyor ki referans sayımız 0 olsun ve temizlenebilsin. Bir çıkmaza düştük ve feransımız uygulama açık kalıncaya kadar yaşayacak. Bunun çözümü için oluşturduğumuz değişkene weak ön ekini veriyoruz. Böylece ARC bunu saymayarak döngü oluşumunun önüne geçiliyor. VIPER mimarisinde Presenter içinde bulunan View referansına weak vererek View denit edildiği sırada Presenter kolayca deinit yapılabiliyor ve herhangi bir problem kalmıyor.
&nbsp;

Bu yazıyı elbette unowned, strong ve bunların optional hallerini de dahil edip detaylandırmak mümkün ancak yazının daha da uzamaması ve aşağıya eklediğim resmi Swift dokümanında çok daha detaylı bilgiler olduğu için eğer ilginizi çekiyorsa aşağıdan ulaşabilirsiniz.
&nbsp;
&nbsp;
Okuduğunuz için teşekkür ederim. Eğer bana sorularınız varsa link'ten bana ulaşabilirsiniz, teşekkür ederim 🙂

1 = [https://medium.com/@gokhansengun/garbage-collector-nasıl-çalışır-3bdf2fb20282](https://medium.com/@gokhansengun/garbage-collector-nasıl-çalışır-3bdf2fb20282)

2 = [https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html)
