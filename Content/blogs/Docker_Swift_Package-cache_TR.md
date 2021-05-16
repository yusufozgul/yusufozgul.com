---
title: Docker ile Swift Kütüphaneleri Cache'ten okuma
date: 2021-05-16 10:08
tags: Swift, Docker
description: Docker üzerinde swift projelerimizi build alırken kütüphaneleri nasıl cache'te saklayabiliriz?
---

Yaptığım küçük bir Vapor projesini docker kullanarak ayağa kaldırdım, ancak değişikliklerden sonra her build sırasında hiç değişmeyen kütüphaneler sürekli yeniden indiriliyordu ve hem network hem de zaman kaybına sebep oluyordu.

### Peki bunu çözmek için ne yapabiliriz?

Aslında oldukça kolay, Docker her stepte dosyaların değişime göre karar işlem yapıyor. Yani bizim projemizi hiç değiştirmesek kütüphaneleri cache'ten alacaktı ama dosyalarımız değişiyor. O halde bizde sadece değişmeyenleri önce kopyalasak ardından geri kalanı kopyalasak nasıl olur?

```docker
# Copy entire repo into container
COPY . .

# Compile
RUN swift build -c release -Xswiftc -g
```

Copy ile tüm dosyaları container içine kopyaladık ve swift build komutunu çağırdık. Tamamen en baştan build alacağı için önce kütüphaneleri indirip ardından build alacak.

```docker
# Copy swift package file
COPY Package.swift .

# Download swift packages
RUN swift package resolve
```

Tüm dosyalarımı kopyalamadan önce sadece Package.swift dosyamızı kopyalarsak ve swift package resolve komutunu çağırırsak sadece kütüphaneler indirilir. Ardından build sırasında bu kütüphaneler tekrar indirilmez ve kullanılmaya devam edilir.

Peki bir sonraki build sırasında ne olur?

Sadece Package.swift dosyasını kopyaladık ve kütüphaneleri indirmesini söyledik. Buraya kadar olan kısımlar önceki build ile aynı dosyamız değişmedi çünkü. Bu durumda docker gidip cache'ten bunları okuyup geçecek ve böylece network ve zamandan kazanmış olacağız.

Bu kısa yazıda Docker'da swift package için optimizasyonu anlattım, okuduğunuz için teşekkür ederim.
