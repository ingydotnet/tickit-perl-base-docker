FROM termui/tickit-base:0.0.1
COPY build.sh /
RUN time sh /build.sh true
