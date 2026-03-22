#!/bin/bash
# =============================================================
# Script 3  : Disk and Permission Auditor
# Author    : Arsh Verma (24BCG10026)
# Course    : Open Source Software — CSE0002
# Software  : Git (chosen for OSS Audit)
# Purpose   : Audits key system directories for permissions,
#             ownership, and disk usage using a for loop.
#             Also checks Git-specific configuration files.
# Date      : March 2026
# =============================================================

# --- VARIABLES ---
# Array of directories to audit
# Arrays in bash are declared with parentheses and space-separated values
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/share/git-core")

# Column widths for aligned output using printf
COL1=25    # Width for directory path column
COL2=15    # Width for permissions column
COL3=12    # Width for owner column
COL4=12    # Width for group column
COL5=8     # Width for size column

echo "=============================================="
echo "       DISK AND PERMISSION AUDITOR           "
echo "=============================================="
echo ""

# Print table header using printf for alignment
printf "%-${COL1}s %-${COL2}s %-${COL3}s %-${COL4}s %-${COL5}s\n" \
    "Directory" "Permissions" "Owner" "Group" "Size"

# Print a separator line under the header
printf '%0.s-' {1..75}
echo ""

# --- MAIN FOR LOOP ---
# Iterate over each directory in the DIRS array
# The "${DIRS[@]}" syntax expands all elements of the array
for DIR in "${DIRS[@]}"; do

    # Check if the directory exists using the -d test flag
    if [ -d "$DIR" ]; then

        # Extract permissions, owner, and group from ls -ld output
        # ls -ld produces: drwxr-xr-x 2 root root 4096 Jan 1 00:00 /etc
        # awk '{print $1}' extracts field 1 (permissions)
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')

        # awk '{print $3}' extracts field 3 (owner username)
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')

        # awk '{print $4}' extracts field 4 (group name)
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh gives human-readable size; cut -f1 takes just the size (before the tab)
        # 2>/dev/null suppresses "permission denied" errors for dirs we can't fully read
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print the row using printf for consistent column alignment
        printf "%-${COL1}s %-${COL2}s %-${COL3}s %-${COL4}s %-${COL5}s\n" \
            "$DIR" "$PERMS" "$OWNER" "$GROUP" "${SIZE:-N/A}"

    else
        # Directory does not exist on this system — print a clear message
        printf "%-${COL1}s %s\n" "$DIR" "[NOT FOUND on this system]"
    fi

done    # End of for loop

echo ""
printf '%0.s-' {1..75}
echo ""
echo ""

# --- GIT CONFIGURATION FILE CHECK ---
# Git-specific section: check for system-wide and user-level config files
# This shows how the chosen software integrates into the Linux filesystem

echo "--- Git Configuration File Audit ---"
echo ""

# Check system-wide Git config at /etc/gitconfig
SYSTEM_CONFIG="/etc/gitconfig"

if [ -f "$SYSTEM_CONFIG" ]; then
    # -f tests if the path is a regular file (not a directory)
    PERMS=$(ls -l "$SYSTEM_CONFIG" | awk '{print $1}')
    OWNER=$(ls -l "$SYSTEM_CONFIG" | awk '{print $3}')
    echo "  System config   : $SYSTEM_CONFIG"
    echo "  Permissions     : $PERMS (Owner: $OWNER)"
    echo "  Status          : EXISTS — system-wide Git settings are configured"
else
    echo "  System config   : $SYSTEM_CONFIG — NOT FOUND"
    echo "  Note            : No system-wide Git config exists on this machine."
fi

echo ""

# Check user-level Git config at ~/.gitconfig
USER_CONFIG="$HOME/.gitconfig"

if [ -f "$USER_CONFIG" ]; then
    PERMS=$(ls -l "$USER_CONFIG" | awk '{print $1}')
    OWNER=$(ls -l "$USER_CONFIG" | awk '{print $3}')
    echo "  User config     : $USER_CONFIG"
    echo "  Permissions     : $PERMS (Owner: $OWNER)"
    # Check if user.name is configured (a sign Git has been properly set up)
    if git config --global user.name &>/dev/null; then
        GIT_USER=$(git config --global user.name)
        echo "  Git user.name   : $GIT_USER"
        echo "  Status          : Git is configured for user: $(whoami)"
    else
        echo "  Status          : EXISTS but git user.name is not set"
    fi
else
    echo "  User config     : $USER_CONFIG — NOT FOUND"
    echo "  Note            : Run 'git config --global user.name' to set it up."
fi

echo ""
echo "=============================================="
echo "       End of Disk and Permission Auditor    "
echo "=============================================="
