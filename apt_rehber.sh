#!/bin/bash

# APT Rehber - Ana Script (tmux tabanlı)
# İnteraktif APT öğrenme sistemi

set -e

# Renkler ve stil
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'
BOLD='\033[1m'

# Script dizini
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/modules"
SESSION_NAME="apt_rehber_$$"

# Quiz değişkenleri
declare -g QUIZ_SCORE=0
declare -g QUIZ_TOTAL=15
declare -g CURRENT_QUESTION=0
declare -g QUIZ_WRONG=0

# Başlık yazdırma
print_header() {
    clear
    echo -e "${BLUE}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════════╗"
    echo "║                     APT PAKET YÖNETİCİSİ                     ║"
    echo "║                    İNTERAKTİF REHBERİ                        ║"
    echo "║                                                              ║"
    echo "║  Sol Panel: Rehber İçerik  │  Sağ Panel: Test Terminali     ║"
    echo "╚══════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Sistem kontrolleri
check_dependencies() {
    local missing_deps=()
    
    # tmux kontrolü
    if ! command -v tmux &> /dev/null; then
        missing_deps+=("tmux")
    fi
    
    # less kontrolü (most yerine daha yaygın)
    if ! command -v less &> /dev/null; then
        missing_deps+=("less")
    fi
    
    # APT kontrolü
    if ! command -v apt &> /dev/null; then
        echo -e "${RED}HATA: Bu script APT paket yöneticisi olan sistemlerde çalışır.${NC}"
        echo "Debian, Ubuntu, Linux Mint gibi dağıtımlarda kullanabilirsiniz."
        exit 1
    fi
    
    # Root kontrolü
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}HATA: Bu scripti root kullanıcısı olarak çalıştırmayın!${NC}"
        echo "Normal kullanıcı olarak çalıştırın, gerektiğinde sudo kullanılacak."
        exit 1
    fi
    
    # Eksik bağımlılıkları otomatik kur
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        echo -e "${YELLOW}Eksik bağımlılıklar tespit edildi: ${missing_deps[*]}${NC}"
        echo "• tmux: Çift panel deneyimi için"
        echo "• less: Modül içeriklerinde sorunsuz navigasyon için"
        echo
        echo -e "${CYAN}Gerekli paketler otomatik olarak kuruluyor...${NC}"
        
        echo -e "${CYAN}Paket listeleri güncelleniyor...${NC}"
        if ! sudo apt update -qq; then
            echo -e "${RED}HATA: Paket listesi güncellenemedi!${NC}"
            exit 1
        fi
        
        echo -e "${CYAN}Bağımlılıklar kuruluyor: ${missing_deps[*]}${NC}"
        if ! sudo apt install -y "${missing_deps[@]}"; then
            echo -e "${RED}HATA: Bağımlılıklar kurulamadı!${NC}"
            exit 1
        fi
        
        echo -e "${GREEN}✅ Tüm bağımlılıklar başarıyla kuruldu!${NC}"
        echo -e "${CYAN}Script yeniden başlatılıyor...${NC}"
        sleep 2
        exec "$0" "$@"
    fi
}

