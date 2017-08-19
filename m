From: kbuild test robot <lkp@intel.com>
Date: Sun, 20 Aug 2017 06:10:47 +0800
Subject: [Intel-wired-lan] [PATCH net v2 2/2] net: ixgbe: Use new
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
In-Reply-To: <1502940316-13384-3-git-send-email-dingtianhong@huawei.com>
Message-ID: <201708200624.ZlXeBB75%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Ding,

[auto build test ERROR on net/master]

url:    https://github.com/0day-ci/linux/commits/Ding-Tianhong/Revert-commit-1a8b6d76dc5b-net-add-one-common-config/20170820-053530
config: i386-randconfig-x011-201734 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net//ethernet/intel/ixgbe/ixgbe_common.c: In function 'ixgbe_start_hw_gen2':
>> drivers/net//ethernet/intel/ixgbe/ixgbe_common.c:354:7: error: implicit declaration of function 'pcie_relaxed_ordering_enabled' [-Werror=implicit-function-declaration]
     if (!pcie_relaxed_ordering_enabled(adapter->pdev)) {
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net//ethernet/intel/ixgbe/ixgbe_82598.c: In function 'ixgbe_start_hw_82598':
>> drivers/net//ethernet/intel/ixgbe/ixgbe_82598.c:184:7: error: implicit declaration of function 'pcie_relaxed_ordering_enabled' [-Werror=implicit-function-declaration]
     if (!pcie_relaxed_ordering_enabled(adapter->pdev)) {
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pcie_relaxed_ordering_enabled +354 drivers/net//ethernet/intel/ixgbe/ixgbe_common.c

   331	
   332	/**
   333	 *  ixgbe_start_hw_gen2 - Init sequence for common device family
   334	 *  @hw: pointer to hw structure
   335	 *
   336	 * Performs the init sequence common to the second generation
   337	 * of 10 GbE devices.
   338	 * Devices in the second generation:
   339	 *     82599
   340	 *     X540
   341	 **/
   342	s32 ixgbe_start_hw_gen2(struct ixgbe_hw *hw)
   343	{
   344		u32 i;
   345		struct ixgbe_adapter *adapter = hw->back;
   346	
   347		/* Clear the rate limiters */
   348		for (i = 0; i < hw->mac.max_tx_queues; i++) {
   349			IXGBE_WRITE_REG(hw, IXGBE_RTTDQSEL, i);
   350			IXGBE_WRITE_REG(hw, IXGBE_RTTBCNRC, 0);
   351		}
   352		IXGBE_WRITE_FLUSH(hw);
   353	
 > 354		if (!pcie_relaxed_ordering_enabled(adapter->pdev)) {
   355			/* Disable relaxed ordering */
   356			for (i = 0; i < hw->mac.max_tx_queues; i++) {
   357				u32 regval;
   358	
   359				regval = IXGBE_READ_REG(hw, IXGBE_DCA_TXCTRL_82599(i));
   360				regval &= ~IXGBE_DCA_TXCTRL_DESC_WRO_EN;
   361				IXGBE_WRITE_REG(hw, IXGBE_DCA_TXCTRL_82599(i), regval);
   362			}
   363	
   364			for (i = 0; i < hw->mac.max_rx_queues; i++) {
   365				u32 regval;
   366	
   367				regval = IXGBE_READ_REG(hw, IXGBE_DCA_RXCTRL(i));
   368				regval &= ~(IXGBE_DCA_RXCTRL_DATA_WRO_EN |
   369					    IXGBE_DCA_RXCTRL_HEAD_WRO_EN);
   370				IXGBE_WRITE_REG(hw, IXGBE_DCA_RXCTRL(i), regval);
   371			}
   372		}
   373	
   374		return 0;
   375	}
   376	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30251 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170820/345fcddb/attachment-0001.bin>
