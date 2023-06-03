#!/bin/bash
echo " 
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⡀⠒⠒⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣤⣶⡾⠿⠿⠿⠿⣿⣿⣶⣦⣄⠙⠷⣤⡀⠀⠀⠀⠀
⠀⠀⠀⣠⡾⠛⠉⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⣿⣷⣄⠘⢿⡄⠀⠀⠀
⠀⢀⡾⠋⠀⠀⠀⠀⠀⠀⠀⠀⠐⠂⠠⢄⡀⠈⢿⣿⣧⠈⢿⡄⠀⠀
⢀⠏⠀⠀⠀⢀⠄⣀⣴⣾⠿⠛⠛⠛⠷⣦⡙⢦⠀⢻⣿⡆⠘⡇⠀⠀
⠀⠀⠀⠀⡐⢁⣴⡿⠋⢀⠠⣠⠤⠒⠲⡜⣧⢸⠄⢸⣿⡇⠀⡇⠀⠀
⠀⠀⠀⡼⠀⣾⡿⠁⣠⢃⡞⢁⢔⣆⠔⣰⠏⡼⠀⣸⣿⠃⢸⠃⠀⠀    https://github.com/Alp19
⠀⠀⢰⡇⢸⣿⡇⠀⡇⢸⡇⣇⣀⣠⠔⠫⠊⠀⣰⣿⠏⡠⠃⠀⠀⢀
⠀⠀⢸⡇⠸⣿⣷⠀⢳⡈⢿⣦⣀⣀⣀⣠⣴⣾⠟⠁⠀⠀⠀⠀⢀⡎
⠀⠀⠘⣷⠀⢻⣿⣧⠀⠙⠢⠌⢉⣛⠛⠋⠉⠀⠀⠀⠀⠀⠀⣠⠎⠀
⠀⠀⠀⠹⣧⡀⠻⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⡾⠃⠀⠀
⠀⠀⠀⠀⠈⠻⣤⡈⠻⢿⣿⣷⣦⣤⣤⣤⣤⣤⣴⡾⠛⠉⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠈⠙⠶⢤⣈⣉⠛⠛⠛⠛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"
echo "                 ALP SİSTEM GÜNCELLEYİCİ  "
echo "--------------------------------------------------------------"

os_type=$(uname -s)

# Check for updates on macOS, Linux, and BSD
if [[ "$os_type" == "Darwin" ]]; then
    echo "MacOS işletim sistemi tespit edildi."
    echo "Sistem güncellemeleri kontrol ediliyor..."

    softwareupdate -l | grep -q "No new software available."
    if [[ $? -eq 0 ]]; then
        echo "Güncelleme bulunamadı."
    else
        echo "Güncellemeler bulundu."
        read -p "Güncellemeyi başlatmak istiyor musunuz? (E/H): " answer
        if [[ "$answer" == "E" || "$answer" == "e" ]]; then
            sudo softwareupdate -i -a
            echo "Sistem güncellemesi tamamlandı."
        else
            echo "Sistem güncelleme işlemi iptal edildi."
        fi
    fi

elif [[ "$os_type" == "Linux" ]]; then
    echo "Linux işletim sistemi tespit edildi."
    echo "Sistem güncellemeleri kontrol ediliyor..."

    # Detect package manager
    if command -v apt-get &>/dev/null; then
        # For Debian-based distributions
        updates=$(apt-get -s upgrade | grep -c ^Inst)
    elif command -v dnf &>/dev/null; then
        # For Fedora-based distributions
        updates=$(dnf list updates | grep -c "^")
    elif command -v yum &>/dev/null; then
        # For CentOS/RHEL-based distributions
        updates=$(yum check-update -q | grep -c "^")
    elif command -v zypper &>/dev/null; then
        # For openSUSE-based distributions
        updates=$(zypper list-patches | grep -c "^")
    elif command -v apk &>/dev/null; then
        # For Alpine-based distributions
        updates=$(apk upgrade --dry-run | grep -c "^")
    else
        echo "Desteklenmeyen paket yöneticisi tespit edildi."
        exit 1
    fi

    if [[ $updates -eq 0 ]]; then
        echo "Güncelleme bulunamadı."
    else
        echo "Güncellemeler bulundu."
        read -p "Güncellemeyi başlatmak istiyor musunuz? (E/H): " answer
        if [[ "$answer" == "E" || "$answer" == "e" ]]; then
            if command -v apt-get &>/dev/null; then
                sudo apt-get update
                sudo apt-get upgrade -y
            elif command -v dnf &>/dev/null; then
                sudo dnf upgrade -y
            elif command -v yum &>/dev/null; then
                sudo yum upgrade -y
            elif command -v zypper &>/dev/null; then
                sudo zypper refresh
                sudo zypper update -y
            elif command -v apk &>/dev/null; then
                sudo apk update
                sudo apk upgrade
            fi
            echo "Sistem güncellemesi tamamlandı."
        else
            echo "Sistem güncelleme işlemi iptal edildi."
        fi
    fi

elif [[ "$os_type" == "FreeBSD" || "$os_type" == "OpenBSD" || "$os_type" == "NetBSD" ]]; then
    echo "BSD işletim sistemi tespit edildi."
    echo "Sistem güncellemeleri kontrol ediliyor..."

    freebsd-update fetch install > /dev/null 2>&1
    if [[ $? -eq 0 ]]; then
        echo "Güncellemeler bulundu."
        read -p "Güncellemeyi başlatmak istiyor musunuz? (E/H): " answer
        if [[ "$answer" == "E" || "$answer" == "e" ]]; then
            sudo freebsd-update install
            echo "Sistem güncellemesi tamamlandı."
        else
            echo "Sistem güncelleme işlemi iptal edildi."
        fi
    else
        echo "Güncelleme bulunamadı."
    fi

else
    echo "Desteklenmeyen işletim sistemi tespit edildi."
    exit 1
fi

echo "--------------------------------------------------------------"
echo "ALP Sistem Güncelleyiciyi kullandığınız için Teşekkürler !"
echo ""

