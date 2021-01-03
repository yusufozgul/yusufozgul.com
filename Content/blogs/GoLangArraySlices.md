---
title: Golang ile Array ve Slices
date: 2020-01-25 12:00
tags: Go Lang, Software, Go
description: Go dilinde Array ve Slices nasıl kullanılır?

---
Kendime yeni bir şeyler katmak ve özellikle api, backend taraflarında bilgi sahibi olmak için Go dilini öğrenmeye başladım. Aynı zamanda öğrendiklerimi de buradan paylaşmanın fena olmayacağını düşündüm. Vaktim olduğunca öğreneceğim Go hakkında ara sıra bir şeyler karalayacağım ilk olarak bakalım nasılmış bu Array ve Slices’lar.

### Array

Array yani dizi sanırım en aşina olunanıdır. Köşeli parantezler ” [] ” ile tanımlanan diziler verdiğimiz. sabit boyutta kullanılabilen yapılardır. Array kullanımı Go’da da oldukça basit şekilde.

```go
numbers := [6]int{1, 2, 3, 4, 5, 6}
```
Görüldüğü gibi değişkenime sabit 6 adet int eleman alabilecek ve aynı zamanda başlangıçta ayarladığımız bir dizi.

Eğer başlangıç değeri vermeseydik hepsine default int değeri olan 0 değerini verecekti.

Sürekli uzunluğu sayıp parantez içine yazacak mıyız? Bunun için ” […] ” şeklinde kullanabiliriz ancak dikkat etmemiz gereken kısımlar var başlangıç değerinde kaç değer veriyorsak o kadar uzunluğa sahip dizi oluşturulacaktır.

```go
numbers := [...]int{1, 2, 3, 4, 5, 6}
```
Bunlar işimi görmez ben internetten Json veri çekeceğim array içinde kaç veri gelecek bilemem bana esnek bir yapı lazım diyorsanız şimdiki kısım bunun için.

### Slices

Slices aslında veri tutan bir yapı değildir arkaplanda array kullanır ancak bize esnek bir kullanım sunar. Bir array bir slices kullanarak bakalım değişkenlerimizin tiplerine:

```go
package main
import (
"fmt"
"reflect"
)

func main() {
numbers := make([]int, 4) // slices
numbersArray := [4]int{} // Array

fmt.Println(reflect.TypeOf(numbers))
fmt.Println(reflect.TypeOf(numbersArray))
}
```
Bu kod çıktımız bize:
```plain
[]int
[4]int
```
şeklinde çıktı.

Buradaki yapı biraz farklı başlangıç için bir uzunluk değeri vermemiz lazım arrayde olduğu gibi. Tabi uzunluk değeri veriyorsak diziden ne farkı kaldı diyorsanız Slices ile belirlediğiniz uzunluğun üzerinde bir indise veri eklemeye çalıştığınız zaman sistem arkaplanda boyutunu 2 katına çıkarıyor. ?

Olay şu şekilde sizin başlangıçta belirlediğiniz uzunluk değeri 5 olsun. Ardından ilk 5 değeri verdiniz. Sonra ise 6. değeri eklemek istediğinizde arkaplanda sizin boyutunuz olan 5 iki katına çıkarılıp 10 yapılacak. yeni bir veri eklemek istediğinizde ise bu 10, iki ile çarpılıp 20 yapılacak. Hadi bakalım buna:

```go
package main
import (
"fmt"
)

func main() {
numbers := make([]int, 4)

fmt.Println(numbers)
fmt.Println(cap(numbers))
}
```

Bu kod çıktımız bize:
```plain
[0, 0, 0, 0]
4
```
şeklinde çıktı.

Ne yaptığımıza hemen bakalım. 4 uzunluğa sahip bir slices oluşturduk. Bunu ekrana yazdırdık bize default değer olan 0 değerlerini yazdı. Hemen altına ise slices’ımızın kapasitesini yani alabileceği uzunluğu yazdırdık. Tamda verdiğimiz gibi 4 çıktı. Yeni bir eleman ekleyelim.


```go
package main
import (
"fmt"
)

func main() {
numbers := make([]int, 4)

numbers = append(numbers, 1)

fmt.Println(numbers)
fmt.Println(cap(numbers))
}
```

Bu kod çıktımız bize:
```plain
[0, 0, 0, 0, 1]
8
```
şeklinde çıktı.



