# Akıllı Şehir Yönetim Sistemi - Veri Yapıları Projesi

## Web Uygulaması ve Kaynaklar

* Web Uygulaması: [akillisehir.azurewebsites.net](https://akillisehir.azurewebsites.net/WebForm1)

---

##  Entegre Proje Önerisi: Akıllı Şehir Yönetim Sistemi

Şehir genelinde toplu taşıma, acil durum yönetimi, ürün ve hizmet talepleri gibi farklı alanları entegre eden bir sistem tasarlandı.
Her bölüm, yukarıdaki projelerden bir veya birkaçının konseptini içerir:

*  Toplu taşıma için **Graph (Graf)**
*  Acil durumlar için **Heap**
* Eczane ve Kütüphane Stok yönetimi için **HashTable**
* Personel girişi,Geri dönüş ve duyurular için **HashTable**

Proje, gerçek dünya problemlerine çözüm üretirken aynı zamanda veri yapılarının nasıl çalıştığını görsel ve uygulamalı olarak gösterir.

---

##  Grup Üyeleri ve Görev Dağılımları

| Üyeler           | Görevi                          |
| ---------------- | ------------------------------- |
| Semanur Erdoğan  | Toplu Taşıma                    |
| Dilara Cömert    | Ana Sayfa ve Personel Girişi    |
| Umut Çalışkan    | Dijital Kütüphane Stok Yönetimi |
| Eren Boylu       | İlaç Sorgulama - Stok Yönetimi  |
| Neslihan Özdemir | Acil Durum Yönetimi             |

---

## Proje Amacı ve Kapsamı

Bu projenin temel amacı, kullanıcıların bir web arayüzü üzerinden çeşitli veri yapılarıyla (**Graph**, **Heap**, **HashTable**, **List**) etkileşimde bulunarak bu yapıların nasıl çalıştığını görsel ve uygulamalı olarak öğrenmelerini sağlamaktır.

Proje, ASP.NET ve C# kullanılarak geliştirilmiş bir web uygulamasıdır. Uygulama, kullanıcıların seçilen veri yapıları üzerinde ekleme, silme ve arama gibi temel işlemleri gerçekleştirmelerine olanak tanır. Bu işlemler, görsel geri bildirimlerle desteklenerek kullanıcıların yapılan değişiklikleri anında gözlemlemeleri sağlanır.

**Proje Özellikleri:**

* Veri yapısı seçimi
* Temel işlemler (ekleme, silme, arama)
* Görsel geri bildirim
* Eğitsel içerik

---

##  Veri Yapısı Bazlı İşlevler ve Teknik Süreçler

###  Eren Boylu - İlaç Stok Yönetimi

**Veri Yapıları:** `Hashtable`

**Kullanılan Yapılar:**

* `pharmacyStocks`: Eczanelere ait ilaç bilgileri (iç içe Hashtable)
* `dutyPharmacies`: Nöbetçi eczanelerin boolean takibi

**Teknik Süreç:**

* Page\_Load: CSV'den ilaç/nöbetçi verisi yüklenir
* Login: Kullanıcı doğrulama ve oturum başlatma
* btnUpdateStock\_Click: Stok güncelleme ve CSV’ye kayıt
* btnSearch\_Click: İlaç arama
* btnToggleDuty\_Click: Nöbetçi eczane güncelleme

**Algoritma Analizi:**

* Stok Güncelleme: O(1)
* Arama: O(n)
* Nöbetçi Güncelleme: O(1)

---

### Dilara Cömert - Personel Girişi

**Veri Yapıları:** `Hashtable`

**Kullanılan Yapılar:**

* `Application["DilekListesi"]`: Kullanıcı geri dönüş mesajları
* `Application["Duyurular"]`: HTML duyuru içeriği
* `static Hashtable personelTablosu`: Giriş yetkisi olan personeller

**Teknik Süreç:**

* Page\_Load: Mevcut mesaj ve duyurular kontrol edilir
* btnGiris\_Click: Giriş işlemi ve Session açma
* btnGonder\_Click: Kullanıcı mesajı alma ve CSV’ye kaydetme
* btnDuyuruKaydet\_Click: Duyuru ekleme
* PersonelSayfası: Şikayetleri listeleme

**Algoritma Analizi:**

* Dilek Ekleme: O(1)
* Duyuru Ekleme: O(1)
* Dilekleri Listeleme: O(n)
* Giriş Kontrolü: O(1)
* Duyuru Gösterme: O(n)

---

### Neslihan Özdemir - Acil Durum Yönetimi

**Veri Yapıları:** `Heap`, `List`

**Kullanım Mantığı:**

* Heap: İhbarlara öncelik verir (Max-Heap)
* List: Gelen tüm ihbarları sırayla tutar

**Teknik Süreç:**

* Page\_Load: Heap oluşturulur
* btnGonder\_Click: Yeni ihbar alınır ve heap’e eklenir
* btnKodGiris\_Click: Ekip giriş kontrolü
* GuncelleIhbarListesi: Sıralı ihbar listesi
* btnCikar\_Click: Öncelikli ihbar çıkartılır

**Algoritma Analizi:**

* Ekle(): O(log n)
* Cikar(): O(log n)
* TumunuListele(): O(n)
* GuncelleIhbarListesi(): O(n log n)

---

###  Umut Çalışkan - Dijital Kütüphane

**Veri Yapıları:** `Hashtable`, `prefixHash`

**Teknik Süreç:**

* Sayfa Yükleme: kitaplar.json dosyasından veriler çekilir
* Arama: Prefix ile öneri sistemi
* kitap\_detay.aspx: Detay sayfasına bilgi yansıtma
* btnOduncAl: localStorage’a ödünç alındı kaydı
* Benzer kitaplar: Aynı kategoridekiler filtrelenir

**Algoritma Analizi:**

* Kitap Ekleme: O(1)
* Arama: O(1)/O(n)
* Detay Gösterme: O(1)
* Ödünç Alma: O(1)
* Benzer Kitap Listeleme: O(n)

---

###  Semanur Erdoğan - Toplu Taşıma

**Veri Yapıları:** `Graph`, `List`

**Teknik Süreç:**

* Page\_Load: Varsayılan durak ve hatlar yüklenir
* btnSorgula\_Click: Dijkstra ile en kısa rota hesaplanır
* EnKisaYoluBul(): Mesafeler hesaplanır
* RotayiHesaplaVeGoster(): Duraklar arası geçiş bilgisi sunulur

**Algoritma Analizi:**

* Dijkstra Algoritması: O((n + m) log n)
* Hat Ekleme: O(1)
* Durak Ekleme: O(1)
* Segment Hesaplama: O(k)
* Liste Üzerinde Arama: O(n)

---

##
