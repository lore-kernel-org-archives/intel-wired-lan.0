From: kbuild test robot <lkp@intel.com>
Date: Wed, 5 Dec 2018 13:25:56 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 14/17] ERROR:
 "mdiobus_unregister" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
Message-ID: <201812051354.XWZtO56P%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7e1ab79ec66131e03715c31928e09efd1c749cef
commit: 444b102251854611659c8569bef3e43049603f7c [14/17] ixgbe: register a mdiobus
config: i386-randconfig-s2-12051035 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 444b102251854611659c8569bef3e43049603f7c
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "__mdiobus_register" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
>> ERROR: "mdiobus_unregister" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
>> ERROR: "devm_mdiobus_alloc_size" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
>> ERROR: "devm_mdiobus_free" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31111 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181205/1b858471/attachment-0001.bin>
