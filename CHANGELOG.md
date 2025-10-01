# Değişiklik Geçmişi

Bu dosya APT Rehber projesindeki tüm önemli değişiklikleri içerir.

Format [Keep a Changelog](https://keepachangelog.com/tr/1.0.0/) standardını takip eder,
ve bu proje [Semantic Versioning](https://semver.org/lang/tr/) kullanır.

## [Yayınlanmamış]

### Planlanıyor
- İngilizce dil desteği
- İlerleme takip sistemi
- Video demo entegrasyonu
- Interaktif pratik egzersizleri
- Başarı sistemi (achievements)

## [1.0.0] - 2025-01-XX

### Eklenen
- ✨ İlk stabil sürüm
- 📚 5 kapsamlı eğitim modülü
- 🎯 15 soruluk interaktif quiz
- 🖥️ Tmux tabanlı çift panel arayüz
- 🔒 Otomatik bağımlılık kontrolü ve kurulumu
- 📖 Detaylı komut açıklamaları ve örnekleri
- 🎨 Renkli ve kullanıcı dostu terminal arayüzü
- ⌨️ Fare ve klavye navigasyon desteği

### Modüller
- **Modül 1**: Paket Yönetimi Temelleri ve APT Giriş
  - Paket yönetimi kavramları
  - Bağımlılık sistemi
  - apt vs apt-get karşılaştırması
  - Temel çalışma mekanizması

- **Modül 2**: Temel APT Komutları
  - Paket kurma ve kaldırma
  - remove vs purge detaylı açıklama
  - autoremove kullanımı
  - Pratik örnekler

- **Modül 3**: Paket Arama ve Listeleme
  - Gelişmiş arama teknikleri
  - Paket bilgilerini görüntüleme
  - İçerik inceleme (dpkg -L, dpkg -S)
  - Boyut ve disk kullanımı analizi
  - Önbellek yönetimi

- **Modül 4**: Konfigürasyon ve Güvenlik
  - sources.list detaylı inceleme
  - Depo türleri ve yönetimi
  - GPG anahtarları ve doğrulama
  - Güvenlik en iyi pratikleri
  - APT kilit sorunları çözümleri
  - Gelişmiş konfigürasyon (preferences, apt.conf)

- **Modül 5**: Gelişmiş Özellikler
  - Sürüm yönetimi ve downgrade
  - Paket hold/unhold işlemleri
  - Sistem yükseltme (distribution upgrade)
  - Geliştirici ortamları (LAMP, Node.js, Python)
  - Otomasyon scriptleri
  - Performans optimizasyonu
  - Pratik senaryolar (sunucu kurulumu, disk temizliği, sistem klonlama)

- **Modül 6**: Bilgi Yarışması
  - 15 çoktan seçmeli soru
  - Doğru/yanlış soruları
  - Anlık ilerleme takibi
  - Detaylı başarı analizi
  - Öğrenme önerileri

### Teknik Özellikler
- Tmux session yönetimi
- Modüler dosya yapısı
- Güvenli modül yükleme sistemi
- Error handling ve geri dönüş mekanizmaları
- Geçici dosya temizliği (trap kullanımı)
- Source edilebilir modül sistemi

### Dokümantasyon
- Kapsamlı README.md
- Katkı rehberi (CONTRIBUTING.md)
- Kurulum dokümantasyonu
- MIT Lisansı
- .gitignore yapılandırması

## [0.9.0] - 2025-01-XX (Beta)

### Eklenen
- Beta sürümü hazırlandı
- Temel modül yapısı oluşturuldu
- Quiz altyapısı geliştirildi

### Düzeltilen
- Quiz modülü çalışmama hatası düzeltildi
- Modül yükleme mekanizması iyileştirildi
- Progress bar matematiksel hataları giderildi
- Fonksiyon adlandırma tutarlılığı sağlandı

### Değiştirilen
- create_modules() fonksiyonu optimize edildi
- show_module() fonksiyonunda eval kullanımı kaldırıldı
- Error handling mekanizması geliştirildi

## [0.5.0] - 2025-01-XX (Alpha)

### Eklenen
- İlk prototip sürümü
- Temel 3 modül
- Basit quiz sistemi
- Tmux entegrasyonu

### Bilinen Sorunlar
- Quiz modülü çalışmıyor (0.9.0'da düzeltildi)
- Modül içerikleri eksik (1.0.0'da tamamlandı)
- Error handling yetersiz (0.9.0'da iyileştirildi)

## Değişiklik Türleri Açıklaması

- `Eklenen`: Yeni özellikler
- `Değiştirilen`: Mevcut özelliklerde değişiklikler
- `Kullanımdan Kaldırılan`: Yakında kaldırılacak özellikler
- `Kaldırılan`: Kaldırılan özellikler
- `Düzeltilen`: Hata düzeltmeleri
- `Güvenlik`: Güvenlik açıkları için

## Versiyon Numaralandırma

Proje [Semantic Versioning](https://semver.org/lang/tr/) kullanır:

- **MAJOR** (1.x.x): Geriye uyumsuz API değişiklikleri
- **MINOR** (x.1.x): Geriye uyumlu yeni özellikler
- **PATCH** (x.x.1): Geriye uyumlu hata düzeltmeleri

## Yol Haritası

### v1.1.0 (Planlanıyor)
- [ ] İngilizce dil desteği
- [ ] İlerleme kayıt sistemi
- [ ] Kullanıcı istatistikleri

### v1.2.0 (Planlanıyor)
- [ ] Interaktif pratik modu
- [ ] Video demoları entegrasyonu
- [ ] Sandbox test ortamı

### v2.0.0 (Gelecek)
- [ ] Başarı sistemi
- [ ] Topluluk modülleri
- [ ] Web tabanlı arayüz seçeneği

---

[Yayınlanmamış]: https://github.com/alibedirhan/Youtube-scripts/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/alibedirhan/Youtube-scripts/releases/tag/v1.0.0
[0.9.0]: https://github.com/alibedirhan/Youtube-scripts/releases/tag/v0.9.0
[0.5.0]: https://github.com/alibedirhan/Youtube-scripts/releases/tag/v0.5.0