# Modül dosyalarını oluştur
create_modules() {
    mkdir -p "$MODULES_DIR"

    if ls "$MODULES_DIR"/module_*.sh &>/dev/null; then
        return 0
    fi
    
    # Modül 1: Paket Yönetimi Temelleri ve APT Giriş
    cat > "$MODULES_DIR/module_01.sh" << 'MODULE1_EOF'
#!/bin/bash

show_module_01() {
    cat << 'CONTENT_EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                     MODÜL 1: PAKET YÖNETİMİ TEMELLERİ                       ║
║                              VE APT GİRİŞ                                    ║
╚══════════════════════════════════════════════════════════════════════════════╝

🟦 PAKET YÖNETİMİ NEDİR?

Linux dünyasında paket yönetimi, yazılımların kurulması, güncellenmesi ve 
kaldırılması işlemlerini otomatikleştiren sistemdir. Windows'ta bir program 
kurmak için .exe dosyasını çalıştırdığınız gibi, Linux'ta bu işlem paket 
yöneticileri aracılığıyla yapılır.

🟦 PAKET NEDİR?

Paket, bir yazılımın çalışması için gereken tüm dosyaları (program dosyaları, 
konfigürasyon dosyaları, belgeler) ve meta verileri içeren arşiv dosyasıdır. 
Debian tabanlı sistemlerde .deb uzantılı dosyalar kullanılır.

🟦 BAĞIMLILIK (DEPENDENCY) KAVRAMI

Bir program çalışabilmek için başka programlara ihtiyaç duyabilir. Bu duruma 
bağımlılık denir.

📊 Windows ile Karşılaştırma: 
Windows'ta bu durum DLL (Dynamic Link Library) dosyalarıyla benzerlik gösterir. 
Örneğin bir oyun çalışmak için "Visual C++ Redistributable" paketine ihtiyaç 
duyabilir. Linux'ta ise bu kütüphaneler paket sistemi içinde otomatik olarak 
yönetilir.

🔍 NEDEN BAĞIMLILIK VAR?
• Disk alanından tasarruf (ortak kütüphaneler)
• Güvenlik (kütüphane güncellenince tüm uygulamalar faydalanır)
• Modülerlik (her uygulama aynı kodu tekrar yazmaz)

💻 Örnek: VLC'nin bağımlılıklarını görmek
────────────────────────────────────────────────────────────────────────────────
$ apt-cache depends vlc

Çıktı:
vlc
  Depends: vlc-bin
  Depends: vlc-plugin-base
  Depends: vlc-plugin-video-output
  Depends: vlc-plugin-qt
  Depends: libvlc5
  Depends: libvlccore9
  Depends: libc6
  Depends: libxcb1
────────────────────────────────────────────────────────────────────────────────

Bu çıktıda gördüğünüz libc6 dosyası birçok farklı program tarafından ortak 
kullanılan bir kütüphanedir.

💻 Örnek: libc6'ya bağımlı programları görmek
────────────────────────────────────────────────────────────────────────────────
$ apt-cache rdepends libc6 | head -10

Çıktı:
libc6
Reverse Depends:
  firefox
  vlc
  gimp
  libreoffice-common
  python3
  nodejs
────────────────────────────────────────────────────────────────────────────────

🟦 APT (ADVANCED PACKAGE TOOL) NEDİR?

APT, Debian tabanlı Linux dağıtımlarında (Ubuntu, Linux Mint, Kali Linux) 
kullanılan gelişmiş paket yönetim sistemidir. APT'nin en büyük avantajı 
bağımlılık yönetimini otomatik olarak yapmasıdır.

📊 apt vs apt-get FARKI:

┌─────────────────┬─────────────────────────────────────────────────────────────────────┐
│     apt-get     │                         apt                             │
├─────────────────┼─────────────────────────────────────────────────────────────────────┤
│ Eski komut      │ Yeni komut (Ubuntu 16.04+)                             │
│ Daha fazla      │ Kullanıcı dostu                                        │
│ seçenek sunar   │ Günlük kullanım için optimize edilmiş                  │
│ Script'lerde    │ İnteraktif kullanım için                               │
│ tercih edilir   │ Renkli çıktı, ilerleme çubuğu                          │
└─────────────────┴─────────────────────────────────────────────────────────────────────┘

💻 Örnek: Eski vs Yeni Yöntem
────────────────────────────────────────────────────────────────────────────────
# Eski yöntem
$ sudo apt-get update
$ sudo apt-get install vlc

# Yeni yöntem (önerilen)
$ sudo apt update
$ sudo apt install vlc
────────────────────────────────────────────────────────────────────────────────

🟦 APT'NİN ÇALIŞMA MEKANİZMASI

APT üç temel adımda çalışır:

1️⃣ PAKET LİSTELERİNİ GÜNCELLEME

💻 Komut:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt update
────────────────────────────────────────────────────────────────────────────────

🔄 Terminal Çıktısı Örneği:
────────────────────────────────────────────────────────────────────────────────
Hit:1 http://tr.archive.ubuntu.com/ubuntu jammy InRelease
Get:2 http://tr.archive.ubuntu.com/ubuntu jammy-updates InRelease [119 kB]
Get:3 http://tr.archive.ubuntu.com/ubuntu jammy-backports InRelease [108 kB]
Reading package lists... Done
Building dependency tree... Done
────────────────────────────────────────────────────────────────────────────────

Bu komut /etc/apt/sources.list dosyasındaki depolardan en güncel paket 
listelerini indirir.

2️⃣ SİSTEM GÜNCELLEME

💻 Komut:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt upgrade
────────────────────────────────────────────────────────────────────────────────

🔄 Terminal Çıktısı Örneği:
────────────────────────────────────────────────────────────────────────────────
Reading package lists... Done
Building dependency tree... Done
The following packages will be upgraded:
  firefox libreoffice-common ubuntu-desktop
3 upgraded, 0 newly installed, 0 to remove
Need to get 45.2 MB of archives.
Do you want to continue? [Y/n]
────────────────────────────────────────────────────────────────────────────────

3️⃣ İKİSİNİ BİRLEŞTİRME

💻 Komut:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt update && sudo apt upgrade
────────────────────────────────────────────────────────────────────────────────

🔗 && OPERATÖRÜ NEDİR?

&& operatörü bir mantıksal "VE" operatörüdür. İlk komut başarılı olursa 
(hata vermezse) ikinci komutu çalıştırır. Eğer ilk komut başarısız olursa 
ikinci komut hiç çalışmaz. Bu sayede güvenli bir komut zinciri oluştururuz.

📊 Alternatif Operatörler:
• || : İlk komut başarısız olursa ikinci komutu çalıştır
• ;  : İlk komutun sonucuna bakmaksızın ikinci komutu çalıştır

💻 Örnek: Operatör Karşılaştırması
────────────────────────────────────────────────────────────────────────────────
$ echo "başarılı" && echo "bu çalışır"     # İkisi de çalışır
$ false && echo "bu çalışmaz"              # İkinci komut çalışmaz
$ echo "birinci" ; echo "ikinci"           # İkisi de çalışır
$ false || echo "bu çalışır"               # İkinci komut çalışır
────────────────────────────────────────────────────────────────────────────────

🚀 SAĞ PANELDEKİ TERMİNALDE DENEYEBİLECEĞİNİZ KOMUTLAR:

🔒 GÜVENLİ KOMUTLAR (sistem değişikliği yapmaz):
• apt-cache depends vlc
• apt-cache rdepends libc6 | head -10
• apt list --upgradable
• apt search firefox

⚠️ SUDO GEREKTİREN KOMUTLAR (dikkatli kullanın):
• sudo apt update
• apt-cache policy

💡 İPUCU: Önce güvenli komutları deneyin, sonra sudo gerektiren komutlara geçin!

CONTENT_EOF
}
MODULE1_EOF

    # Modül 2: Temel APT Komutları ve Kullanım
    cat > "$MODULES_DIR/module_02.sh" << 'MODULE2_EOF'
#!/bin/bash

show_module_02() {
    cat << 'CONTENT_EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                    MODÜL 2: TEMEL APT KOMUTLARI VE KULLANIM                 ║
╚══════════════════════════════════════════════════════════════════════════════╝

🟦 TEMEL APT KOMUTLARI

1️⃣ PAKET KURMA

💻 Temel kurulum:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt install vlc
────────────────────────────────────────────────────────────────────────────────

💻 Birden fazla paket kurma:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt install firefox gimp libreoffice
────────────────────────────────────────────────────────────────────────────────

🔄 Terminal Çıktısı Örneği:
────────────────────────────────────────────────────────────────────────────────
Reading package lists... Done
Building dependency tree... Done
The following additional packages will be installed:
  vlc-bin vlc-plugin-base vlc-plugin-video-output
The following NEW packages will be installed:
  vlc vlc-bin vlc-plugin-base vlc-plugin-video-output
0 upgraded, 4 newly installed, 0 to remove
Need to get 15.2 MB of archives.
After this operation, 52.1 MB of additional disk space will be used.
Do you want to continue? [Y/n]
────────────────────────────────────────────────────────────────────────────────

2️⃣ PAKET KALDIRMA - REMOVE VS PURGE FARKI

🔍 DETAYLI AÇIKLAMA:

🗑️ REMOVE KOMUTU:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt remove vlc
────────────────────────────────────────────────────────────────────────────────

Remove komutu paketi kaldırır ama:
• Kullanıcı ayarları kalır
• Konfigürasyon dosyaları /etc/ altında kalır  
• Paketi yeniden kurduğunuzda eski ayarlarınız geri gelir
• Hızlı kaldırma işlemi

🗑️ PURGE KOMUTU:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt purge vlc
────────────────────────────────────────────────────────────────────────────────

Purge komutu paketi tamamen kaldırır:
• Tüm konfigürasyon dosyaları silinir
• Sistem ayarları temizlenir
• Paket sanki hiç kurulmamış gibi olur
• Tamamen temiz kaldırma

🚗 ARABA CAMI METAFORU:
remove = kuru bezle silmek (temiz görünür ama izler kalır)
purge = ıslak bezle silmek (tamamen temizler)

🔍 PAKETİN DURUMUNU KONTROL ETME:
────────────────────────────────────────────────────────────────────────────────
$ dpkg -l | grep vlc
────────────────────────────────────────────────────────────────────────────────

📊 Çıktıda göreceğiniz durumlar:
┌────┬─────────────────────────────────────────────────────────────────────────┐
│ ii │ Kurulu ve yapılandırılmış (installed)                                 │
│ rc │ Kaldırılmış ama konfigürasyon dosyaları kalmış (removed, config-files)│
│ un │ Tamamen kaldırılmış (unknown)                                         │
└────┴─────────────────────────────────────────────────────────────────────────┘

💻 Örnek SENARYO:
────────────────────────────────────────────────────────────────────────────────
# 1. Paket kurma
$ sudo apt install htop

# 2. Remove ile kaldırma
$ sudo apt remove htop
$ dpkg -l | grep htop
# Çıktı: rc htop... (konfigürasyon dosyaları kaldı)

# 3. Purge ile temizleme  
$ sudo apt purge htop
$ dpkg -l | grep htop
# Çıktı: Hiçbir şey (tamamen temizlendi)
────────────────────────────────────────────────────────────────────────────────

🤔 HANGİSİNİ KULLANMALI?

┌─────────────────────────────────┬─────────────────────────────────────────┐
│            DURUM                │               KOMUT                     │
├─────────────────────────────────┼─────────────────────────────────────────┤
│ Paketi geçici olarak kaldırma   │ remove                                  │
│ Ayarlarınızı korumak isteme     │ remove                                  │
│ Paketten tamamen kurtulma       │ purge                                   │
│ Sistem temizliği yapma          │ purge                                   │
└─────────────────────────────────┴─────────────────────────────────────────┘

3️⃣ GEREKSİZ BAĞIMLILIKLARI TEMİZLEME

💻 Komut:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt autoremove
────────────────────────────────────────────────────────────────────────────────

🔄 Terminal Çıktısı Örneği:
────────────────────────────────────────────────────────────────────────────────
Reading package lists... Done
Building dependency tree... Done
The following packages will be REMOVED:
  libvlc-bin libvlc5 libvlccore9
0 upgraded, 0 newly installed, 3 to remove
After this operation, 15.2 MB disk space will be freed.
Do you want to continue? [Y/n]
────────────────────────────────────────────────────────────────────────────────

⚠️ DİKKAT: Bu komut bazen gerekli paketleri de kaldırabilir!

🔍 Kaldırılan paketleri görmek için:
────────────────────────────────────────────────────────────────────────────────
$ grep "Remove" /var/log/apt/history.log
────────────────────────────────────────────────────────────────────────────────

🚀 SAĞ PANELDEKİ TERMİNALDE DENEYEBİLECEĞİNİZ KOMUTLAR:

🔒 GÜVENLİ KOMUTLAR:
• apt show firefox
• apt-cache policy firefox  
• dpkg -l | grep firefox
• apt list --upgradable

⚠️ TEST KOMUTLARI (küçük paketlerle deneyin):
• sudo apt install tree
• dpkg -l | grep tree
• sudo apt remove tree
• dpkg -l | grep tree  
• sudo apt purge tree

💡 İPUCU: tree gibi küçük paketlerle remove/purge farkını test edin!

CONTENT_EOF
}
MODULE2_EOF

    # Modül 3: Paket Arama, Listeleme ve Yönetim
    cat > "$MODULES_DIR/module_03.sh" << 'MODULE3_EOF'
#!/bin/bash

show_module_03() {
    cat << 'CONTENT_EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║               MODÜL 3: PAKET ARAMA, LİSTELEME VE YÖNETİM                    ║
╚══════════════════════════════════════════════════════════════════════════════╝

🟦 PAKET ARAMA

1️⃣ TEMEL ARAMA KOMUTU

💻 apt search komutu:
────────────────────────────────────────────────────────────────────────────────
$ apt search video editor
────────────────────────────────────────────────────────────────────────────────

🔍 Bu komutun özellikleri:
• Paket adı ve açıklamalarında arama yapar
• Büyük-küçük harf duyarlı değildir
• Regex destekler
• Birden fazla kelimeyle arama yapabilir

🔄 Terminal Çıktısı Örneği:
────────────────────────────────────────────────────────────────────────────────
openshot-qt/jammy 2.6.1+dfsg1-1 all
  create and edit videos and movies

kdenlive/jammy 21.12.3-0ubuntu1 amd64
  non-linear video editor

flowblade/jammy 2.8.0.3-1 all
  non-linear video editor

pitivi/jammy 2021.05-1 all
  non-linear audio/video editor using GStreamer
────────────────────────────────────────────────────────────────────────────────

2️⃣ YÜKLÜ PAKETLERİ LİSTELEME

💻 Tüm yüklü paketleri listele:
────────────────────────────────────────────────────────────────────────────────
$ apt list --installed
────────────────────────────────────────────────────────────────────────────────

💻 Belirli paketi filtrele:
────────────────────────────────────────────────────────────────────────────────
$ apt list --installed | grep vlc
────────────────────────────────────────────────────────────────────────────────

🚀 SAĞ PANELDEKİ TERMİNALDE DENEYEBİLECEĞİNİZ KOMUTLAR:

🔒 GÜVENLİ KOMUTLAR:
• apt search browser
• apt search text editor  
• apt list --installed | grep python
• apt list --upgradable

CONTENT_EOF
}
MODULE3_EOF

    # Modül 4: Konfigürasyon ve Güvenlik
    cat > "$MODULES_DIR/module_04.sh" << 'MODULE4_EOF'
#!/bin/bash

show_module_04() {
    cat << 'CONTENT_EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                  MODÜL 4: KONFİGÜRASYON VE GÜVENLİK                        ║
╚══════════════════════════════════════════════════════════════════════════════╝

🟦 APT KONFİGÜRASYONU

1️⃣ SOURCES.LIST DOSYASI

🔍 /etc/apt/sources.list dosyası APT'nin hangi depolardan paket indireceğini 
belirler. Bu dosya Linux paket sisteminin kalbidir.

💻 Dosyayı görüntüleme:
────────────────────────────────────────────────────────────────────────────────
$ cat /etc/apt/sources.list
────────────────────────────────────────────────────────────────────────────────

🟦 GÜVENLİK VE EN İYİ PRATİKLER

1️⃣ GÜVENLİK İPUÇLARI

🛡️ En İyi Güvenlik Pratikleri:
• Sadece güvenilir depolardan yükleme yapın
• PPA'ları dikkatli kullanın  
• Sistem güncellemelerini ertelemeyin
• Düzenli yedekleme yapmayı unutmayın

🚀 SAĞ PANELDEKİ TERMİNALDE DENEYEBİLECEĞİNİZ KOMUTLAR:

🔒 GÜVENLİ KOMUTLAR:
• cat /etc/apt/sources.list
• ls /etc/apt/sources.list.d/
• apt-cache policy firefox

CONTENT_EOF
}
MODULE4_EOF

    # Modül 5: Gelişmiş Özellikler ve Pratik Örnekler
    cat > "$MODULES_DIR/module_05.sh" << 'MODULE5_EOF'
#!/bin/bash

show_module_05() {
    cat << 'CONTENT_EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║              MODÜL 5: GELİŞMİŞ ÖZELLİKLER VE PRATİK ÖRNEKLER              ║
╚══════════════════════════════════════════════════════════════════════════════╝

🟦 APT GELİŞMİŞ KOMUTLARI

1️⃣ PAKET SÜRÜM YÖNETİMİ

💻 Mevcut sürümleri listeleme:
────────────────────────────────────────────────────────────────────────────────
$ apt-cache madison firefox
────────────────────────────────────────────────────────────────────────────────

2️⃣ PAKET TUTMA (HOLD)

💻 Paketi güncelleme dışında bırakma:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt-mark hold firefox
────────────────────────────────────────────────────────────────────────────────

🟦 PRATİK ÖRNEKLER

1️⃣ GELİŞTİRİCİ ORTAMI KURMA

💻 Geliştirici araçları kurma:
────────────────────────────────────────────────────────────────────────────────
$ sudo apt install curl wget git vim build-essential
────────────────────────────────────────────────────────────────────────────────

🎉 TEBRİKLER! APT REHBERİNİ TAMAMLADINIZ!

Artık APT paket yöneticisini profesyonel seviyede kullanabilirsiniz. 
Bu bilgilerle sistem yönetimi, yazılım kurulumu ve sorun giderme 
konularında kendinize güvenebilirsiniz.

🚀 SAĞ PANELDEKİ TERMİNALDE DENEYEBİLECEĞİNİZ KOMUTLAR:

🔒 GÜVENLİ KOMUTLAR:
• apt-cache stats
• dpkg -l | grep ^ii | wc -l
• sudo apt install neofetch
• neofetch

CONTENT_EOF
}
MODULE5_EOF

    # Quiz Modülü
    cat > "$MODULES_DIR/module_quiz.sh" << 'QUIZ_EOF'
#!/bin/bash

show_module_quiz() {
    cat << 'CONTENT_EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                         APT PAKETLERİ BİLGİ YARIŞMASI                       ║
║                           İNTERAKTİF TEST MODU                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

🎯 TEST HAKKINDA:
• 15 soru bulunmaktadır
• Çoktan seçmeli ve doğru/yanlış soruları var
• Her doğru cevap 1 puan değerindedir
• Test sonunda başarı durumunuz gösterilecektir

📚 KONU DAĞILIMI:
• Temel APT komutları (5 soru)
• Paket yönetimi kavramları (5 soru)
• İleri seviye konular (3 soru)
• Sorun giderme (2 soru)

🏆 BAŞARI KRİTERLERİ:
• 13-15 puan: Uzman seviye! 🌟
• 10-12 puan: İleri seviye 🚀
• 7-9 puan: Orta seviye 📈
• 4-6 puan: Temel seviye 📖
• 0-3 puan: Daha çok çalışma gerekli 📚

Teste başlamak için herhangi bir tuşa basın...
CONTENT_EOF
    
    read -r
    start_quiz
}

start_quiz() {
    QUIZ_SCORE=0
    QUIZ_TOTAL=15
    CURRENT_QUESTION=0
    QUIZ_WRONG=0
    
    clear
    echo "🎯 APT PAKETLERİ BİLGİ YARIŞMASI BAŞLIYOR!"
    echo "═══════════════════════════════════════════"
    echo
    
    quiz_questions
    show_quiz_results
}

quiz_questions() {
    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: APT paket listelerini güncellemek için hangi komut kullanılır?" \
        "a) sudo apt upgrade" \
        "b) sudo apt update" \
        "c) sudo apt install" \
        "d) sudo apt refresh" \
        "b"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: Bir paketi tamamen (konfigürasyon dosyalarıyla birlikte) kaldırmanın komutu nedir?" \
        "a) sudo apt remove" \
        "b) sudo apt delete" \
        "c) sudo apt purge" \
        "d) sudo apt uninstall" \
        "c"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: '&&' operatörü komutlar arasında ne işe yarar?" \
        "a) Her zaman ikinci komutu çalıştırır" \
        "b) İlk komut başarılıysa ikinci komutu çalıştırır" \
        "c) İlk komut başarısızsa ikinci komutu çalıştırır" \
        "d) İki komutu aynı anda çalıştırır" \
        "b"

    ((CURRENT_QUESTION++))
    ask_true_false \
        "Soru $CURRENT_QUESTION: APT sadece Ubuntu'da kullanılır." \
        "false"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: Bağımlılık sorunlarını otomatik çözmek için hangi komut kullanılır?" \
        "a) sudo apt fix" \
        "b) sudo apt repair" \
        "c) sudo apt --fix-broken install" \
        "d) sudo apt resolve" \
        "c"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: APT önbelleğini tamamen temizleyen komut hangisidir?" \
        "a) sudo apt clean" \
        "b) sudo apt autoclean" \
        "c) sudo apt clear" \
        "d) sudo apt flush" \
        "a"

    ((CURRENT_QUESTION++))
    ask_true_false \
        "Soru $CURRENT_QUESTION: 'apt' komutu 'apt-get'in modern versiyonudur." \
        "true"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: Yüklü paketleri listelemek için hangi komut kullanılır?" \
        "a) apt show --installed" \
        "b) apt list --installed" \
        "c) apt get --installed" \
        "d) apt display --installed" \
        "b"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: Hangi dosya APT depolarını tanımlar?" \
        "a) /etc/apt/repositories.list" \
        "b) /etc/apt/sources.conf" \
        "c) /etc/apt/sources.list" \
        "d) /etc/apt/repos.list" \
        "c"

    ((CURRENT_QUESTION++))
    ask_true_false \
        "Soru $CURRENT_QUESTION: 'autoremove' komutu gereksiz bağımlılıkları kaldırır." \
        "true"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: Bir paketin güncellenememesi için hangi komut kullanılır?" \
        "a) sudo apt-mark hold <paket>" \
        "b) sudo apt freeze <paket>" \
        "c) sudo apt lock <paket>" \
        "d) sudo apt pin <paket>" \
        "a"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: Hangi komut bir paketin bağımlılıklarını gösterir?" \
        "a) apt-cache shows" \
        "b) apt-cache depends" \
        "c) apt-cache needs" \
        "d) apt-cache requires" \
        "b"

    ((CURRENT_QUESTION++))
    ask_true_false \
        "Soru $CURRENT_QUESTION: PPA (Personal Package Archive) sadece resmi Ubuntu paketleridir." \
        "false"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: APT kilit hatası alındığında hangi dizindeki dosyalar kontrol edilir?" \
        "a) /var/cache/apt/" \
        "b) /var/lib/apt/" \
        "c) /var/lib/dpkg/" \
        "d) /etc/apt/" \
        "c"

    ((CURRENT_QUESTION++))
    ask_question \
        "Soru $CURRENT_QUESTION: Hangi komut sistemdeki tüm paket istatistiklerini gösterir?" \
        "a) apt-cache info" \
        "b) apt-cache stats" \
        "c) apt-cache summary" \
        "d) apt-cache count" \
        "b"
}

