FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

ARG APT_MIRROR="https://mirror.sjtu.edu.cn/"
ARG TEXLIVE_MIRROR="https://mirror.ctan.org/systems/texlive"

# Debian 12 (bookworm) uses "/etc/apt/sources.list.d/debian.sources".
# Enable the "contrib" component for the "fonts-ibm-plex" package.
RUN sed -i'.bak' \
        -e "s|^URIs: http://deb.debian.org/|URIs: ${APT_MIRROR%/}/|" \
        -e "s|^Components: .*$|Components: main contrib|" \
        /etc/apt/sources.list.d/debian.sources

# APT SSL issue:
# The mirror may use a Let's Encrypt certificate that requires an updated
# "ca-certificates" than the one in 12 (bookworm).  So set the
# "Acquire::https::Verify-Peer=false" option to workaround the issue.
#
# TeXLive packages:
# * texlive-lang-cjk -> xeCJK.sty
# * texlive-lang-chinese -> ctexhook.sty
# * texlive-fonts-recommended -> pzdr.tfm (required by mktextfm pzdr)
#
# FontAwesome:
# Debian has packaged the FontAwesome font in the "textlive-fonts-extra"
# package, but that's a HUGE one and thus costs unnecessary space.
# Therefore, it's better to install the only needed package with tlmgr.
# Since the CTAN repo can become newer and then break the builtin download
# feature of tlmgr, we manually download the package and install it.
RUN set -ex && \
    apt-get -o "Acquire::https::Verify-Peer=false" update && \
    apt-get -o "Acquire::https::Verify-Peer=false" -y \
        install ca-certificates && \
    apt-get -y --no-install-recommends install \
        make ghostscript \
	latexmk texlive-xetex \
        texlive-lang-cjk texlive-lang-chinese \
        fonts-ibm-plex fonts-noto-cjk texlive-fonts-recommended && \
    apt-get -y --no-install-recommends install \
        wget xz-utils && \
    rm -rf /var/lib/apt/lists/*
RUN set -ex && \
    wget ${TEXLIVE_MIRROR}/tlnet/archive/fontawesome5.tar.xz && \
    tlmgr --usermode init-usertree && \
    tlmgr --usermode install --file fontawesome5.tar.xz && \
    rm -f fontawesome5.tar.xz
