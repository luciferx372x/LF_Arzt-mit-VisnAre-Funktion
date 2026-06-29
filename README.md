# LF_Arzt (AI-Medic & Hospital Revive Script)

Ein hochentwickeltes FiveM-Skript für das **ESX-Framework**, das vollständig für das **visn_are** Medizinsystem optimiert wurde. Es ermöglicht Spielern, entweder an Krankenhaus-Tresen von NPCs geheilt zu werden oder einen vollautomatischen KI-Notarzt zu rufen, der mit authentischen Fahr- und Reanimationsanimationen (CPR) anreist.

---

## 🚀 Features

* **Vollständige `visn_are` Integration**: Bereinigt zuverlässig den `Health Buffer`, stoppt rote Overlays und beendet den Bewusstlosigkeits-Status sowohl client- als auch serverseitig.
* **KI-Notarzt (`/callmedic`)**: Spawnt ein konfigurierbares Ambulanz-Fahrzeug welches eigenständig zum verletzten Spieler navigiert.
* **Immersive Animationen**: Der KI-Arzt steigt realistisch aus, läuft zum Patienten und führt eine visuelle **Herzdruckmassage (CPR)** durch.
* **Krankenhaus-NPCs**: Konfigurierbare Tresen-Peds an den Krankenhäusern für eine direkte, stationäre Behandlung.
* **Sicherheits-Checks**: Automatischer Abgleich, ob echte Sanitäter (`ambulance` Job) online sind, um Missbrauch zu verhindern.
* **Doppelbenachrichtigungs-Schutz**: Bereinigte Event-Struktur für saubere UI-Meldungen ohne redundante Texte.

---

## 🛠️ Installation

1. Lade den Ordner `LF_Arzt` herunter und platziere ihn in deinem `resources` Verzeichnis.
2. Trage das Skript in deine `server.cfg` ein:
   ```cfg
   ensure LF_Arzt
