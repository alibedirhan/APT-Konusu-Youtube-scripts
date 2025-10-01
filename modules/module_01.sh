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
