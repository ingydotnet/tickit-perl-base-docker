FROM termui/tickit-base:0.0.1

RUN apk --update add openssl && \
    wget https://raw.githubusercontent.com/ingydotnet/tickit-perl-base-docker/master/build.sh && \
    time sh /build.sh true
