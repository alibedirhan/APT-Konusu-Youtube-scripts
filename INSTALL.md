# 📦 APT Rehber - Detaylı Kurulum Kılavuzu

Bu dokümanda APT Rehber scriptinin farklı sistemlerde nasıl kurulacağı ve çalıştırılacağı detaylı olarak açıklanmıştır.

---

## 📋 İçindekiler

- [Sistem Gereksinimleri](#sistem-gereksinimleri)
- [Otomatik Kurulum](#otomatik-kurulum)
- [Manuel Kurulum](#manuel-kurulum)
- [İleri Düzey Kurulum](#ileri-düzey-kurulum)
- [Sorun Giderme](#sorun-giderme)

---

## 🖥️ Sistem Gereksinimleri

### Desteklenen İşletim Sistemleri

✅ **Tam Destek:**
- Ubuntu 20.04+
- Debian 11+
- Linux Mint 20+
- Pop!_OS 20.04+

⚠️ **Kısmi Destek:**
- Debian 10 (tmux 2.8+ gerekli)
- Ubuntu 18.04 (eski tmux versiyonu)

❌ **Desteklenmiyor:**
- CentOS/RHEL (yum/dnf kullanır)
- Arch Linux (pacman kullanır)
- Fedora (dnf kullanır)

### Gerekli Bağımlılıklar

| Paket | Minimum Versiyon | Amaç | Otomatik Kurulum |
|-------|------------------|------|------------------|
| `bash` | 4.0+ | Script interpreter | ✅ Sistemde var |
| `tmux` | 2.6+ | Terminal multiplexer | ✅ Evet |
| `less` | 530+ | Sayfalayıcı | ✅ Evet |
| `apt` | - | Paket yöneticisi | ✅ Sistemde var |
| `git` | 2.0+ | Repository klonlama | ⚠️ Manuel |

### Donanım Gereksinimleri

| Kaynak | Minimum | Önerilen |
|--------|---------|----------|
| RAM | 512 MB | 1 GB+ |
| Disk | 50 MB | 100 MB+ |
| CPU | 1 Core | 2 Core+ |
| Ekran | 80x24 | 120x40+ |

---

## 🚀 Otomatik Kurulum

### Yöntem 1: Git ile Klonlama (Önerilen)

```bash
# 1. Repository'yi klonlayın
git clone https://github.com/alibedirhan/Youtube-scripts
cd Youtube-scripts/APT\ YOUTUBE/

# 2. Scripti çalıştırılabilir yapın
chmod +x apt_rehber.sh

# 3. Çalıştırın
./apt_rehber.sh
```

**İlk çalıştırmada:**
```
╔══════════════════════════════════════════════════════════════╗
║                     APT PAKET YÖNETİCİSİ                     ║
╚══════════════════════════════════════════════════════════════╝

Sistem kontrolleri yapılıyor...
✅ APT paket yöneticisi bulundu
✅ Root olmayan kullanıcı
⚠️  Eksik bağımlılıklar: tmux less

Gerekli paketler otomatik olarak kuruluyor...
[sudo] password for ali: 

✅ Tüm bağımlılıklar başarıyla kuruldu!
Script yeniden başlatılıyor...
```

### Yöntem 2: Tek Komut Kurulum

```bash
git clone https://github.com/alibedirhan/Youtube-scripts && \
cd Youtube-scripts/APT\ YOUTUBE && \
chmod +x apt_rehber.sh && \
./apt_rehber.sh
```

---

## 🔧 Manuel Kurulum

Otomatik kurulum çalışmazsa veya daha fazla kontrol istiyorsanız:

### Adım 1: Git Kurulumu

```bash
# Git yüklü mü kontrol edin
git --version

# Yoksa kurun
sudo apt update
sudo apt install git
```

### Adım 2: Repository Klonlama

```bash
# İstediğiniz dizinde
cd ~/Desktop  # veya istediğiniz yer

# Klonlama
git clone https://github.com/alibedirhan/Youtube-scripts

# Dizine girme
cd Youtube-scripts/APT\ YOUTUBE/
```

### Adım 3: Bağımlılıkları Kontrol

```bash
# Tmux kontrolü
if command -v tmux &> /dev/null; then
    echo "✅ tmux kurulu: $(tmux -V)"
else
    echo "❌ tmux yüklü değil"
    sudo apt install tmux
fi

# Less kontrolü
if command -v less &> /dev/null; then
    echo "✅ less kurulu"
else
    echo "❌ less yüklü değil"
    sudo apt install less
fi
```

### Adım 4: Dosya İzinleri

```bash
# Ana script
chmod +x apt_rehber.sh

# Welcome script
chmod +x welcome.sh

# Tüm modüller
chmod +x modules/*.sh

# Kontrol
ls -lh apt_rehber.sh
# -rwxr-xr-x ... apt_rehber.sh ← x olmalı
```

### Adım 5: Modül Kontrolü

```bash
# Modüllerin varlığını kontrol et
ls -1 modules/

# Beklenen çıktı:
# module_01.sh
# module_02.sh
# module_03.sh
# module_04.sh
# module_05.sh
# module_quiz.sh
```

### Adım 6: Çalıştırma

```bash
./apt_rehber.sh

# veya tam path ile
bash apt_rehber.sh
```

---

## 🔬 İleri Düzey Kurulum

### Sistem Geneli Kurulum

Script'i sistem genelinde kullanılabilir yapmak için:

```bash
# Script'i sistem dizinine kopyala
sudo cp apt_rehber.sh /usr/local/bin/apt-rehber

# Modülleri kopyala
sudo mkdir -p /usr/local/share/apt-rehber
sudo cp -r modules /usr/local/share/apt-rehber/
sudo cp welcome.sh /usr/local/share/apt-rehber/

# Script'i düzenle (SCRIPT_DIR yolunu güncelle)
sudo nano /usr/local/bin/apt-rehber

# Kullanım
apt-rehber  # Her yerden çalışır!
```

### Alias Tanımlama

```bash
# Bash için
echo 'alias apt-rehber="~/Youtube-scripts/APT\ YOUTUBE/apt_rehber.sh"' >> ~/.bashrc
source ~/.bashrc

# Zsh için
echo 'alias apt-rehber="~/Youtube-scripts/APT\ YOUTUBE/apt_rehber.sh"' >> ~/.zshrc
source ~/.zshrc

# Kullanım
apt-rehber  # Her yerden çalışır!
```

### Desktop Entry Oluşturma

GUI'den başlatmak için:

```bash
cat > ~/.local/share/applications/apt-rehber.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=APT Rehber
Comment=İnteraktif APT Öğrenme Platformu
Exec=gnome-terminal -- bash -c "cd ~/Youtube-scripts/APT\ YOUTUBE && ./apt_rehber.sh"
Icon=utilities-terminal
Terminal=true
Categories=Education;System;
EOF

# Uygulama menüsünden "APT Rehber" arayabilirsiniz
```

---

## 🐛 Sorun Giderme

### Sorun 1: "command not found: git"

**Çözüm:**
```bash
sudo apt update
sudo apt install git
```

### Sorun 2: "Permission denied" Hatası

**Çözüm:**
```bash
chmod +x apt_rehber.sh
chmod +x welcome.sh
chmod +x modules/*.sh
```

### Sorun 3: "modules/ klasörü bulunamadı"

**Neden:** Repository'nin sadece bir dosyası indirilmiş.

**Çözüm:**
```bash
# Tam repository'yi klonlayın
rm -rf Youtube-scripts  # Eski dosyaları sil
git clone https://github.com/alibedirhan/Youtube-scripts
cd Youtube-scripts/APT\ YOUTUBE/
ls modules/  # Kontrol et
```

### Sorun 4: "tmux: command not found"

**Çözüm:**
```bash
sudo apt update
sudo apt install tmux
```

### Sorun 5: Türkçe Karakterler Bozuk

**Çözüm:**
```bash
# Locale kontrol
locale

# Türkçe locale yükle
sudo apt install language-pack-tr
export LANG=tr_TR.UTF-8
export LC_ALL=tr_TR.UTF-8
```

### Sorun 6: "can't find pane" Hatası

**Çözüm:**
```bash
# Eski tmux session'larını temizle
tmux kill-server

# Script'i tekrar çalıştır
./apt_rehber.sh
```

### Sorun 7: Tmux Mouse Çalışmıyor

**Çözüm:**
```bash
# Tmux versiyonunu kontrol et
tmux -V

# 2.6'dan eskiyse güncelle
sudo apt update
sudo apt install tmux

# ~/.tmux.conf'a ekle (isteğe bağlı)
echo "set -g mouse on" >> ~/.tmux.conf
```

### Sorun 8: Script Root Olarak Çalışmıyor

**Neden:** Güvenlik önlemi. Root olarak çalıştırmak tehlikelidir.

**Çözüm:**
```bash
# Normal kullanıcı olarak çalıştırın
exit  # root'tan çık
./apt_rehber.sh  # Normal kullanıcı ile
```

---

## 🔄 Güncelleme

```bash
# Dizine git
cd ~/Youtube-scripts/APT\ YOUTUBE/

# Güncelleme çek
git pull origin main

# Çalıştır
./apt_rehber.sh
```

---

## 🗑️ Kaldırma

```bash
# Repository'yi sil
rm -rf ~/Youtube-scripts

# Sistem geneli kurulum yaptıysanız
sudo rm /usr/local/bin/apt-rehber
sudo rm -rf /usr/local/share/apt-rehber

# Alias kaldırma (Bash)
sed -i '/apt-rehber/d' ~/.bashrc

# Alias kaldırma (Zsh)
sed -i '/apt-rehber/d' ~/.zshrc

# Desktop entry kaldırma
rm ~/.local/share/applications/apt-rehber.desktop
```

---

## 📞 Destek

Sorun yaşıyorsanız:

1. 📖 Bu kılavuzu tekrar okuyun
2. 🔍 [Issues](https://github.com/alibedirhan/Youtube-scripts/issues) sayfasında arayın
3. 🆕 Yoksa [yeni issue](https://github.com/alibedirhan/Youtube-scripts/issues/new) açın
4. 💬 Detaylı bilgi verin:
   - İşletim sistemi (`lsb_release -a`)
   - Bash versiyonu (`bash --version`)
   - Tmux versiyonu (`tmux -V`)
   - Hata mesajı (tam çıktı)

---

## ✅ Kurulum Kontrol Listesi

Kurulumdan sonra kontrol edin:

- [ ] Git kurulu (`git --version`)
- [ ] Tmux kurulu (`tmux -V`)
- [ ] Repository klonlandı (`ls Youtube-scripts/`)
- [ ] Modüller mevcut (`ls modules/`)
- [ ] İzinler doğru (`ls -lh apt_rehber.sh`)
- [ ] Script çalışıyor (`./apt_rehber.sh`)
- [ ] Tmux açılıyor (iki panel görünüyor)
- [ ] Modüller açılabiliyor
- [ ] Quiz çalışıyor

---

**🎉 Kurulum tamamlandı! Öğrenmeye başlayabilirsiniz!**

[← Ana Sayfa](README.md) | [Katkı Rehberi →](CONTRIBUTING.md)