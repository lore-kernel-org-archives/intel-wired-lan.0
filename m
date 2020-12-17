From: kernel test robot <lkp@intel.com>
Date: Thu, 17 Dec 2020 18:57:13 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 35/111]
 drivers/net/ethernet/intel/i40e/i40e_dcb.c:1639:6: warning: 'mfs_max' is
 used uninitialized in this function
Message-ID: <202012171805.EEcYU4af-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   c929b995e9037188f8ebd7f2f8df8b60da940e0d
commit: 0345779cc859e3a8f2f727b24dfbf2a07f0683b9 [35/111] i40e: Add hardware configuration for software based DCB
config: arc-randconfig-r036-20201217 (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=0345779cc859e3a8f2f727b24dfbf2a07f0683b9
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 0345779cc859e3a8f2f727b24dfbf2a07f0683b9
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_dcb.c: In function 'i40e_dcb_hw_calculate_pool_sizes':
>> drivers/net/ethernet/intel/i40e/i40e_dcb.c:1639:6: warning: 'mfs_max' is used uninitialized in this function [-Wuninitialized]
    1639 |  u32 mfs_max;
         |      ^~~~~~~


vim +/mfs_max +1639 drivers/net/ethernet/intel/i40e/i40e_dcb.c

  1615	
  1616	/**
  1617	 * i40e_dcb_hw_calculate_pool_sizes - configure dcb pool sizes
  1618	 * @hw: pointer to the hw struct
  1619	 * @num_ports: Number of available ports on the device
  1620	 * @eee_enabled: EEE enabled for the given port
  1621	 * @pfc_en: Bit map of PFC enabled traffic classes
  1622	 * @mfs_tc: Array of max frame size for each traffic class
  1623	 * @pb_cfg: pointer to packet buffer configuration
  1624	 *
  1625	 * Calculate the shared and dedicated per TC pool sizes,
  1626	 * watermarks and threshold values.
  1627	 **/
  1628	void i40e_dcb_hw_calculate_pool_sizes(struct i40e_hw *hw,
  1629					      u8 num_ports, bool eee_enabled,
  1630					      u8 pfc_en, u32 *mfs_tc,
  1631					      struct i40e_rx_pb_config *pb_cfg)
  1632	{
  1633		u32 pool_size[I40E_MAX_TRAFFIC_CLASS];
  1634		u32 high_wm[I40E_MAX_TRAFFIC_CLASS];
  1635		u32 low_wm[I40E_MAX_TRAFFIC_CLASS];
  1636		u32 total_pool_size = 0;
  1637		int shared_pool_size; /* Need signed variable */
  1638		u32 port_pb_size;
> 1639		u32 mfs_max;
  1640		u32 pcirtt;
  1641		u8 i;
  1642	
  1643		/* Get the MFS(max) for the port */
  1644		for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
  1645			if (mfs_tc[i] > mfs_max)
  1646				mfs_max = mfs_tc[i];
  1647		}
  1648	
  1649		pcirtt = I40E_BT2B(I40E_PCIRTT_LINK_SPEED_10G);
  1650	
  1651		/* Calculate effective Rx PB size per port */
  1652		port_pb_size = I40E_DEVICE_RPB_SIZE / num_ports;
  1653		if (eee_enabled)
  1654			port_pb_size -= I40E_BT2B(I40E_EEE_TX_LPI_EXIT_TIME);
  1655		port_pb_size -= mfs_max;
  1656	
  1657		/* Step 1 Calculating tc pool/shared pool sizes and watermarks */
  1658		for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
  1659			if (pfc_en & BIT(i)) {
  1660				low_wm[i] = (I40E_DCB_WATERMARK_START_FACTOR *
  1661					     mfs_tc[i]) + pcirtt;
  1662				high_wm[i] = low_wm[i];
  1663				high_wm[i] += ((mfs_max > I40E_MAX_FRAME_SIZE)
  1664						? mfs_max : I40E_MAX_FRAME_SIZE);
  1665				pool_size[i] = high_wm[i];
  1666				pool_size[i] += I40E_BT2B(I40E_STD_DV_TC(mfs_max,
  1667									mfs_tc[i]));
  1668			} else {
  1669				low_wm[i] = 0;
  1670				pool_size[i] = (I40E_DCB_WATERMARK_START_FACTOR *
  1671						mfs_tc[i]) + pcirtt;
  1672				high_wm[i] = pool_size[i];
  1673			}
  1674			total_pool_size += pool_size[i];
  1675		}
  1676	
  1677		shared_pool_size = port_pb_size - total_pool_size;
  1678		if (shared_pool_size > 0) {
  1679			pb_cfg->shared_pool_size = shared_pool_size;
  1680			pb_cfg->shared_pool_high_wm = shared_pool_size;
  1681			pb_cfg->shared_pool_low_wm = 0;
  1682			for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
  1683				pb_cfg->shared_pool_low_thresh[i] = 0;
  1684				pb_cfg->shared_pool_high_thresh[i] = shared_pool_size;
  1685				pb_cfg->tc_pool_size[i] = pool_size[i];
  1686				pb_cfg->tc_pool_high_wm[i] = high_wm[i];
  1687				pb_cfg->tc_pool_low_wm[i] = low_wm[i];
  1688			}
  1689	
  1690		} else {
  1691			i40e_debug(hw, I40E_DEBUG_DCB,
  1692				   "The shared pool size for the port is negative %d.\n",
  1693				   shared_pool_size);
  1694		}
  1695	}
  1696	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26678 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201217/0089ee75/attachment-0001.bin>
