From: Adam Reichold <adam.reichold@rhebo.com>
Date: Mon, 4 Mar 2019 13:54:34 +0100
Subject: [Intel-wired-lan] igb driver fails to probe 3 out of 4 ports on Lex
 3I380NX (i210) after kernel 4.9
Message-ID: <CACQz5Gn-NZ6TCFYjjNTOD4m8u4gSvuAYiPN8KKQKsn59assb6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

we are using Lanner devices based on the Lex 3I380NX [1]. These have
four Ethernet ports using Intel i210 NIC. When deploying a newer
OpenWrt release to these devices which uses kernel version 4.14, we
noticed that the igb driver failed to probe all but the first port
[2]. After further investigation, this seems to a problem with the
upstream igb driver code past kernel version 4.9 independent of any
OpenWrt-specific patches, i.e. what we see at the moment is:

* kernel version 4.9 works fine, no matter whether
  * the driver is built into the kernel image or loaded as a module
  * we use the vanilla kernel sources or apply OpenWrt's patches
* kernel versions 4.14 and 4.19 do not work,
  * if the driver is built into the kernel image, all four ports are
probed but the links on all but the first one stay down and ethtool's
self-test fails
  * if the driver is loaded as module, probing of all but the first
port fails with "igb: probe of 0000:02:00.0 failed with error -2"
  * for kernel version 4.14, this applies with and without OpenWrt's
patches (for version 4.19, the OpenWrt 18.06 branch does not carry any
patches yet)

The OpenWrt bug report [2] contains some "lspci -vvv" output, but
please let me know what information I can provide and/or changes I can
test to make it possible to debug and hopefully fix this so that the
hardware is not bound to the ageing 4.9 kernel. Thank you for your
help!

Best regards,
Adam

[1] http://www.lex.com.tw/products/3I380NX.html

[2] https://bugs.openwrt.org/index.php?do=details&task_id=1923

-- 
Adam Reichold | Research & Development
Rhebo GmbH | Spinnereistr. 7 ? Halle 6/2.OG ? 04179 Leipzig
Telefon: +49-341-393 790 0

Gesch?ftsf?hrung: Klaus Mochalski | Kristin Pre?ler
Amtsgericht Leipzig, HRB 32587
