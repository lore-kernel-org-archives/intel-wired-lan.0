From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 24 Oct 2015 13:11:59 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 82/82]
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1067:2: error: implicit
 declaration of function 'CLOCKSOURCE_MASK'
Message-ID: <201510241358.cD4Q6z5X%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   178bf00918593457f983873c49d3072f54eacfed
commit: 178bf00918593457f983873c49d3072f54eacfed [82/82] ixgbe: Update PTP to support X550EM_x devices
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 178bf00918593457f983873c49d3072f54eacfed
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c: In function 'ixgbe_ptp_start_cyclecounter':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1067:2: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
     cc.mask = CLOCKSOURCE_MASK(64);
     ^
   cc1: some warnings being treated as errors

vim +/CLOCKSOURCE_MASK +1067 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c

  1061		 * they do not properly function if the overflow point isn't 2^N-1.
  1062		 * However, the actual SYSTIME values in question take ~138 years to
  1063		 * overflow. In practice this means they won't actually overflow. A
  1064		 * proper fix to this problem would require modification of the
  1065		 * timecounter delta calculations.
  1066		 */
> 1067		cc.mask = CLOCKSOURCE_MASK(64);
  1068		cc.mult = 1;
  1069		cc.shift = 0;
  1070	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 42521 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151024/9f9d9f4a/attachment-0001.obj>