ask_question() {
    local question="$1"
    local option_a="$2"
    local option_b="$3"
    local option_c="$4"
    local option_d="$5"
    local correct="$6"
    
    clear
    show_progress_bar
    
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "$question"
    echo
    echo "$option_a"
    echo "$option_b"
    echo "$option_c"
    echo "$option_d"
    echo
    echo -n "Cevabınız (a/b/c/d): "
    
    read -r answer
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
    
    echo
    if [[ "$answer" == "$correct" ]]; then
        echo "✅ DOĞRU! Tebrikler!"
        ((QUIZ_SCORE++))
    else
        echo "❌ YANLIŞ! Doğru cevap: $correct"
        ((QUIZ_WRONG++))
        show_explanation "$CURRENT_QUESTION" "$correct"
    fi
    
    show_current_score
    
    echo
    echo "Devam etmek için Enter'a basın..."
    read -r
}

ask_true_false() {
    local question="$1"
    local correct="$2"
    
    clear
    show_progress_bar
    
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "$question"
    echo
    echo "a) Doğru"
    echo "b) Yanlış"
    echo
    echo -n "Cevabınız (a=doğru, b=yanlış): "
    
    read -r answer
    answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
    
    local user_answer=""
    if [[ "$answer" == "a" ]]; then
        user_answer="true"
    else
        user_answer="false"
    fi
    
    echo
    if [[ "$user_answer" == "$correct" ]]; then
        echo "✅ DOĞRU! Tebrikler!"
        ((QUIZ_SCORE++))
    else
        echo "❌ YANLIŞ! Doğru cevap: $correct"
        ((QUIZ_WRONG++))
        show_explanation "$CURRENT_QUESTION" "$correct"
    fi
    
    show_current_score
    
    echo
    echo "Devam etmek için Enter'a basın..."
    read -r
}

