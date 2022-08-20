---
title: Github ve Swift kullanarak web sitemi nasıl yönetiyorum?
date: 2022-08-20 13:14
tags: Swift, Blog, Github, Github Actions
description: Bu sitenin temelinde yatan Otomasyon nedir, nasıl çalışır?
---

Paylaşmaya değer bulduğum konularda blog yazmak hem keyifli hem de zevkli ancak bunu bir çile haline getirmek istemiyorum. Çileden kastım yazdığım platform ve o platformun bakımı ve çalışır tutmakt. Elbette yazılarımı daha çok kitleye ulaşması için mediumda da paylaşıyorum ancak kişisel domainimi side projelerim ve diğer ihtiyaçlarım için aktif tutuyorum. Peki blog yazmayı nasıl çile haline getirmekten kurtarıyorum.

### Swift + Static Web Page + Github

Bu sayfanının görüntülenmesinde en çok katkı Github’a aittir. Çünkü kendi server’ımda host etmek yerine Github Pages üzerinden çalışıyor. Siteyi oluşturmak için ise Swift ile yazılmış Publish’i kullanıyorum. Temelde markdown dosyalarını HTML olarak çıktı veriyor. Github’da oluşturduğum bir repo içersinde iki adet branchten oluşuyor. İlki sirenin kaynak kodları diğeri ise build sonrası sitenin çıktısı. Elbette bunları build alıp repoya pushlamakla uğraşmıyorum. Bir yazıyı yazdıktan sonra repoya pushluyorum ve Github Actions çalışıp gerekli işlemleri benim yerime tamamlıyor.

### Planlarım

Tüm yazılarımı olmasa da Mediumda paylaşıyorum bunu import ederek yapıyorum ama bu işlemi de Github Actions ile çözüp paylaşabilirim. Belki bunun hakkında tekrar bir yazı yazarım.

### Sonuç Olarak

Repoyu incelemek isterseniz: [https://github.com/yusufozgul/yusufozgul.com](https://github.com/yusufozgul/yusufozgul.com)

Okuduğunuz için teşekkür eder, bir başka yazıda görüşmek dileğiyle.
