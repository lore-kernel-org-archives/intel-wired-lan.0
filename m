From: kernel test robot <lkp@intel.com>
Date: Mon, 8 Jun 2020 04:37:44 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 36/44]
 drivers/net/ethernet/intel/igc/igc_mac.c:373:6: warning: variable 'link' is
 used uninitialized whenever 'if' condition is true
Message-ID: <202006080436.snNxuRyC%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   bb74886dd020cb7d62869fc4a57c50b8bda718ad
commit: 4cbe66aa3a43a5910d9afe165b726711438d3612 [36/44] igc: Add initial LTR support
config: s390-randconfig-r023-20200607 (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project e429cffd4f228f70c1d9df0e5d77c08590dd9766)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390-linux-gnu
        git checkout 4cbe66aa3a43a5910d9afe165b726711438d3612
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

#define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
^
include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
___constant_swab32(x) :                                               ^
include/uapi/linux/swab.h:19:12: note: expanded from macro '___constant_swab32'
(((__u32)(x) & (__u32)0x000000ffUL) << 24) |                                 ^
In file included from drivers/net/ethernet/intel/igc/igc_mac.c:4:
In file included from include/linux/pci.h:39:
In file included from include/linux/io.h:13:
In file included from arch/s390/include/asm/io.h:72:
include/asm-generic/io.h:492:45: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
~~~~~~~~~~ ^
include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
#define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
^
include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
___constant_swab32(x) :                                               ^
include/uapi/linux/swab.h:20:12: note: expanded from macro '___constant_swab32'
(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |                                 ^
In file included from drivers/net/ethernet/intel/igc/igc_mac.c:4:
In file included from include/linux/pci.h:39:
In file included from include/linux/io.h:13:
In file included from arch/s390/include/asm/io.h:72:
include/asm-generic/io.h:492:45: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
~~~~~~~~~~ ^
include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
#define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
^
include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
___constant_swab32(x) :                                               ^
include/uapi/linux/swab.h:21:12: note: expanded from macro '___constant_swab32'
(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |                                 ^
In file included from drivers/net/ethernet/intel/igc/igc_mac.c:4:
In file included from include/linux/pci.h:39:
In file included from include/linux/io.h:13:
In file included from arch/s390/include/asm/io.h:72:
include/asm-generic/io.h:492:45: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
~~~~~~~~~~ ^
include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
#define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
^
include/uapi/linux/swab.h:119:21: note: expanded from macro '__swab32'
___constant_swab32(x) :                                               ^
include/uapi/linux/swab.h:22:12: note: expanded from macro '___constant_swab32'
(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
^
In file included from drivers/net/ethernet/intel/igc/igc_mac.c:4:
In file included from include/linux/pci.h:39:
In file included from include/linux/io.h:13:
In file included from arch/s390/include/asm/io.h:72:
include/asm-generic/io.h:492:45: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
~~~~~~~~~~ ^
include/uapi/linux/byteorder/big_endian.h:34:59: note: expanded from macro '__le32_to_cpu'
#define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
^
include/uapi/linux/swab.h:120:12: note: expanded from macro '__swab32'
__fswab32(x))
^
In file included from drivers/net/ethernet/intel/igc/igc_mac.c:4:
In file included from include/linux/pci.h:39:
In file included from include/linux/io.h:13:
In file included from arch/s390/include/asm/io.h:72:
include/asm-generic/io.h:503:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
__raw_writeb(value, PCI_IOBASE + addr);
~~~~~~~~~~ ^
include/asm-generic/io.h:513:46: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
__raw_writew(cpu_to_le16(value), PCI_IOBASE + addr);
~~~~~~~~~~ ^
include/asm-generic/io.h:523:46: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
__raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
~~~~~~~~~~ ^
include/asm-generic/io.h:585:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
readsb(PCI_IOBASE + addr, buffer, count);
~~~~~~~~~~ ^
include/asm-generic/io.h:593:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
readsw(PCI_IOBASE + addr, buffer, count);
~~~~~~~~~~ ^
include/asm-generic/io.h:601:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
readsl(PCI_IOBASE + addr, buffer, count);
~~~~~~~~~~ ^
include/asm-generic/io.h:610:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
writesb(PCI_IOBASE + addr, buffer, count);
~~~~~~~~~~ ^
include/asm-generic/io.h:619:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
writesw(PCI_IOBASE + addr, buffer, count);
~~~~~~~~~~ ^
include/asm-generic/io.h:628:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
writesl(PCI_IOBASE + addr, buffer, count);
~~~~~~~~~~ ^
>> drivers/net/ethernet/intel/igc/igc_mac.c:373:6: warning: variable 'link' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
if (!mac->get_link_status) {
^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/igc/igc_mac.c:423:33: note: uninitialized use occurs here
ret_val = igc_set_ltr_i225(hw, link);
^~~~
drivers/net/ethernet/intel/igc/igc_mac.c:373:2: note: remove the 'if' if its condition is always false
if (!mac->get_link_status) {
^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/igc/igc_mac.c:366:11: note: initialize the variable 'link' to silence this warning
bool link;
^
= 0
21 warnings generated.

vim +373 drivers/net/ethernet/intel/igc/igc_mac.c

ab4056126813c8 Sasha Neftin 2018-10-11  353  
ab4056126813c8 Sasha Neftin 2018-10-11  354  /**
ab4056126813c8 Sasha Neftin 2018-10-11  355   * igc_check_for_copper_link - Check for link (Copper)
ab4056126813c8 Sasha Neftin 2018-10-11  356   * @hw: pointer to the HW structure
ab4056126813c8 Sasha Neftin 2018-10-11  357   *
ab4056126813c8 Sasha Neftin 2018-10-11  358   * Checks to see of the link status of the hardware has changed.  If a
ab4056126813c8 Sasha Neftin 2018-10-11  359   * change in link status has been detected, then we read the PHY registers
ab4056126813c8 Sasha Neftin 2018-10-11  360   * to get the current speed/duplex if link exists.
ab4056126813c8 Sasha Neftin 2018-10-11  361   */
ab4056126813c8 Sasha Neftin 2018-10-11  362  s32 igc_check_for_copper_link(struct igc_hw *hw)
ab4056126813c8 Sasha Neftin 2018-10-11  363  {
ab4056126813c8 Sasha Neftin 2018-10-11  364  	struct igc_mac_info *mac = &hw->mac;
ab4056126813c8 Sasha Neftin 2018-10-11  365  	s32 ret_val;
ab4056126813c8 Sasha Neftin 2018-10-11  366  	bool link;
ab4056126813c8 Sasha Neftin 2018-10-11  367  
ab4056126813c8 Sasha Neftin 2018-10-11  368  	/* We only want to go out to the PHY registers to see if Auto-Neg
ab4056126813c8 Sasha Neftin 2018-10-11  369  	 * has completed and/or if our link status has changed.  The
ab4056126813c8 Sasha Neftin 2018-10-11  370  	 * get_link_status flag is set upon receiving a Link Status
ab4056126813c8 Sasha Neftin 2018-10-11  371  	 * Change or Rx Sequence Error interrupt.
ab4056126813c8 Sasha Neftin 2018-10-11  372  	 */
ab4056126813c8 Sasha Neftin 2018-10-11 @373  	if (!mac->get_link_status) {
ab4056126813c8 Sasha Neftin 2018-10-11  374  		ret_val = 0;
ab4056126813c8 Sasha Neftin 2018-10-11  375  		goto out;
ab4056126813c8 Sasha Neftin 2018-10-11  376  	}
ab4056126813c8 Sasha Neftin 2018-10-11  377  
ab4056126813c8 Sasha Neftin 2018-10-11  378  	/* First we want to see if the MII Status Register reports
ab4056126813c8 Sasha Neftin 2018-10-11  379  	 * link.  If so, then we want to get the current speed/duplex
ab4056126813c8 Sasha Neftin 2018-10-11  380  	 * of the PHY.
ab4056126813c8 Sasha Neftin 2018-10-11  381  	 */
5586838fe9ced0 Sasha Neftin 2018-10-11  382  	ret_val = igc_phy_has_link(hw, 1, 0, &link);
ab4056126813c8 Sasha Neftin 2018-10-11  383  	if (ret_val)
ab4056126813c8 Sasha Neftin 2018-10-11  384  		goto out;
ab4056126813c8 Sasha Neftin 2018-10-11  385  
ab4056126813c8 Sasha Neftin 2018-10-11  386  	if (!link)
ab4056126813c8 Sasha Neftin 2018-10-11  387  		goto out; /* No link detected */
ab4056126813c8 Sasha Neftin 2018-10-11  388  
ab4056126813c8 Sasha Neftin 2018-10-11  389  	mac->get_link_status = false;
ab4056126813c8 Sasha Neftin 2018-10-11  390  
ab4056126813c8 Sasha Neftin 2018-10-11  391  	/* Check if there was DownShift, must be checked
ab4056126813c8 Sasha Neftin 2018-10-11  392  	 * immediately after link-up
ab4056126813c8 Sasha Neftin 2018-10-11  393  	 */
5586838fe9ced0 Sasha Neftin 2018-10-11  394  	igc_check_downshift(hw);
ab4056126813c8 Sasha Neftin 2018-10-11  395  
ab4056126813c8 Sasha Neftin 2018-10-11  396  	/* If we are forcing speed/duplex, then we simply return since
ab4056126813c8 Sasha Neftin 2018-10-11  397  	 * we have already determined whether we have link or not.
ab4056126813c8 Sasha Neftin 2018-10-11  398  	 */
ab4056126813c8 Sasha Neftin 2018-10-11  399  	if (!mac->autoneg) {
ab4056126813c8 Sasha Neftin 2018-10-11  400  		ret_val = -IGC_ERR_CONFIG;
ab4056126813c8 Sasha Neftin 2018-10-11  401  		goto out;
ab4056126813c8 Sasha Neftin 2018-10-11  402  	}
ab4056126813c8 Sasha Neftin 2018-10-11  403  
ab4056126813c8 Sasha Neftin 2018-10-11  404  	/* Auto-Neg is enabled.  Auto Speed Detection takes care
ab4056126813c8 Sasha Neftin 2018-10-11  405  	 * of MAC speed/duplex configuration.  So we only need to
ab4056126813c8 Sasha Neftin 2018-10-11  406  	 * configure Collision Distance in the MAC.
ab4056126813c8 Sasha Neftin 2018-10-11  407  	 */
ab4056126813c8 Sasha Neftin 2018-10-11  408  	igc_config_collision_dist(hw);
ab4056126813c8 Sasha Neftin 2018-10-11  409  
ab4056126813c8 Sasha Neftin 2018-10-11  410  	/* Configure Flow Control now that Auto-Neg has completed.
ab4056126813c8 Sasha Neftin 2018-10-11  411  	 * First, we need to restore the desired flow control
ab4056126813c8 Sasha Neftin 2018-10-11  412  	 * settings because we may have had to re-autoneg with a
ab4056126813c8 Sasha Neftin 2018-10-11  413  	 * different link partner.
ab4056126813c8 Sasha Neftin 2018-10-11  414  	 */
4eb8080143a9d9 Sasha Neftin 2018-10-11  415  	ret_val = igc_config_fc_after_link_up(hw);
ab4056126813c8 Sasha Neftin 2018-10-11  416  	if (ret_val)
ab4056126813c8 Sasha Neftin 2018-10-11  417  		hw_dbg("Error configuring flow control\n");
ab4056126813c8 Sasha Neftin 2018-10-11  418  
ab4056126813c8 Sasha Neftin 2018-10-11  419  out:
4cbe66aa3a43a5 Sasha Neftin 2020-06-02  420  	/* Now that we are aware of our link settings, we can set the LTR
4cbe66aa3a43a5 Sasha Neftin 2020-06-02  421  	 * thresholds.
4cbe66aa3a43a5 Sasha Neftin 2020-06-02  422  	 */
4cbe66aa3a43a5 Sasha Neftin 2020-06-02  423  	ret_val = igc_set_ltr_i225(hw, link);
4cbe66aa3a43a5 Sasha Neftin 2020-06-02  424  
ab4056126813c8 Sasha Neftin 2018-10-11  425  	return ret_val;
ab4056126813c8 Sasha Neftin 2018-10-11  426  }
ab4056126813c8 Sasha Neftin 2018-10-11  427  

:::::: The code at line 373 was first introduced by commit
:::::: ab4056126813c889ee6c8fb24ca8f75b84c981ab igc: Add NVM support

:::::: TO: Sasha Neftin <sasha.neftin@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28803 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200608/1b2974d3/attachment-0001.bin>
