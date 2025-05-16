# Ubuntu বেস ইমেজ ব্যবহার
FROM ubuntu:latest

# প্রয়োজনীয় প্যাকেজ ইনস্টল
RUN apt-get update && apt-get install -y \
    firefox \
    x11vnc \
    novnc \
    websockify \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# VNC পাসওয়ার্ড সেট করা
RUN mkdir -p ~/.vnc && \
    x11vnc -storepasswd 1234 ~/.vnc/passwd

# পোর্ট এক্সপোজ করা
EXPOSE 5901 6080

# Firefox চালানোর জন্য Xvfb (X virtual framebuffer) এবং VNC, noVNC চালানোর কমান্ড
CMD Xvfb :0 -screen 0 1024x768x16 & \
    export DISPLAY=:0 && \
    firefox & \
    x11vnc -forever -usepw -create -display :0 & \
    websockify --web /usr/share/novnc 6080 localhost:5901
