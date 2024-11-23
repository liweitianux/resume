#
# Copyright (c) 2018,2024 Core2002
# MIT License
#

FROM ubuntu:latest
RUN sed -i 's/\/archive.ubuntu.com/\/mirrors.aliyun.com/g' `grep -rl "archive.ubuntu.com" /etc/apt/`

RUN apt-get update && apt-get install -y \
    make ghostscript latexmk texlive-xetex \
    texlive-lang-cjk texlive-lang-chinese texlive-fonts-recommended texlive-fonts-extra \
    fonts-ibm-plex fonts-noto-cjk fonts-font-awesome
