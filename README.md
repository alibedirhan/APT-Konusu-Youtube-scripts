# APT Rehber - İnteraktif APT Öğrenme Sistemi

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/bash-5.0+-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/platform-Linux-blue.svg)](https://www.linux.org/)

> Debian/Ubuntu tabanlı sistemlerde APT paket yöneticisini öğrenmek için kapsamlı, interaktif terminal uygulaması.

## 📖 Hakkında

APT Rehber, Linux kullanıcılarının APT (Advanced Package Tool) paket yöneticisini sıfırdan öğrenmesi için tasarlanmış interaktif bir eğitim aracıdır. Tmux tabanlı çift panel yapısıyla sol tarafta teorik bilgi sunarken, sağ tarafta gerçek zamanlı pratik yapma imkanı sağlar.

### ✨ Özellikler

- 🎯 **5 Kapsamlı Modül**: Temel kavramlardan ileri seviye özelliklere
- 🎮 **İnteraktif Quiz**: 15 soruluk kapsamlı bilgi yarışması
- 🖥️ **Çift Panel Yapısı**: Öğrenirken aynı anda pratik yapın
- 📚 **Detaylı Açıklamalar**: Her komut örneklerle açıklanmış
- 🔒 **Güvenli Öğrenme**: Tehlikeli komutlar işaretli
- 🚀 **Kolay Navigasyon**: Fare ve klavye desteği

## 📋 Gereksinimler

- Ubuntu 20.04+ / Debian 10+ / Linux Mint 20+
- Bash 5.0+
- tmux
- less
- sudo yetkisi

## 🚀 Kurulum

### Hızlı Kurulum

```bash
# Repoyu klonla
git clone https://github.com/alibedirhan/Youtube-scripts.git
cd Youtube-scripts

# Çalıştırma yetkisi ver
chmod +x apt_rehber.sh

# Başlat
./apt_rehber.sh
```

### Manuel Kurulum

```bash
# 1. Bağımlılıkları yükle
sudo apt update
sudo apt install tmux less

# 2. Script'i indir
wget https://raw.githubusercontent.com/alibedirhan/Youtube-scripts/main/apt_rehber.sh

# 3. Çalıştır
chmod +x apt_rehber.sh
./apt_rehber.sh
```

## 📚 Modüller

### Modül 1: Paket Yönetimi Temelleri
- Paket yönetimi nedir?
- Bağımlılık (dependency) kavramı
- APT vs apt-get farkı
- APT'nin çalışma mekanizması

### Modül 2: Temel APT Komutları
- Paket kurma/kaldırma
- Remove vs Purge farkı
- Gereksiz bağımlılıkları temizleme
- Pratik kullanım örnekleri

### Modül 3: Paket Arama ve Listeleme
- Gelişmiş arama teknikleri
- Paket içerik inceleme
- Boyut analizi
- Önbellek yönetimi

### Modül 4: Konfigürasyon ve Güvenlik
- sources.list yapısı
- Depo yönetimi
- GPG anahtarları
- Güvenlik en iyi pratikleri

### Modül 5: Gelişmiş Özellikler
- Sürüm yönetimi
- Sistem yükseltme
- Geliştirici ortamları
- Otomasyon scriptleri

### Modül 6: Bilgi Yarışması (Quiz)
- 15 interaktif soru
- Anlık geri bildirim
- Başarı analizi
- Öğrenme önerileri

## 🎮 Kullanım

### Temel Kontroller

```bash
# Script'i başlat
./apt_rehber.sh

# Menüde modül seç (1-6)
# Modül içinde:
#   q - Ana menüye dön
#   Yön tuşları - Yukarı/aşağı kaydır
#   Space - Sayfa aşağı

# Paneller arası geçiş:
#   Fare ile tıkla
#   Ctrl+B → Sol/Sağ ok
```

### Tmux Oturumundan Çıkış

```bash
# Geçici çıkış (arka planda çalışmaya devam eder)
Ctrl+B → d

# Geri dönüş
tmux attach -t apt_rehber_<PID>

# Tamamen kapat
Menüden 'x' tuşu veya '0' ile çık
```

## 🎯 Hedef Kitle

- Linux'a yeni başlayanlar
- APT komutlarını öğrenmek isteyenler
- Sistem yönetimi öğrencileri
- Ubuntu/Debian kullanıcıları

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen [CONTRIBUTING.md](CONTRIBUTING.md) dosyasını okuyun.

### Hızlı Katkı

1. Fork'layın
2. Feature branch oluşturun (`git checkout -b feature/YeniOzellik`)
3. Commit'leyin (`git commit -am 'Yeni özellik: XYZ'`)
4. Push'layın (`git push origin feature/YeniOzellik`)
5. Pull Request oluşturun

## 📝 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 🐛 Hata Bildirimi

Bir hata buldunuz mu? Lütfen [issue açın](https://github.com/alibedirhan/Youtube-scripts/issues).

## 📧 İletişim

- GitHub: [@alibedirhan](https://github.com/alibedirhan)
- Issues: [Proje Issues](https://github.com/alibedirhan/Youtube-scripts/issues)

## 🙏 Teşekkürler

Bu proje şu araçları kullanır:
- [tmux](https://github.com/tmux/tmux) - Terminal multiplexer
- [Bash](https://www.gnu.org/software/bash/) - Unix shell
- APT - Debian paket yöneticisi

## 📊 Proje Durumu

- ✅ Temel modüller tamamlandı
- ✅ Quiz sistemi aktif
- ✅ Tmux entegrasyonu
- 🔄 İngilizce çeviri (gelecek)
- 🔄 Video demoları (gelecek)
- 🔄 İlerleme takip sistemi (gelecek)

## ⭐ Yıldız Geçmişi

[![Stargazers over time](https://starchart.cc/alibedirhan/Youtube-scripts.svg)](https://starchart.cc/alibedirhan/Youtube-scripts)

---

**Not:** Bu proje eğitim amaçlıdır. Üretim sistemlerinde dikkatli kullanın.

Made with ❤️ by [Ali Bedirhan](https://github.com/alibedirhan)
