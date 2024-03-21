FROM  ghcr.io/insufferablyuseful/boxkit:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native Jetbrains Rider experience" \
      maintainer="benrobertson150@hotmail.co.uk"

COPY jetbrainsPath.sh /etc/profile.d/
#Update core packages
RUN apt-get update && \
    apt-get -y upgrade && \
    grep -v '^#' /extra-packages | xargs apt-get -y install
#Install Rider
RUN mkdir /opt/Rider && \
    wget https://download.jetbrains.com/rider/JetBrains.Rider-2023.3.3.tar.gz -O /opt/rider.tar.gz && \
    tar -xf /opt/rider.tar.gz -C /opt/Rider &&\ 
    rm /opt/rider.tar.gz
CMD /bin/bash
#RUN   ln -fs /bin/sh /usr/bin/sh && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
