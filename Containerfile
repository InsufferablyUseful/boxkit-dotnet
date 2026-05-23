FROM  quay.io/toolbx-images/debian-toolbox:13

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native Jetbrains Rider experience" \
      maintainer="benrobertson150@hotmail.co.uk"

COPY jetbrainsPath.sh /etc/profile.d/
COPY extra-packages /
RUN wget https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
sudo dpkg -i packages-microsoft-prod.deb && \
rm packages-microsoft-prod.deb
#Update core packages
RUN apt-get update && \
    apt-get -y upgrade && \
    grep -v '^#' /extra-packages | xargs apt-get -y install
#Install Rider
RUN wget https://download.jetbrains.com/rider/JetBrains.Rider-2026.1.1.tar.gz -O /opt/rider.tar.gz && \
    tar -xf /opt/rider.tar.gz -C /opt && \ 
    rm /opt/rider.tar.gz && \
    mv /opt/*JetBrains\ Rider-* /opt/Rider
CMD /bin/bash
    
