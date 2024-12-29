#!/bin/bash
cd /opt/MuseScore

# URL de la page de téléchargement de MuseScore
url="https://musescore.org/en/download/musescore-x86_64.AppImage"

# Télécharge la page de téléchargement
page_content=$(curl -s "$url")

# Recherche l'URL directe du fichier tar.gz
download_url=$(echo "$page_content" | grep -oP 'https://cdn.jsdelivr.net/musescore/v\d+.\d+.\d+/MuseScore-Studio-\d+.\d+.\d+.\d+\d+\d+\d+\d+\d+\d+\d+\d+-x86_64.AppImage' | head -n 1)

# Nettoyage de l'URL pour enlever les caractères indésirables
clean_url=$(echo "$download_url" | tr -d '\r\n')

if [ -n "$clean_url" ]; then
    echo "URL de téléchargement : $clean_url"

    # Télécharge le fichier
    wget "$clean_url" -O ./MuseScore-Studio.AppImage

    # Vérifie si le téléchargement a réussi
    if [ $? -eq 0 ]; then
        echo "Téléchargement réussi."

        # Rendre le fichier exécutable
        chmod +x ./MuseScore-Studio.AppImage
        echo "Le fichier est maintenant exécutable."
    else
        echo "Échec du téléchargement."
    fi
else
    echo "URL de téléchargement non trouvée."
fi
