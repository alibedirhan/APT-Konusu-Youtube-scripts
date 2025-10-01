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