show_progress_bar() {
    if [[ "$QUIZ_TOTAL" -eq 0 ]]; then
        QUIZ_TOTAL=15
    fi
    
    local percentage=$((CURRENT_QUESTION * 100 / QUIZ_TOTAL))
    local filled=$((CURRENT_QUESTION * 50 / QUIZ_TOTAL))
    local empty=$((50 - filled))
    
    if [[ $empty -lt 0 ]]; then
        empty=0
    fi
    
    echo "╔════════════════════════════════════════════════════════════════════════════════╗"
    echo "║                            APT BİLGİ YARIŞMASI                                ║"
    echo "╠════════════════════════════════════════════════════════════════════════════════╣"
    printf "║ Soru: %d/%d                        İlerleme: %%%d              ║\n" "$CURRENT_QUESTION" "$QUIZ_TOTAL" "$percentage"
    printf "║ ["
    
    for ((i=0; i<filled; i++)); do
        printf "#"
    done
    for ((i=0; i<empty; i++)); do
        printf "-"
    done
    
    printf "]           ║\n"
    
    if (( CURRENT_QUESTION > 1 && CURRENT_QUESTION <= QUIZ_TOTAL )); then
        local prev_question=$((CURRENT_QUESTION - 1))
        local success_rate=0
        if [[ "$prev_question" -gt 0 ]]; then
            success_rate=$((QUIZ_SCORE * 100 / prev_question))
        fi
        echo "║                                                                                ║"
        echo "║ 📊 Şu ana kadarki performans:                                                  ║"
        printf "║    ✅ Doğru: %-6d ❌ Yanlış: %-6d                                   ║\n" "$QUIZ_SCORE" "$QUIZ_WRONG"
        printf "║    📈 Başarı oranı: %%%d                                                       ║\n" "$success_rate"
    elif (( CURRENT_QUESTION == QUIZ_TOTAL )); then
        echo "║                                                                                ║"
        echo "║ 🏁 SON SORU! Teste neredeyse tamamladınız...                                   ║"
    fi
    echo "╚════════════════════════════════════════════════════════════════════════════════╝"
}

