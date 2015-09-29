From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 29 Sep 2015 14:20:56 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 32/134]
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:129:12: warning:
 'ixgbe_get_cs4227_status' defined but not used
Message-ID: <201509291454.fGmMdfRo%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   c92a893286c9df9eccaa72cb355a78e2de47f006
commit: 06add52056ace8ff659f6f442488bb46f83736a8 [32/134] ixgbe: Remove CS4227 diagnostic code
config: powerpc-defconfig (attached as .config)
reproduce:
  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
  chmod +x ~/bin/make.cross
  git checkout 06add52056ace8ff659f6f442488bb46f83736a8
  # save the attached .config to linux build tree
  make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:129:12: warning: 'ixgbe_get_cs4227_status' defined but not used [-Wunused-function]
    static s32 ixgbe_get_cs4227_status(struct ixgbe_hw *hw)
               ^

vim +/ixgbe_get_cs4227_status +129 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c

542b6eec Mark Rustad 2015-08-08  113  	if (reg_val) {
542b6eec Mark Rustad 2015-08-08  114  		hw_err(hw, "CS4227 reg 0x%04X failed diagnostic\n", reg);
542b6eec Mark Rustad 2015-08-08  115  		return status;
542b6eec Mark Rustad 2015-08-08  116  	}
542b6eec Mark Rustad 2015-08-08  117  
542b6eec Mark Rustad 2015-08-08  118  	return 0;
542b6eec Mark Rustad 2015-08-08  119  }
542b6eec Mark Rustad 2015-08-08  120  
542b6eec Mark Rustad 2015-08-08  121  /**
542b6eec Mark Rustad 2015-08-08  122   * ixgbe_get_cs4227_status - Return CS4227 status
542b6eec Mark Rustad 2015-08-08  123   * @hw: pointer to hardware structure
542b6eec Mark Rustad 2015-08-08  124   *
542b6eec Mark Rustad 2015-08-08  125   * Performs a diagnostic on the CS4227 chip. Returns an error if it is
542b6eec Mark Rustad 2015-08-08  126   * not operating correctly.
542b6eec Mark Rustad 2015-08-08  127   * This function assumes that the caller has acquired the proper semaphore.
542b6eec Mark Rustad 2015-08-08  128   */
542b6eec Mark Rustad 2015-08-08 @129  static s32 ixgbe_get_cs4227_status(struct ixgbe_hw *hw)
542b6eec Mark Rustad 2015-08-08  130  {
542b6eec Mark Rustad 2015-08-08  131  	s32 status;
542b6eec Mark Rustad 2015-08-08  132  	u16 value = 0;
542b6eec Mark Rustad 2015-08-08  133  
542b6eec Mark Rustad 2015-08-08  134  	/* Exit if the diagnostic has already been performed. */
542b6eec Mark Rustad 2015-08-08  135  	status = ixgbe_read_cs4227(hw, IXGBE_CS4227_SCRATCH, &value);
542b6eec Mark Rustad 2015-08-08  136  	if (status)
542b6eec Mark Rustad 2015-08-08  137  		return status;

:::::: The code at line 129 was first introduced by commit
:::::: 542b6eecf4c3640f15a84ff89525131d421e7c8c ixgbe: Add logic to reset CS4227 when needed

:::::: TO: Mark Rustad <mark.d.rustad@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21511 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150929/d82fa358/attachment-0001.obj>
