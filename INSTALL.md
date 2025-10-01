# Kurulum Rehberi

APT Rehber'i sisteminize kurma adımları.

## Sistem Gereksinimleri

### Desteklenen İşletim Sistemleri

- Ubuntu 20.04 LTS veya üstü
- Debian 10 (Buster) veya üstü
- Linux Mint 20 veya üstü
- Pop!_OS 20.04 veya üstü
- Elementary OS 6 veya üstü

### Minimum Gereksinimler

- **İşlemci**: 1 GHz veya daha hızlı
- **RAM**: 512 MB (1 GB önerilir)
- **Disk Alanı**: 50 MB
- **Bash Versiyonu**: 5.0 veya üstü
- **İnternet**: Bağımlılık kurulumu için gerekli

### Gerekli Paketler

- `bash` (5.0+)
- `tmux` (2.6+)
- `less` (veya `more`)
- `sudo` yetkisi

## Kurulum Yöntemleri

### Yöntem 1: Git ile Klonlama (Önerilen)

```bash
# 1. Repoyu klonla
git clone https://github.com/alibedirhan/Youtube-scripts.git

# 2. Dizine gir
cd Youtube-scripts

# 3. Çalıştırma yetkisi ver
chmod +x apt_rehber.sh

# 4. Çalıştır
./apt_rehber.sh
```

### Yöntem 2: Wget ile İndirme

```bash
# 1. Script'i indir
wget https://raw.githubusercontent.com/alibedirhan/Youtube-scripts/main/apt_rehber.sh

# 2. Çalıştırma yetkisi ver
chmod +x apt_rehber.sh

# 3. Çalıştır
./apt_rehber.sh
```

### Yöntem 3: Curl ile İndirme

```bash
# 1. Script'i indir ve çalıştırma yetkisi ver
curl -fsSL https://raw.githubusercontent.com/alibedirhan/Youtube-scripts/main/apt_rehber.sh -o apt_rehber.sh && chmod +x apt_rehber.sh

# 2. Çalıştır
./apt_rehber.sh
```

### Yöntem 4: Manuel Kurulum

