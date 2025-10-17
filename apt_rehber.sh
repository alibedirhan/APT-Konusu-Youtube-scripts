#!/bin/bash

# APT Rehber - Ana Script (tmux tabanlı)
# İnteraktif APT öğrenme sistemi
# Version: 2.0 - Modular Architecture

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

# Script dizini ve modül yolları
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/modules"
WELCOME_FILE="$SCRIPT_DIR/welcome.sh"
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
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                     APT PAKET YÖNETİCİSİ                     ║"
    echo "║                    İNTERAKTİF REHBERİ                        ║"
    echo "║                                                              ║"
    echo "║  Sol Panel: Rehber İçerik  │  Sağ Panel: Test Terminali     ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Sistem kontrolleri
check_dependencies() {
    local missing_deps=()
    
    # tmux kontrolü
    if ! command -v tmux &> /dev/null; then
        missing_deps+=("tmux")
    fi
    
    # less kontrolü
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

# Modül dosyalarını kontrol et
check_modules() {
    # Sadece ana çalıştırmada kontrol et (--menu-only modunda değil)
    if [[ "$1" == "--quiet" ]]; then
        return 0
    fi
    
    echo -e "${CYAN}Modül dosyaları kontrol ediliyor...${NC}"
    
    # modules/ klasörü var mı?
    if [[ ! -d "$MODULES_DIR" ]]; then
        echo -e "${RED}HATA: modules/ klasörü bulunamadı!${NC}"
        echo
        echo "Klasör beklenen yer: $MODULES_DIR"
        echo
        echo "Lütfen repository'yi tamamen klonlayın:"
        echo "  ${CYAN}git clone https://github.com/alibedirhan/Youtube-scripts${NC}"
        echo "  ${CYAN}cd Youtube-scripts/APT\\ YOUTUBE/${NC}"
        echo "  ${CYAN}./apt_rehber.sh${NC}"
        exit 1
    fi
    
    # Gerekli modül dosyalarını kontrol et
    local required_modules=(
        "module_01.sh"
        "module_02.sh"
        "module_03.sh"
        "module_04.sh"
        "module_05.sh"
        "module_quiz.sh"
    )
    
    local missing_modules=()
    
    for module in "${required_modules[@]}"; do
        if [[ ! -f "$MODULES_DIR/$module" ]]; then
            missing_modules+=("$module")
        elif [[ ! -r "$MODULES_DIR/$module" ]]; then
            echo -e "${RED}HATA: $module okunamıyor (izin problemi)${NC}"
            exit 1
        elif [[ ! -x "$MODULES_DIR/$module" ]]; then
            # Çalıştırılabilir değilse, çalıştırılabilir yap
            chmod +x "$MODULES_DIR/$module" 2>/dev/null || {
                echo -e "${YELLOW}UYARI: $module çalıştırılabilir yapılamadı${NC}"
            }
        fi
    done
    
    # Eksik modül var mı?
    if [[ ${#missing_modules[@]} -gt 0 ]]; then
        echo -e "${RED}HATA: Aşağıdaki modül dosyaları bulunamadı:${NC}"
        for module in "${missing_modules[@]}"; do
            echo "  ✗ $MODULES_DIR/$module"
        done
        echo
        echo "Lütfen tüm modül dosyalarının mevcut olduğundan emin olun."
        exit 1
    fi
    
    # welcome.sh kontrolü
    if [[ ! -f "$WELCOME_FILE" ]]; then
        echo -e "${RED}HATA: welcome.sh bulunamadı!${NC}"
        echo "Beklenen yer: $WELCOME_FILE"
        exit 1
    fi
    
    if [[ ! -x "$WELCOME_FILE" ]]; then
        chmod +x "$WELCOME_FILE" 2>/dev/null || {
            echo -e "${YELLOW}UYARI: welcome.sh çalıştırılabilir yapılamadı${NC}"
        }
    fi
    
    echo -e "${GREEN}✅ Tüm modül dosyaları hazır!${NC}"
}

# tmux session başlat
start_tmux_session() {
    tmux kill-session -t "$SESSION_NAME" 2>/dev/null || true
    
    # İlk pane ile session oluştur - direkt komutu çalıştır
    tmux new-session -d -s "$SESSION_NAME" -n "APT-Rehber" \
        "cd '$SCRIPT_DIR' && ./$(basename "$0") --menu-only"
    
    tmux set -g mouse on

    # Sağ paneli aç - kullanıcının varsayılan shell'ini kullan
    tmux split-window -h -t "$SESSION_NAME:APT-Rehber" \
        "cd '$SCRIPT_DIR' && ./welcome.sh; exec \$SHELL"

    # Yerleşim: geniş sol panel
    tmux select-layout -t "$SESSION_NAME:APT-Rehber" main-vertical

    # Session'a bağlan (sol panel varsayılan olarak seçili)
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

ÇIKIŞ SEÇENEKLERİ:
0. Menüden Çık (terminal aktif kalır)
x. Tümünü Kapat (session sonlandır)

TMUX KONTROLLERI:
• Fare ile paneller arası geçiş (tıklayın)
• Fare ile boyut ayarlama: Panel arası çizgiyi sürükleyin
• Modül içinde: q = Ana menüye dön
• Ctrl+B → d: Arka plana al (tmux attach ile dön)

MENU_EOF

    echo -n "Modül seçin (1-6, 0=çıkış, x=tümünü kapat): "
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
            0) 
                echo "Menüden çıkılıyor..."
                echo "Sağ paneldeki terminal kullanılabilir durumda."
                echo "Tamamen kapatmak için 'exit' yazın veya pencereyi kapatın."
                exit 0 
                ;;
            x|X) 
                echo "Tüm paneller kapatılıyor..."
                # Diğer tüm pane'leri öldür (sağ panel)
                tmux kill-pane -a 2>/dev/null || true
                sleep 0.2
                # Şu anki pane'den çık (son pane kapanınca session otomatik kapanır)
                exit 0
                ;;
            *) echo "Geçersiz seçim! Enter'a basın..."; read -r ;;
        esac
    done
}

# Quiz modülünü göster
show_quiz_module() {
    clear
    echo "🎯 Quiz modülü başlatılıyor..."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo
    
    local quiz_file="$MODULES_DIR/module_quiz.sh"
    
    if [[ ! -f "$quiz_file" ]]; then
        echo "❌ Quiz modülü bulunamadı!"
        echo "Aranan dosya: $quiz_file"
        sleep 2
        return 1
    fi
    
    # Module'ü source et ve fonksiyonları kullan
    source "$quiz_file" || {
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

# Modül gösterici
show_module() {
    local module_num=$1
    local module_file="$MODULES_DIR/module_0${module_num}.sh"
    
    if [[ ! -f "$module_file" ]]; then
        echo -e "${RED}HATA: Modül $module_num bulunamadı!${NC}"
        echo "Aranan dosya: $module_file"
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
        echo "Modül yüklenemedi: $module_file"
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
    # Eğer --menu-only parametresi varsa sadece menüyü göster
    if [[ "$1" == "--menu-only" ]]; then
        # Sessiz modda check_modules çağır (çıktı yok)
        check_modules --quiet
        show_main_menu_loop
        return
    fi
    
    print_header
    echo -e "${CYAN}Sistem kontrolleri yapılıyor...${NC}"
    
    check_dependencies
    
    check_modules
    
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

# Scripti çalıştır
main "$@"