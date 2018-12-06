From: kbuild test robot <lkp@intel.com>
Date: Thu, 6 Dec 2018 15:28:07 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 15/19] ERROR:
 "mdiobus_write" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
Message-ID: <201812061505.uoTY2sKM%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   d3daa6adeda2134473d321a6c34587fcf9e8a000
commit: 44172b1cddde16363f2fb2d6b22d67c66d5a91ef [15/19] ixgbe: use mii_bus to handle MII related ioctls
config: x86_64-randconfig-h0-12061302 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 44172b1cddde16363f2fb2d6b22d67c66d5a91ef
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   ERROR: "__mdiobus_register" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
>> ERROR: "mdiobus_write" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
   ERROR: "mdiobus_unregister" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
   ERROR: "devm_mdiobus_alloc_size" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
>> ERROR: "mdiobus_read" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
   ERROR: "devm_mdiobus_free" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32694 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181206/9efa099c/attachment-0001.bin>
