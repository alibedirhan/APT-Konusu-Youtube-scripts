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
