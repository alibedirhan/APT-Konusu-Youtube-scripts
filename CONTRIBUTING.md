# 📰 Değişiklik Geçmişi

Bu dokümanda projenin sürüm geçmişi ve yapılan tüm önemli değişiklikler listelenmiştir.

Versiyon numaralandırması [Semantic Versioning](https://semver.org/) standartını takip eder: `MAJOR.MINOR.PATCH`

---

## [2.0.0] - 2025-10-17

### 🎉 Büyük Değişiklikler (BREAKING CHANGES)

#### Modüler Mimari Geçişi
- **Ana script yeniden yapılandırıldı**: `apt_rehber.sh` artık sadece yöneticilik yapıyor
- **Modüller ayrıldı**: Her modül artık `modules/` klasöründe ayrı dosya
- **Boyut optimizasyonu**: Ana script %85 daha küçük (54KB → 8KB)
- **Bakım kolaylığı**: Modül güncellemeleri artık çok daha kolay

### ✨ Yeni Özellikler

#### Shell Uyumluluğu
- Kullanıcının varsayılan shell'i otomatik algılanıyor
- Zsh, Bash, Fish, Ksh destekleniyor
- Oh-my-zsh, Powerlevel10k gibi temalar çalışıyor
- Kullanıcı alias'ları ve konfigürasyonları aktif

#### Gelişmiş Çıkış Seçenekleri
- **0 tuşu**: Menüden çık (terminal aktif kalır)
- **x tuşu**: Tümünü kapat (session tamamen sonlanır)
- **Ctrl+B → d**: Arka plana al (attach ile geri dön)
- Her seçenek menüde açıkça belirtildi

#### Modül Kontrol Sistemi
- Başlangıçta tüm modül dosyaları kontrol ediliyor
- Eksik modül varsa detaylı hata mesajı
- Dosya izinleri otomatik düzeltiliyor
- Git clone talimatları veriliyor

### 🔧 İyileştirmeler

#### Tmux Yönetimi
- Pane oluşturma mekanizması yenilendi
- Komut echo sorunu çözüldü
- Mouse mode varsayılan olarak aktif
- Layout optimizasyonu yapıldı

#### Hata Yönetimi
- Detaylı hata mesajları
- Kullanıcı dostu çözüm önerileri
- Otomatik hata kurtarma
- Logging iyileştirmeleri

#### Kullanıcı Arayüzü
- Menü metinleri daha açık
- Kontrol tuşları yeniden düzenlendi
- Progress indicator'ler eklendi
- Renkli geri bildirimler

### 🐛 Hata Düzeltmeleri

- **#001**: "can't find pane: 0" hatası düzeltildi
- **#002**: Modül kontrolü çift çalışma sorunu giderildi
- **#003**: Bash'e zorlama sorunu çözüldü (shell algılama)
- **#004**: Tmux session sonlandırma sorunu düzeltildi
- **#005**: Test terminali karışık çıktı problemi çözüldü

### 📝 Dokümantasyon

- README.md tamamen yenilendi
- INSTALL.md genişletildi ve detaylandırıldı
- CONTRIBUTING.md modüler yapıya uyarlandı
- Kod içi yorumlar iyileştirildi
- Ekran görüntüleri güncellendi

### 🏗️ Altyapı

- **Dosya yapısı**:
  ```
  APT YOUTUBE/
  ├── apt_rehber.sh (Ana yönetici - 8KB)
  ├── welcome.sh (Test terminali)
  └── modules/ (Modül dosyaları)
      ├── module_01.sh
      ├── module_02.sh
      ├── module_03.sh
      ├── module_04.sh
      ├── module_05.sh
      └── module_quiz.sh
  ```

### 🔄 Migrasyon Notları

**v1.x'ten v2.0'a geçiş:**

1. **Yedek alın**:
   ```bash
   cp apt_rehber.sh apt_rehber_v1_backup.sh
   ```

2. **Güncel versiyonu çekin**:
   ```bash
   git pull origin main
   ```

3. **Modüllerin varlığını kontrol edin**:
   ```bash
   ls modules/
   # 6 modül dosyası görmelisiniz
   ```

4. **Çalıştırın**:
   ```bash
   ./apt_rehber.sh
   ```

**Uyumluluk**: v1.x'te çalışan tüm özellikler v2.0'da da çalışıyor. Kullanıcı deneyimi değişmedi.

---

## [1.2.0] - 2024-10-01

### ✨ Yeni Özellikler
- Quiz modülü eklendi (15 soru)
- Progress bar sistemi eklendi
- Başarı sertifikası sistemi

### 🔧 İyileştirmeler
- Modül içeriği genişletildi
- Örnekler çoğaltıldı
- Açıklamalar detaylandırıldı

### 🐛 Hata Düzeltmeleri
- Quiz scoring hatası düzeltildi
- Less pager sorunları giderildi

---

## [1.1.0] - 2024-09-15

### ✨ Yeni Özellikler
- Modül 5 eklendi (Gelişmiş Özellikler)
- Modül 4 eklendi (Konfigürasyon ve Güvenlik)
- Otomatik bağımlılık kurulumu

### 🔧 İyileştirmeler
- Tmux mouse desteği eklendi
- Renkli çıktılar optimizasyonu
- Terminal boyutu adaptasyonu

---

## [1.0.0] - 2024-09-01

### 🎉 İlk Sürüm

#### Ana Özellikler
- 3 temel modül (1, 2, 3)
- Tmux çift panel arayüzü
- İnteraktif komut test terminali
- Türkçe içerik
- Renkli arayüz

#### Desteklenen Sistemler
- Ubuntu 20.04+
- Debian 11+
- Linux Mint 20+

#### Temel Fonksiyonlar
- Paket kurma/kaldırma öğretimi
- APT temel komutları
- Bağımlılık yönetimi
- Paket arama

---

## 📋 Sürüm Notları

### Sürüm Planlaması

#### [2.1.0] - Planlanan (Q4 2024)
- [ ] İngilizce dil desteği
- [ ] Video entegrasyonu
- [ ] Ekstra quiz soruları
- [ ] APT pinning modülü
- [ ] Performans optimizasyonları

#### [2.2.0] - Planlanan (Q1 2025)
- [ ] Web arayüzü (Electron tabanlı)
- [ ] Uzaktan öğrenme modu
- [ ] İlerleme takibi
- [ ] Sertifika sistemi
- [ ] Ödev/proje modülleri

#### [3.0.0] - Uzun Vadeli
- [ ] Diğer paket yöneticileri (dnf, pacman)
- [ ] Çoklu dil desteği
- [ ] Topluluk modülleri
- [ ] Plugin sistemi
- [ ] Cloud sync

---

## 🔗 Versiyonlar Arası Karşılaştırma

| Özellik | v1.0 | v1.1 | v1.2 | v2.0 |
|---------|------|------|------|------|
| Modül Sayısı | 3 | 5 | 5 | 5 |
| Quiz | ❌ | ❌ | ✅ | ✅ |
| Modüler Yapı | ❌ | ❌ | ❌ | ✅ |
| Shell Algılama | ❌ | ❌ | ❌ | ✅ |
| Otomatik Bağımlılık | ❌ | ✅ | ✅ | ✅ |
| Dosya Boyutu | 28KB | 35KB | 54KB | 8KB |
| Bakım Kolaylığı | ⭐⭐ | ⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ |

---

## 📞 İletişim

- **Issues**: https://github.com/alibedirhan/Youtube-scripts/issues
- **Discussions**: https://github.com/alibedirhan/Youtube-scripts/discussions
- **Email**: [your-email]

---

## 🙏 Teşekkürler

v2.0 sürümü için katkıda bulunan herkese teşekkürler:
- [@alibedirhan](https://github.com/alibedirhan) - Lead Developer
- Topluluk geri bildirimleri
- Beta test kullanıcıları

---

**Tüm değişiklik geçmişi için**: [GitHub Releases](https://github.com/alibedirhan/Youtube-scripts/releases)

[← Ana Sayfa](README.md)