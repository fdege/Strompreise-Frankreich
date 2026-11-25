# Stromtarif EDF Tempo

Zeigt auf dem iPhone die Strompreise (ct/kWh) für heute und morgen mit Ampelfarbe an.

Die App ist eine einzige HTML-Datei ohne Server: Sie läuft komplett im Browser des iPhones
und holt die Daten selbst. Es muss kein Rechner laufen.

## Dateien

    index.html     die komplette App (HTML, CSS, JavaScript in einer Datei)
    manifest.json  Angaben für den Start vom Home-Bildschirm
    icon-180.png   App-Symbol (iPhone)
    icon-512.png   App-Symbol (groß)

Für die App genügt `index.html`. Die drei anderen Dateien machen nur das Symbol und den
Start vom Home-Bildschirm schöner.

## Auf das iPhone bringen

Die App braucht eine Web-Adresse (http/https). Ein direkt vom iPhone geöffnetes HTML-Dokument
funktioniert nicht, weil Safari dann keine Internetdaten laden darf.

**GitHub Pages (kostenlos, dauerhaft, empfohlen)**

1. Auf github.com ein Konto anlegen oder anmelden.
2. Neues Repository, z. B. `stromtarif`, auf „Public“ stellen.
3. `index.html`, `manifest.json`, `icon-180.png`, `icon-512.png` hochladen.
4. Im Repository unter Settings → Pages bei „Branch“ `main` und `/ (root)` wählen, speichern.
5. Nach ein bis zwei Minuten ist die App erreichbar unter
   `https://<benutzername>.github.io/stromtarif/`.

**Andere Wege**

- Netlify Drop oder Cloudflare Pages: den Ordner auf die Seite ziehen.
- Eigener Webspace: die Dateien in ein Verzeichnis kopieren.
- Zum Ausprobieren am Rechner: im Ordner `python3 -m http.server 8790` starten und
  `http://127.0.0.1:8790` öffnen.

**Auf dem iPhone einrichten**

1. Die Adresse in Safari öffnen.
2. Teilen-Symbol → „Zum Home-Bildschirm“.
3. Die App startet danach wie eine normale App mit eigenem Symbol.

## Datenquellen

- **Tempo-Farbe (Blau/Weiß/Rot) für gestern, heute und morgen:** offizielle EDF-Schnittstelle
  (`api-commerce.edf.fr`). Ist sie nicht erreichbar, wird `api-couleur-tempo.fr` abgefragt.
- **Preise je kWh inkl. Steuern:** die offizielle Tarifdatei der CRE, gespiegelt über
  `jourtempo.fr`. Fällt sie aus, wird `api-couleur-tempo.fr` abgefragt, danach gelten die in
  `index.html` hinterlegten Preise.
- Die Fußzeile zeigt immer, welche Quelle gerade verwendet wurde.

Alle drei Quellen erlauben den direkten Zugriff aus dem Browser (CORS), deshalb ist kein
eigener Server nötig.

## Rechenregeln

- Ein Tempo-Tag läuft von 6 Uhr bis 6 Uhr: 00:00–06:00 gilt die Nebenzeit des Vortags,
  06:00–22:00 die Hauptzeit, ab 22:00 die Nebenzeit.
- Ampel: unter 20 ct grün, ab 20 ct gelb, über 30 ct rot.
- Ist gerade der teure rote Abschnitt aktiv (rote Hauptzeit, 72,95 ct), zeigt die obere Box den
  Hinweis „Heute nicht waschen und nicht backen!“. In der roten Nebenzeit (16,15 ct) erscheint
  er nicht, weil Strom dann günstig ist.
- Vorwarnung: Sobald für morgen der rote Tarif veröffentlicht ist (meist gegen 11 Uhr), steht
  unter der oberen Box „Morgen rot – Heute Abend noch waschen und backen.“
- Die App lädt alle 10 Minuten neu, außerdem beim Öffnen, bei Tageswechsel und sobald das
  iPhone wieder Internet hat. Die zuletzt geladenen Werte werden im Gerät gespeichert und
  bei fehlender Verbindung mit einem Hinweis weiter angezeigt.
