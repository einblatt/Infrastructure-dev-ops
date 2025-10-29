#安装unzip
if ! command -v unzip 2>&1 >/dev/null; then
    echo "Installing unzip..."
    sudo apt-get update && sudo apt-get install -y unzip
fi

curl -L https://github.com/einblatt/Infrastructure-dev-ops/archive/refs/heads/main.zip -o /usr/local/service.zip && sudo unzip -o /usr/local/service.zip && rm /usr/local/service.zip
