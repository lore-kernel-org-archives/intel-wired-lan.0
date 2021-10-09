From: kernel test robot <lkp@intel.com>
Date: Sun, 10 Oct 2021 04:01:54 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 117/129] ERROR:
 modpost: "ice_gnss_is_gps_present" [drivers/net/ethernet/intel/ice/ice.ko]
 undefined!
Message-ID: <202110100452.v4ILSJCw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   45f840993bd1843d39fc79a01eab2995a290ad4b
commit: 89614a6907441033da91287488be6bfe91ec3e67 [117/129] ice: add TTY device for GNSS module for E810T device
config: x86_64-randconfig-s021-20211009 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=89614a6907441033da91287488be6bfe91ec3e67
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 89614a6907441033da91287488be6bfe91ec3e67
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "ice_gnss_is_gps_present" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
>> ERROR: modpost: "ice_gnss_init" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
>> ERROR: modpost: "ice_gnss_exit" [drivers/net/ethernet/intel/ice/ice.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33086 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211010/254a602f/attachment-0001.bin>
