# 🎓 APT Paket Yöneticisi - İnteraktif Öğrenme Rehberi

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/alibedirhan/Youtube-scripts)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/shell-bash-orange.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/platform-Debian%20%7C%20Ubuntu-red.svg)](https://www.debian.org/)

> Debian/Ubuntu tabanlı sistemler için etkileşimli APT öğrenme platformu. Tmux tabanlı çift panel arayüzü ile teori ve pratik bir arada!

## 📸 Ekran Görüntüsü

```
╔══════════════════════════════════════════════════════════════╗
║                     APT PAKET YÖNETİCİSİ                     ║
║                    İNTERAKTİF REHBERİ                        ║
║                                                              ║
║  Sol Panel: Rehber İçerik  │  Sağ Panel: Test Terminali     ║
╚══════════════════════════════════════════════════════════════╝

MODÜLLER:                          TEST TERMİNALİ
1. Paket Yönetimi Temelleri        ╔════════════════════════╗
2. Temel APT Komutları             ║ Komutları test edin    ║
3. Paket Arama ve Listeleme        ║ $ apt search firefox   ║
4. Konfigürasyon ve Güvenlik       ║ $ apt list --installed ║
5. Gelişmiş Özellikler             ╚════════════════════════╝
6. 🎯 BİLGİ YARIŞMASI (Quiz)
```

---

## ✨ Özellikler

- 🎯 **5 Kapsamlı Modül**: Temel seviyeden ileri seviyeye APT eğitimi
- 📚 **İnteraktif Quiz**: 15 soruluk bilgi yarışması ile öğrenmenizi test edin
- 🖥️ **Çift Panel Arayüz**: Sol panelde rehber, sağ panelde test terminali
- 🎨 **Renkli Arayüz**: Kolay okunabilir, modern görünüm
- 🔄 **Otomatik Kurulum**: Eksik bağımlılıkları otomatik kurar
- 🐚 **Shell Uyumlu**: Bash, Zsh, Fish - tüm shell'leri destekler
- 🖱️ **Fare Desteği**: Tmux mouse mode ile kolay navigasyon
- 📱 **Modüler Yapı**: Her modül ayrı dosyada, kolay güncelleme

---

## 🚀 Hızlı Başlangıç

### Gereksinimler
- Debian/Ubuntu tabanlı Linux dağıtımı
- Bash 4.0+
- Git

### Kurulum

```bash
# Repository'yi klonlayın
git clone https://github.com/alibedirhan/Youtube-scripts
cd Youtube-scripts/APT\ YOUTUBE/

# Scripti çalıştırılabilir yapın
chmod +x apt_rehber.sh

# Çalıştırın (bağımlılıklar otomatik kurulur)
./apt_rehber.sh
```

**İlk çalıştırmada ne olur?**
1. ✅ Sistem kontrolleri yapılır
2. ✅ Eksik bağımlılıklar (tmux, less) otomatik kurulur
3. ✅ Modül dosyaları kontrol edilir
4. ✅ Tmux oturumu başlatılır

---

## 📚 Modül İçeriği

### Modül 1: Paket Yönetimi Temelleri
- Paket yönetimi nedir?
- Bağımlılık (dependency) kavramı
- APT nedir ve nasıl çalışır?
- `apt` vs `apt-get` farkı
- `&&` operatörü kullanımı

### Modül 2: Temel APT Komutları
- Paket kurma (`apt install`)
- Paket kaldırma (`remove` vs `purge`)
- Gereksiz bağımlılıkları temizleme (`autoremove`)
- Pratik örnekler ve senaryolar

### Modül 3: Paket Arama ve Listeleme
- Paket arama (`apt search`)
- Yüklü paketleri listeleme (`apt list`)
- Paket bilgisi görüntüleme (`apt show`)
- Güncellenebilir paketler (`--upgradable`)

### Modül 4: Konfigürasyon ve Güvenlik
- `/etc/apt/sources.list` yapısı
- Depo yönetimi
- PPA kullanımı
- Güvenlik best practices

### Modül 5: Gelişmiş Özellikler
- Paket sürüm yönetimi
- Paket tutma (hold/unhold)
- Önbellek yönetimi
- Sorun giderme teknikleri

### Modül 6: Bilgi Yarışması 🎯
- 15 interaktif soru
- Anında geri bildirim
- Detaylı açıklamalar
- Başarı sertifikası

---

## 🎮 Kullanım

### Temel Kontroller

| Komut | İşlev |
|-------|-------|
| `1-5` | Modül seçimi |
| `6` | Quiz modülü |
| `0` | Menüden çık (terminal aktif kalır) |
| `x` | Tümünü kapat (session sonlandır) |
| `q` | Modül içinde ana menüye dön |

### Tmux Kontrolleri

| Kısayol | İşlev |
|---------|-------|
| `Fare tıklama` | Panel değiştirme |
| `Fare sürükleme` | Panel boyutu ayarlama |
| `Ctrl+B → ←→` | Klavye ile panel geçişi |
| `Ctrl+B → d` | Session'dan ayrıl (arka plan) |
| `Ctrl+B → [` | Scroll mode (↑↓ ile gezin, q ile çık) |

### Geri Dönme
```bash
# Session arka planda çalışıyorsa
tmux ls  # Aktif session'ları listele
tmux attach -t apt_rehber_<PID>  # Geri dön
```

---

## 🏗️ Proje Yapısı

```
APT YOUTUBE/
├── apt_rehber.sh          # Ana script (tmux yöneticisi)
├── welcome.sh             # Test terminali karşılama ekranı
├── modules/               # Modül dosyaları
│   ├── module_01.sh       # Paket Yönetimi Temelleri
│   ├── module_02.sh       # Temel APT Komutları
│   ├── module_03.sh       # Paket Arama ve Listeleme
│   ├── module_04.sh       # Konfigürasyon ve Güvenlik
│   ├── module_05.sh       # Gelişmiş Özellikler
│   └── module_quiz.sh     # Bilgi Yarışması
├── README.md              # Bu dosya
├── INSTALL.md             # Detaylı kurulum kılavuzu
├── CONTRIBUTING.md        # Katkı rehberi
├── CHANGELOG.md           # Değişiklik geçmişi
└── LICENSE                # MIT Lisansı
```

---

## 🔧 Sorun Giderme

### "can't find pane" Hatası
```bash
# Eski tmux session'larını temizle
tmux kill-server
./apt_rehber.sh
```

### "modules/ klasörü bulunamadı" Hatası
```bash
# Tam repo'yu klonladığınızdan emin olun
git clone https://github.com/alibedirhan/Youtube-scripts
cd Youtube-scripts/APT\ YOUTUBE/
ls modules/  # Modülleri kontrol et
```

### Bağımlılık Kurulum Hatası
```bash
# Manuel kurulum
sudo apt update
sudo apt install tmux less
```

### Türkçe Karakter Sorunu
```bash
# Locale ayarlarını kontrol edin
locale  # LC_ALL ve LANG değerlerini kontrol et
export LANG=tr_TR.UTF-8  # Gerekirse ayarlayın
```

---

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen [CONTRIBUTING.md](CONTRIBUTING.md) dosyasını okuyun.

**Katkı alanları:**
- 🐛 Hata düzeltmeleri
- ✨ Yeni özellikler
- 📝 Dokümantasyon iyileştirmeleri
- 🌍 Çeviri (İngilizce versiyonu)
- 🎨 Arayüz geliştirmeleri

---

## 📝 Lisans

Bu proje MIT Lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

---

## 👨‍💻 Yazar

**Ali Bedirhan**
- GitHub: [@alibedirhan](https://github.com/alibedirhan)
- YouTube: [Kanalınızın linki]

---

## 🙏 Teşekkürler

- Debian/Ubuntu topluluğuna paket yönetim sistemleri için
- Tmux geliştiricilerine harika terminal multiplexer için
- Tüm katkıda bulunanlara

---

## 📊 İstatistikler

- ⭐ Star'layarak destek olun!
- 🍴 Fork'layarak geliştirin!
- 🐛 Issue açarak hata bildirin!

---

## 🔗 Bağlantılar

- [Debian APT Dökümantasyonu](https://wiki.debian.org/Apt)
- [Ubuntu Paket Yönetimi](https://help.ubuntu.com/community/AptGet/Howto)
- [Tmux Kullanım Kılavuzu](https://github.com/tmux/tmux/wiki)

---

**⚡ Hızlı Başla:** `git clone https://github.com/alibedirhan/Youtube-scripts && cd Youtube-scripts/APT\ YOUTUBE && ./apt_rehber.sh`

**📺 Video Eğitim:** [YouTube video linki buraya]

---

<div align="center">

**Beğendiniz mi? ⭐ Star vermeden gitmeyin!**

Made with ❤️ for the Linux community

</div>