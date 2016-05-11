#!/bin/sh

set -e
set -x

(
  finalize=${1:?"First argument must be true or false"}

  apks="build-base curl perl perl-dev wget"
  apks_dev="bash ruby vim"

  apk add --update $apks

  if ! $finalize; then
    apk add $apks_dev
    gem install gist || true
  fi

  curl -L https://cpanmin.us | perl - App::cpanminus
  cpanm -n inc::latest
  cpanm -n Test::Fatal Test::HexString Test::Identity Test::Refcount
  cpanm -n -f Tickit::Async
  yes | cpanm -n --prompt Task::Tickit::Widget

  if $finalize; then
    apk del $apks
    apk del $apks_dev
    apk del openssl || true
    rm -fr /var/cache/apk/*

    rm -f /build.sh /docker-build.log
  fi

  du -sh /
) 2>&1 | tee /docker-build.log
