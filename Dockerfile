# Use an official Ubuntu as base image
FROM ubuntu:latest

# Install Firefox, VNC server, and noVNC
RUN apt-get update && apt-get install -y \
    firefox \
    x11vnc \
    novnc \
    websockify \
    xterm \
    && rm -rf /var/lib/apt/lists/*

# Set the VNC password
RUN mkdir -p ~/.vnc && \
    x11vnc -storepasswd 1234 ~/.vnc/passwd

# Expose the necessary ports
EXPOSE 5901 6080

# Start the VNC server and noVNC
CMD ["sh", "-c", "x11vnc -forever -usepw -create -display :0 & websockify --web /usr/share/novnc 6080 localhost:5901"]
