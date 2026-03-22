#!/bin/bash
# =============================================================
# Script 2  : FOSS Package Inspector
# Author    : Arsh Verma (24BCG10026)
# Course    : Open Source Software — CSE0002
# Software  : Git (chosen for OSS Audit)
# Purpose   : Checks if Git is installed, retrieves package info,
#             and prints open-source philosophy notes for a set
#             of well-known FOSS packages using a case statement.
# Date      : March 2026
# =============================================================

# --- VARIABLES ---
PRIMARY_PACKAGE="git"    # The main package we are auditing

# List of packages for the philosophy notes section
# We check each of these with the case statement
PACKAGES=("git" "apache2" "httpd" "mysql-server" "mysql" "vlc" "firefox" "python3")

# --- DETECT PACKAGE MANAGER ---
# Different Linux families use different package managers
# dpkg/apt = Debian, Ubuntu, Mint
# rpm = RHEL, CentOS, Fedora, openSUSE

if command -v dpkg &>/dev/null; then
    PKG_MANAGER="dpkg"       # Debian/Ubuntu family
elif command -v rpm &>/dev/null; then
    PKG_MANAGER="rpm"        # RHEL/CentOS/Fedora family
else
    PKG_MANAGER="unknown"    # Fallback if neither is found
fi

echo "=============================================="
echo "       FOSS PACKAGE INSPECTOR                "
echo "  Primary Package: $PRIMARY_PACKAGE          "
echo "=============================================="
echo ""
echo "  Package Manager Detected: $PKG_MANAGER"
echo ""

# --- PRIMARY PACKAGE CHECK ---
# Check if git is installed using the detected package manager

echo "--- Checking: $PRIMARY_PACKAGE ---"

if [ "$PKG_MANAGER" = "dpkg" ]; then
    # On Debian/Ubuntu, use dpkg-query to check installation status
    if dpkg -l "$PRIMARY_PACKAGE" 2>/dev/null | grep -q "^ii"; then
        echo "  Status  : INSTALLED"
        # Extract version from dpkg query output
        VERSION=$(dpkg -s "$PRIMARY_PACKAGE" 2>/dev/null | grep '^Version' | cut -d ' ' -f2)
        echo "  Version : $VERSION"
        # Extract the short description
        SUMMARY=$(dpkg -s "$PRIMARY_PACKAGE" 2>/dev/null | grep '^Description' | cut -d ':' -f2 | xargs)
        echo "  Summary : $SUMMARY"
        echo "  License : GPL v2 (GNU General Public License version 2)"
    else
        echo "  Status  : NOT INSTALLED"
        echo "  To install on Ubuntu/Debian:"
        echo "    sudo apt update && sudo apt install git -y"
    fi

elif [ "$PKG_MANAGER" = "rpm" ]; then
    # On RHEL/CentOS/Fedora, use rpm -q to check installation
    if rpm -q "$PRIMARY_PACKAGE" &>/dev/null; then
        echo "  Status  : INSTALLED"
        # rpm -qi gives detailed info; grep for specific fields
        rpm -qi "$PRIMARY_PACKAGE" | grep -E 'Version|License|Summary'
    else
        echo "  Status  : NOT INSTALLED"
        echo "  To install on RHEL/CentOS/Fedora:"
        echo "    sudo yum install git -y   (CentOS/RHEL)"
        echo "    sudo dnf install git -y   (Fedora)"
    fi

else
    # Fallback: try running git --version directly
    if command -v git &>/dev/null; then
        GIT_VERSION=$(git --version)     # Get version string from git itself
        echo "  Status  : INSTALLED (detected via PATH)"
        echo "  Version : $GIT_VERSION"
        echo "  License : GPL v2 (GNU General Public License version 2)"
    else
        echo "  Status  : NOT INSTALLED or package manager not detected."
        echo "  Please install git using your system's package manager."
    fi
fi

echo ""
echo "--- Open Source Philosophy Notes ---"
echo "(A case statement matches package names to philosophy notes)"
echo ""

# --- CASE STATEMENT: One-line philosophy notes ---
# The case statement is the core concept of this script
# Each package gets a one-liner that captures its OSS significance

for PKG in "${PACKAGES[@]}"; do
    # Use case to match the package name and print a philosophy note
    case $PKG in
        git)
            NOTE="Git: born from necessity when Linus Torvalds rejected proprietary control of his own kernel's version history."
            ;;
        apache2 | httpd)
            NOTE="Apache HTTP Server: the web server that helped build the open internet, powering over 30% of all websites."
            ;;
        mysql | mysql-server)
            NOTE="MySQL: open source at the heart of millions of applications, with a dual-license that sparked debate about commercial OSS."
            ;;
        vlc)
            NOTE="VLC: proof that university students can build a media player that beats everything proprietary — and give it away free."
            ;;
        firefox)
            NOTE="Firefox: a nonprofit's fight to keep the web open against browser monocultures, built on the ashes of Netscape."
            ;;
        python3 | python)
            NOTE="Python: a language shaped entirely by its community, governed by a BDFL model that balanced vision with openness."
            ;;
        *)
            # Default case for any package not in our list
            NOTE="$PKG: an open-source tool contributing to the FOSS ecosystem."
            ;;
    esac
    echo "  [$PKG] $NOTE"
done

echo ""
echo "--- Installation Summary ---"
INSTALLED_COUNT=0    # Counter for how many listed packages are installed

for PKG in "${PACKAGES[@]}"; do
    # Check each package in the list using three methods
    if command -v "$PKG" &>/dev/null || \
       ([ "$PKG_MANAGER" = "dpkg" ] && dpkg -l "$PKG" 2>/dev/null | grep -q "^ii") || \
       ([ "$PKG_MANAGER" = "rpm" ] && rpm -q "$PKG" &>/dev/null); then
        INSTALLED_COUNT=$((INSTALLED_COUNT + 1))    # Increment counter using arithmetic expansion
    fi
done

echo "  Packages checked : ${#PACKAGES[@]}"         # Print total packages in array
echo "  Packages found   : $INSTALLED_COUNT"
echo ""
echo "=============================================="
echo "       End of FOSS Package Inspector         "
echo "=============================================="
