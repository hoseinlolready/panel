#!/bin/bash

clear
echo "=== Meli Tunnel ==="
echo "[1] Start Server"
echo "[2] Start Client"
read -p "Choose option (1 or 2): " CHOICE

download_and_unzip() {
    URL=$1
    echo "[*] Downloading Melitunnel..."
    curl -L -o pingtunnel.zip "$URL"
    unzip -o pingtunnel.zip
    chmod +x pingtunnel
    rm pingtunnel.zip
}

if [ "$CHOICE" = "1" ]; then
    clear
    echo "=== Meli Tunnel - Server ==="
    read -p "Enter port to listen: " SPORT
    read -p "Enter password: " PASS
    download_and_unzip "https://github.com/hoseinlolready/panel/raw/refs/heads/main/pingtunnel.zip"
    echo "[+] Running server in background..."
    ./pingtunnel -type server -key "$PASS" -nolog 1 -noprint 1 -maxconn 200 -maxprt 120 -maxprb 1000 -conntt 1000 -tcp_mw 20000 &
elif [ "$CHOICE" = "2" ]; then
    clear
    echo "=== Meli Tunnel - Client ==="
    read -p "Enter server IP: " SERVER_IP
    read -p "Enter server port: " SERVER_PORT
    read -p "Enter local listen port: " LOCAL_PORT
    download_and_unzip "http://193.39.9.36/pingtunnel.zip"
    echo "[+] Running client in background..."
    ./pingtunnel -type client -l ":$LOCAL_PORT" -s "$SERVER_IP" -t "$SERVER_IP:$SERVER_PORT" -tcp 1 -key "123456" -tcp_bs 524288 -tcp_mw 5000 -maxprt 20 -maxprb 100 -timeout 30 -nolog 1 -noprint 1 &
else
    echo "Invalid option"
fi
