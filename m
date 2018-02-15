From: Narcis Garcia <informatica@actiu.net>
Date: Thu, 15 Feb 2018 09:39:21 +0100
Subject: [Intel-wired-lan] How to install e1000e.ko to Debian 9
Message-ID: <45eb0080-4ad6-c88a-a2dd-a435c89bbd8c@actiu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

My steps:

$ uname -srvm
Linux 4.9.0-5-amd64 #1 SMP Debian 4.9.65-3+deb9u2 (2018-01-04) x86_64

0. Install build/compiler tools:
sudo apt-get install build-essential linux-headers-amd64

1. Download latest stable version (3.4.0.2) from:
https://sourceforge.net/projects/e1000/files/e1000e%20stable/

2. Unpack:
tar zxf e1000e-*.tar.gz

3. Compile and install:
cd e1000e-*/src/
sudo make install

cc1: error: code model kernel does not support PIC mode
/bin/sh: 1: [: -ge: unexpected operator
Makefile:199: *** *** Aborting the build. *** This driver is not
supported on kernel versions older than 2.4.0.  Alto.