show_current_score() {
    local success_rate=0
    if [[ "$CURRENT_QUESTION" -gt 0 ]]; then
        success_rate=$((QUIZ_SCORE * 100 / CURRENT_QUESTION))
    fi
    
    echo
    echo "┌─────────────────────────────────────┐"
    echo "│           GÜNCEL DURUM              │"
    echo "├─────────────────────────────────────┤"
    printf "│ ✅ Doğru cevaplar: %-6d         │\n" "$QUIZ_SCORE"
    printf "│ ❌ Yanlış cevaplar: %-6d        │\n" "$QUIZ_WRONG"
    printf "│ 📝 Toplam yanıtlanan: %-6d      │\n" "$CURRENT_QUESTION"
    printf "│ 📊 Başarı oranı: %%%d              │\n" "$success_rate"
    echo "└─────────────────────────────────────┘"
}

show_explanation() {
    local question_num="$1"
    local correct_answer="$2"
    
    case $question_num in
        4)
            echo "💡 Açıklama: APT, Debian tabanlı tüm dağıtımlarda kullanılır (Ubuntu, Debian, Mint, Kali vs.)"
            ;;
        7)
            echo "💡 Açıklama: 'apt' komutu, apt-get ve apt-cache'in kullanıcı dostu birleştirilmiş halidir."
            ;;
        10)
            echo "💡 Açıklama: autoremove komutu artık gerekmeyen bağımlılık paketlerini kaldırır."
            ;;
        13)
            echo "💡 Açıklama: PPA'lar topluluk tarafından oluşturulan üçüncü parti paket depoları."
            ;;
        *)
            echo "💡 Doğru cevap: $correct_answer"
            ;;
    esac
}

