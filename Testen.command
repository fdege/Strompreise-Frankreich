#!/bin/zsh
# Startet die Stromtarif-App zum Ausprobieren im Browser.
# Beenden mit Ctrl+C oder Fenster schließen.

export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"
cd "$(dirname "$0")"

PORT=8790

if command -v python3 >/dev/null 2>&1; then
  PYTHON=$(command -v python3)
elif [ -x /usr/bin/python3 ]; then
  PYTHON=/usr/bin/python3
else
  echo "Python 3 wurde nicht gefunden. Bitte Python installieren oder die Dateien auf einen Webspace kopieren."
  read -r "?Zum Schließen Enter drücken"
  exit 1
fi

echo "Stromtarif-App läuft."
echo "  Am Mac:      http://127.0.0.1:$PORT"
IP=$(ipconfig getifaddr en0 2>/dev/null)
[ -n "$IP" ] && echo "  Im WLAN (iPhone): http://$IP:$PORT"
echo "Beenden mit Ctrl+C."
echo

(sleep 1; open "http://127.0.0.1:$PORT/") &
exec "$PYTHON" -m http.server "$PORT" --bind 0.0.0.0
