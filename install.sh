#!/bin/bash

echo "Installing dependencies for PlutoXAnalyzer..."

# Update sistem
sudo apt-get update

# Install Java (Wajib untuk apktool)
sudo apt-get install -y openjdk-17-jdk

# Install Binutils (Untuk perintah strings)
[span_1](start_span)sudo apt-get install -y binutils[span_1](end_span)

# Install Apktool
sudo wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool
sudo wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.10.0.jar -O apktool.jar
sudo chmod +x apktool
sudo mv apktool apktool.jar /usr/local/bin/

# Install Apksigner
sudo apt-get install -y apksigner

echo "Installation Complete!"