show_quiz_results() {
    clear
    echo "🎉 TEST TAMAMLANDI!"
    echo "═══════════════════════════════════════════"
    echo
    echo "📊 SONUÇLARINIZ:"
    echo "Doğru cevap sayısı: $QUIZ_SCORE"
    echo "Toplam soru sayısı: $QUIZ_TOTAL"
    
    local final_percentage=0
    if [[ "$QUIZ_TOTAL" -gt 0 ]]; then
        final_percentage=$((QUIZ_SCORE * 100 / QUIZ_TOTAL))
    fi
    echo "Başarı oranı: $final_percentage%"
    echo
    
    if (( QUIZ_SCORE >= 13 )); then
        echo "🌟 UZMAN SEVİYE! Tebrikler!"
        echo "APT paket yönetiminde uzman seviyesindesiniz."
        cat << 'EXPERT_BADGE'
        
    ⭐⭐⭐ APT UZMANI ⭐⭐⭐
   ╭─────────────────────────╮
   │  Mükemmel performans!   │
   │   Sizi tebrik ederiz!   │
   ╰─────────────────────────╯
        
EXPERT_BADGE
    elif (( QUIZ_SCORE >= 10 )); then
        echo "🚀 İLERİ SEVİYE! Çok iyi!"
        echo "APT konusunda ileri seviye bilgiye sahipsiniz."
    elif (( QUIZ_SCORE >= 7 )); then
        echo "📈 ORTA SEVİYE! İyi iş!"
        echo "İyi bir temel bilginiz var, biraz daha pratik yapabilirsiniz."
    elif (( QUIZ_SCORE >= 4 )); then
        echo "📖 TEMEL SEVİYE"
        echo "Temel bilgileriniz var, modülleri tekrar gözden geçirin."
    else
        echo "📚 DAHA FAZLA ÇALIŞMA GEREKİYOR"
        echo "Modülleri baştan çalışmanızı öneririz."
    fi
    
    echo
    echo "📚 ÖNERLER:"
    if (( QUIZ_SCORE < 7 )); then
        echo "• Modül 1 ve 2'yi tekrar inceleyin"
        echo "• Temel komutları pratikte deneyin"
    elif (( QUIZ_SCORE < 10 )); then
        echo "• Modül 4 ve 5'i detaylı inceleyin"
        echo "• İleri seviye özellikler üzerine çalışın"
    else
        echo "• Diğer paket yöneticilerini (dnf, pacman) öğrenebilirsiniz"
        echo "• Sistem yöneticiliği konularında ilerleyebilirsiniz"
    fi
    
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "Seçenekler:"
    echo "1. Testi tekrarla"
    echo "2. Ana menüye dön"
    echo -n "Seçiminiz (1/2): "
    
    read -r choice
    case $choice in
        1) start_quiz ;;
        2) return ;;
        *) echo "Ana menüye dönülüyor..."; sleep 1; return ;;
    esac
}
QUIZ_EOF

    chmod +x "$MODULES_DIR"/*.sh
}

# tmux session başlat
start_tmux_session() {
    tmux kill-session -t "$SESSION_NAME" 2>/dev/null || true
    
    cat > "$SCRIPT_DIR/welcome.sh" << 'WELCOME_EOF'
#!/bin/bash
clear
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}╔════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║${NC}           ${GREEN}TEST TERMİNALİ${NC}            ${CYAN}║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════╝${NC}"
echo
echo -e "${YELLOW}💡 Komutları burada test edin:${NC}"
echo
echo "📌 Güvenli başlangıç komutları:"
echo "   apt search firefox"
echo "   apt list --installed | head"
echo "   apt-cache policy firefox"
echo
echo "⚠️  Dikkatli kullanın:"
echo "   sudo apt update"
echo "   sudo apt install <paket>"
echo
echo -e "${GREEN}Hazırsınız! Komutlarınızı yazabilirsiniz.${NC}"
echo
WELCOME_EOF
    chmod +x "$SCRIPT_DIR/welcome.sh"
    
    tmux new-session -d -s "$SESSION_NAME"
    tmux set -g mouse on
    tmux rename-window -t "$SESSION_NAME" "APT-Rehber"
    tmux split-window -h -t "$SESSION_NAME"
    tmux resize-pane -t "$SESSION_NAME:0.0" -x 65%
    
    tmux send-keys -t "$SESSION_NAME:0.1" "cd '$SCRIPT_DIR' && ./welcome.sh" C-m
    tmux send-keys -t "$SESSION_NAME:0.0" "cd '$SCRIPT_DIR' && ./$(basename "$0") --menu-only" C-m
    
    tmux attach-session -t "$SESSION_NAME"
}

# Ana menü tmux içinde göster
show_main_menu() {
    clear
    cat << 'MENU_EOF'
╔══════════════════════════════════════════════════════════════════════════════╗
║                          APT PAKET YÖNETİCİSİ                               ║
║                         İNTERAKTİF REHBERİ                                  ║
╚══════════════════════════════════════════════════════════════════════════════╝

MODÜLLER:
1. Paket Yönetimi Temelleri
2. Temel APT Komutları
3. Paket Arama ve Listeleme
4. Konfigürasyon ve Güvenlik
5. Gelişmiş Özellikler
6. 🎯 BİLGİ YARIŞMASI (Quiz)
0. Çıkış

KONTROLLER:
• Fare ile paneller arası geçiş (tıklayın)
• Fare ile boyut ayarlama: Panel arası çizgiyi sürükleyin
• Modül içinde: q = Ana menüye dön
• Tamamen çıkış: x veya Ctrl+B → d

MENU_EOF

    echo -n "Modül seçin (1-6, 0=çıkış, x=tamamen kapat): "
}

# Ana menü döngüsü
show_main_menu_loop() {
    while true; do
        show_main_menu
        read -r choice
        
        case $choice in
            1|2|3|4|5) 
                show_module "$choice" || echo "Modül gösterilirken hata oluştu!"
                ;;
            6) 
                show_quiz_module || echo "Quiz modülü yüklenirken hata oluştu!"
                ;;
            0) echo "Çıkılıyor..."; exit 0 ;;
            x|X) 
                echo "tmux session sonlandırılıyor..."
                tmux kill-session -t "$SESSION_NAME"
                exit 0
                ;;
            *) echo "Geçersiz seçim! Enter'a basın..."; read -r ;;
        esac
    done
}

# Quiz modülünü göster (DÜZELTME: module_quiz.sh'yi source et)
show_quiz_module() {
    clear
    echo "🎯 Quiz modülü başlatılıyor..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
    
    if [[ ! -f "$MODULES_DIR/module_quiz.sh" ]]; then
        echo "❌ Quiz modülü bulunamadı!"
        sleep 2
        return 1
    fi
    
    # Module'ü source et ve fonksiyonları kullan
    source "$MODULES_DIR/module_quiz.sh" || {
        echo "❌ Quiz modülü yüklenemedi!"
        sleep 2
        return 1
    }
    
    # module_quiz.sh içindeki show_module_quiz fonksiyonunu çağır
    show_module_quiz
    
    echo
    echo "📚 Ana menüye dönülüyor..."
    sleep 1
    return 0
}

# Modül gösterici (DÜZELTME: eval kullanımı kaldırıldı)
show_module() {
    local module_num=$1
    local module_file="$MODULES_DIR/module_0${module_num}.sh"
    
    if [[ ! -f "$module_file" ]]; then
        echo -e "${RED}HATA: Modül $module_num bulunamadı!${NC}"
        sleep 2
        return 1
    fi
    
    local temp_file
    temp_file=$(mktemp) || {
        echo "Geçici dosya oluşturulamadı!"
        return 1
    }
    
    # Cleanup trap
    trap 'rm -f "$temp_file"' RETURN
    
    # Modülü source et
    source "$module_file" || {
        echo "Modül yüklenemedi!"
        return 1
    }
    
    {
        echo "=== MODÜL $module_num ==="
        echo "Navigasyon: ↑↓ ok tuşları, Space=sayfa aşağı, q=çıkış"
        echo "=================================="
        echo
        # Fonksiyon adını dinamik oluştur ve çağır
        "show_module_0${module_num}"
        echo
        echo "=================================="
        echo "q tuşuna basarak ana menüye dönün"
    } > "$temp_file"
    
    if command -v less &> /dev/null; then
        TERM="${TERM:-xterm}" LESS="-R -S -M -i -x4" less "$temp_file"
    else
        more "$temp_file"
    fi
    
    echo "Modül $module_num tamamlandı!"
    return 0
}

# Ana program
main() {
    if [[ "$1" == "--menu-only" ]]; then
        show_main_menu_loop
        return
    fi
    
    print_header
    echo -e "${CYAN}Sistem kontrolleri yapılıyor...${NC}"
    
    check_dependencies
    
    echo -e "${CYAN}Modül dosyaları oluşturuluyor...${NC}"
    create_modules
    
    echo -e "${GREEN}✅ Hazırlık tamamlandı!${NC}"
    echo
    echo -e "${YELLOW}tmux session başlatılıyor...${NC}"
    echo -e "${BLUE}Kontroller:${NC}"
    echo "• Ctrl+B → Sol/Sağ ok: Paneller arası geçiş"
    echo "• Ctrl+B → d: Session'dan çık (arka planda çalışır)"  
    echo "• tmux attach -t $SESSION_NAME: Geri dön"
    echo
    sleep 3
    
    start_tmux_session
}

main "$@"