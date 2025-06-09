FROM  ghcr.io/insufferablyuseful/boxkit:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native Jetbrains Rider experience" \
      maintainer="benrobertson150@hotmail.co.uk"

COPY extra-packages /
COPY rider.desktop /usr/share/applications/
#Update core packages
RUN grep -v '^#' /extra-packages | xargs apk add
#Install Rider
RUN wget -nv https://download.jetbrains.com/rider/JetBrains.Rider-2025.1.tar.gz -O /opt/rider.tar.gz && \
    tar -xf /opt/rider.tar.gz -C /opt && \ 
    rm /opt/rider.tar.gz && \
    ls /opt && \
    mv /opt/JetBrains\ Rider-*/ /opt/Rider 

CMD /bin/bash
#RUN   ln -fs /bin/sh /usr/bin/sh && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
#      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update
     
