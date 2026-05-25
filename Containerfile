FROM  quay.io/toolbx-images/debian-toolbox:13

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native Jetbrains Rider experience" \
      maintainer="benrobertson150@hotmail.co.uk"

COPY jetbrainsPath.sh /etc/profile.d/
COPY godotPath.sh /etc/profile.d/
COPY extra-packages /
RUN wget -nv "https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb && \
sudo dpkg -i packages-microsoft-prod.deb && \
rm packages-microsoft-prod.deb
#Update core packages
RUN apt-get update && \
    apt-get -y upgrade && \
    grep -v '^#' /extra-packages | xargs apt-get -y install
#Install Rider
RUN wget -nv "https://download.jetbrains.com/rider/JetBrains.Rider-2026.1.2.tar.gz" -O /opt/rider.tar.gz && \
    tar -xf /opt/rider.tar.gz -C /opt && \ 
    rm /opt/rider.tar.gz && \
    mv /opt/*JetBrains\ Rider-* /opt/Rider
#Install Godot
RUN wget -nv "https://downloads.godotengine.org/?version=4.6.3&flavor=stable&slug=mono_linux_x86_64.zip&platform=linux.64" -O /opt/godot.zip && \
    unzip /opt/godot.zip -d /opt && \ 
    rm /opt/godot.zip && \
    mv /opt/Godot_* /opt/Godot && \
    mv /opt/Godot/Godot_* /opt/Godot/godot
CMD /bin/bash
    
