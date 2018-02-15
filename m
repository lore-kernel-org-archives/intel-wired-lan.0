From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 15 Feb 2018 13:57:13 +0200
Subject: [Intel-wired-lan] How to install e1000e.ko to Debian 9
In-Reply-To: <45eb0080-4ad6-c88a-a2dd-a435c89bbd8c@actiu.net>
References: <45eb0080-4ad6-c88a-a2dd-a435c89bbd8c@actiu.net>
Message-ID: <e2268d60-8fc5-35b1-cea5-4500ffe0e5e0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/15/2018 10:39, Narcis Garcia wrote:
> My steps:
> 
> $ uname -srvm
> Linux 4.9.0-5-amd64 #1 SMP Debian 4.9.65-3+deb9u2 (2018-01-04) x86_64
> 
> 0. Install build/compiler tools:
> sudo apt-get install build-essential linux-headers-amd64
> 
> 1. Download latest stable version (3.4.0.2) from:
> https://sourceforge.net/projects/e1000/files/e1000e%20stable/
> 
> 2. Unpack:
> tar zxf e1000e-*.tar.gz
> 
> 3. Compile and install:
> cd e1000e-*/src/
> sudo make install
> 
> cc1: error: code model kernel does not support PIC mode
> /bin/sh: 1: [: -ge: unexpected operator
> Makefile:199: *** *** Aborting the build. *** This driver is not
> supported on kernel versions older than 2.4.0.  Alto.
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
Please, follow discussion on SourceForge: 
https://sourceforge.net/p/e1000/bugs/542/
