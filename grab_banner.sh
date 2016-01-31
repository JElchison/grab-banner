#!/bin/bash

# grab-banner.sh
#
# Bash script that performs generic banner grabbing, multiple ports per host
#
# Version 1.0.0
#
# Copyright (C) 2016 Jonathan Elchison <JElchison@gmail.com>


# setup Bash environment
set -uf -o pipefail

# setup variables
SERVICES_FILE=/etc/services


###############################################################################
# functions
###############################################################################

# Prints script usage to stderr
# Arguments:
#   None
# Returns:
#   None
print_usage() {
    echo "Usage:    $0 <host> <tcp_port> [tcp_port] [tcp_port...]" >&2
    echo "Example:  $0 google.com 80 443" >&2
}


###############################################################################
# test dependencies
###############################################################################

if [[ ! -x $(which awk) ]]; then
    echo "[-] ERROR: Required dependencies unmet. Please verify that the following are installed, executable, and in the PATH:  awk" >&2
    exit 1
fi

if [[ ! -x $(which curl) ]] ||
   [[ ! -x $(which openssl) ]] ||
   [[ ! -x $(which nc) ]]; then
    echo "[-] WARNING: Optional dependencies unmet. Please verify that the following are installed, executable, and in the PATH:  curl, openssl, nc" >&2
fi

if [[ ! -r $SERVICES_FILE ]]; then
    echo "[-] WARNING: Optional dependencies unmet. Please verify that the following file is present and readable:  $SERVICES_FILE" >&2
fi



###############################################################################
# validate arguments
###############################################################################

# require at least 2 arguments
if [[ $# -lt 2 ]]; then
    print_usage
    exit 1
fi

# setup variables for arguments
SERVER=$1


###############################################################################
# grab banners on listed ports
###############################################################################

shift
for PORT in "$@"; do
    echo "[*] =====================================================" >&2
    echo "[+] Grabbing banner from $SERVER:$PORT [$(grep "[^0-9]$PORT/tcp" $SERVICES_FILE | awk '{print $1}')] ..." >&2
    echo "[*] =====================================================" >&2
    case $PORT in
        80)
            curl -s -D - -o /dev/null http://$SERVER
            ;;
        443)
            curl -k -s -v -D - https://$SERVER > /dev/null
            ;;
        465|563|587|636|695|898|989|990|992|993|994|995)
            sleep 3 | openssl s_client -connect $SERVER:$PORT
            ;;
        *)
            nc -q 0 -w 2 $SERVER $PORT
            ;;
    esac
    echo >&2
done
