From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 29 Aug 2017 15:11:32 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 1456/1532] ERROR:
 "ncsi_vlan_rx_kill_vid" [drivers/net/ethernet/faraday/ftgmac100.ko]
 undefined!
Message-ID: <201708291530.5IwdGdNU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7e65674d184b2ffda5f2dea1dd401bc990234aad
commit: 51564585d8c6de28931ceff51f73eb800147221d [1456/1532] ftgmac100: Support NCSI VLAN filtering when available
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 51564585d8c6de28931ceff51f73eb800147221d
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "ncsi_vlan_rx_kill_vid" [drivers/net/ethernet/faraday/ftgmac100.ko] undefined!
>> ERROR: "ncsi_vlan_rx_add_vid" [drivers/net/ethernet/faraday/ftgmac100.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63444 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170829/af22fa7c/attachment-0001.bin>
