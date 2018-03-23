# Installs Arc KDE Theme for KDE Plasma 5
# Also installs Papirus icon theme for consitent look
# <https://github.com/PapirusDevelopmentTeam/arc-kde>
# <https://github.com/PapirusDevelopmentTeam/papirus-icon-theme>


sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sudo apt-get install --install-recommends arc-kde
sudo apt-get install papirus-icon-theme


echo "\n A few more steps are needed before you DE is updated to Arc Dark."
echo "\n1. Go to Icons and select Papirus-Dark."
echo "\n2. Go to Settings > Color and choose Arc Dark."
echo "\n3. Run Kvantum manager and select ArcDark theme."
echo "\n4. Go to Desktop Theme and change to Arc Dark."
echo "\n5. You should also change the desktop wallpaper."
echo "\nYou might need hardcode-fixer: https://github.com/Foggalong/hardcode-fixer"