1. [Releases](https://github.com/alibedirhan/Youtube-scripts/releases) sayfasından son sürümü indirin
2. ZIP dosyasını açın
3. Terminal'de dizine gidin
4. Çalıştırma yetkisi verin: `chmod +x apt_rehber.sh`
5. Çalıştırın: `./apt_rehber.sh`

## Otomatik Bağımlılık Kurulumu

Script ilk çalıştırıldığında eksik bağımlılıkları otomatik olarak tespit eder ve kurar:

```bash
./apt_rehber.sh
# Çıktı:
# Eksik bağımlılıklar tespit edildi: tmux less
# • tmux: Çift panel deneyimi için
# • less: Modül içeriklerinde sorunsuz navigasyon için
# Gerekli paketler otomatik olarak kuruluyor...
```

## Manuel Bağımlılık Kurulumu

Bağımlılıkları önceden kurmak isterseniz:

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install tmux less git

# Diğer dağıtımlar için APT mevcut değil,
# bu nedenle bu script Ubuntu/Debian dışında çalışmaz
```

## Kurulum Doğrulama

Kurulumun başarılı olduğunu kontrol edin:

```bash
# Script çalışıyor mu?
./apt_rehber.sh

# Bağımlılıklar yüklü mü?
which tmux
which less
which bash

# Bash versiyonu uygun mu?
bash --version
```

## Kurulum Sorunları ve Çözümleri

### Sorun 1: "Permission denied" Hatası

```bash
# Hata
bash: ./apt_rehber.sh: Permission denied

# Çözüm
chmod +x apt_rehber.sh
```

### Sorun 2: "tmux: command not found"

```bash
# Çözüm: tmux'u manuel kur
sudo apt update
sudo apt install tmux
```

### Sorun 3: "Bu script APT paket yöneticisi olan sistemlerde çalışır"

Bu hata APT olmayan sistemlerde (Fedora, Arch, vb.) çıkar. Maalesef script sadece Debian/Ubuntu tabanlı sistemlerde çalışır.

### Sorun 4: "HATA: Bu scripti root kullanıcısı olarak çalıştırmayın!"

```bash
# Yanlış
sudo ./apt_rehber.sh

# Doğru
./apt_rehber.sh
# Script gerektiğinde sudo isteyecektir
```

### Sorun 5: Git Kurulu Değil

```bash
# Git'i kur
sudo apt install git

# Sonra repoyu klonla
git clone https://github.com/alibedirhan/Youtube-scripts.git
```

### Sorun 6: İnternet Bağlantısı Yok

Bağımlılık kurulumu için internet gereklidir. Offline kurulum için:

1. İnterneti olan başka bir makinede tmux ve less paketlerini indirin:
```bash
apt download tmux less
```

2. .deb dosyalarını USB ile taşıyın

3. Offline makinede kurun:
```bash
sudo dpkg -i tmux*.deb less*.deb
```

## Sistem PATH'e Ekleme (Opsiyonel)

Script'i her yerden çalıştırabilmek için:

```bash
# 1. Script'i /usr/local/bin'e kopyala
sudo cp apt_rehber.sh /usr/local/bin/apt-rehber

# 2. Artık her yerden çalıştırabilirsiniz
apt-rehber
```

## Alias Oluşturma (Opsiyonel)

Kısa bir komutla çalıştırmak için:

```bash
# .bashrc veya .zshrc'ye ekle
echo "alias apt-rehber='cd ~/Youtube-scripts && ./apt_rehber.sh'" >> ~/.bashrc

# Değişiklikleri yükle
source ~/.bashrc

# Artık sadece şunu yazmanız yeterli
apt-rehber
```

## Güncelleme

### Git ile Güncelleme

```bash
cd Youtube-scripts
git pull origin main
```

### Manuel Güncelleme

1. Yeni sürümü [Releases](https://github.com/alibedirhan/Youtube-scripts/releases) sayfasından indirin
2. Eski dosyaların yerine yeni dosyaları koyun

## Kaldırma

Script'i kaldırmak için:

```bash
# 1. Dizini sil
rm -rf Youtube-scripts

# 2. İlerleme dosyasını sil (opsiyonel)
rm -f ~/.apt_rehber_progress

# 3. PATH'e eklediyseniz
sudo rm /usr/local/bin/apt-rehber

# 4. Alias eklediyseniz
# .bashrc veya .zshrc'den ilgili satırı silin
```

## İlk Çalıştırma

İlk kez çalıştırdığınızda:

1. Script bağımlılıkları kontrol eder
2. Eksik olanları kurmak için onay ister
3. Modül dosyalarını oluşturur
4. Tmux session başlatır
5. Ana menüyü gösterir

**İpucu**: İlk çalıştırmada Modül 1'den başlayın.

## Gelişmiş Kurulum

### Docker ile Çalıştırma (Gelecek)

```bash
# Henüz mevcut değil, gelecek sürümlerde eklenecek
docker run -it alibedirhan/apt-rehber
```

### Sanal Makine Test Ortamı

Test için temiz bir Ubuntu VM kurabilirsiniz:

```bash
# VirtualBox veya VMware'de Ubuntu 22.04 kurun
# Snapshot alın
# Script'i test edin
# Hata yaparsan snapshot'a geri dön
```

## Destek

Kurulum sırasında sorun yaşarsanız:

1. [Issues](https://github.com/alibedirhan/Youtube-scripts/issues) sayfasına bakın
2. Sorun yoksa yeni issue açın
3. Sistem bilgilerinizi (OS, bash versiyonu) ekleyin
4. Hata mesajını tam olarak paylaşın

## Kontroller Listesi

Kurulum sonrası kontrol edin:

- [ ] Script çalışıyor
- [ ] Tmux session açılıyor
- [ ] Sağ ve sol paneller görünüyor
- [ ] Fare ile panel değiştirme çalışıyor
- [ ] Modül 1 açılıyor
- [ ] Quiz çalışıyor
- [ ] Çıkış yapabiliyorsunuz

Tüm kontroller tamam ise kurulum başarılı! 

## İleri Adımlar

Kurulum tamamlandıktan sonra:

1. [README.md](README.md) dosyasını okuyun
2. Modül 1'den başlayın
3. Sağ panelde komutları deneyin
4. Quiz ile kendinizi test edin
5. [CONTRIBUTING.md](CONTRIBUTING.md)'yi okuyarak projeye katkıda bulunun

---

Kurulum hakkında sorularınız için [Discussions](https://github.com/alibedirhan/Youtube-scripts/discussions) sayfasını kullanabilirsiniz.
