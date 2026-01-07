FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0
ENV RESOLUTION=1280x800

# Install dependencies
RUN apt-get update && apt-get install -y \
    openjdk-17-jdk \
    xvfb \
    x11vnc \
    fluxbox \
    novnc \
    websockify \
    net-tools \
    procps \
    curl \
    ca-certificates \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Setup novnc
# /usr/share/novnc is where the package installs it usually.
# We need to link the vnc.html to index.html so it loads by default
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html

# Tools folder with latest VisualVM and Eclipse MAT
RUN mkdir -p /tools && \
    cd /tools && \
    curl -L -o visualvm_22.zip https://github.com/oracle/visualvm/releases/download/2.2/visualvm_22.zip && \
    unzip visualvm_22.zip && \
    rm visualvm_22.zip && \
    curl -L -o mat.zip https://download.eclipse.org/mat/1.16.1/rcp/MemoryAnalyzer-1.16.1.20250109-linux.gtk.x86_64.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose HTTP port for noVNC
EXPOSE 6080

CMD ["/entrypoint.sh"]

