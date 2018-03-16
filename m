From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 17 Mar 2018 06:40:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 44/59]
 drivers/net/ethernet/intel/ice/ice_ethtool.c:187:42-43: WARNING: Use
 ARRAY_SIZE
Message-ID: <201803170624.15qre8kt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ffc7c890104ab7b4e01727906958692692417a59
commit: df659ecc862b8344f9a6292dbaa91e701da6991c [44/59] ice: Add stats and ethtool support


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/ice/ice_ethtool.c:187:42-43: WARNING: Use ARRAY_SIZE

vim +187 drivers/net/ethernet/intel/ice/ice_ethtool.c

   175	
   176	static void
   177	ice_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
   178	{
   179		struct ice_netdev_priv *np = netdev_priv(netdev);
   180		struct ice_pf *pf = np->vsi->back;
   181		struct ice_hw *hw = &pf->hw;
   182		u32 *regs_buf = (u32 *)p;
   183		int i;
   184	
   185		regs->version = 1;
   186	
 > 187		for (i = 0; i < sizeof(ice_regs_dump_list) / sizeof(u32); ++i)
   188			regs_buf[i] = rd32(hw, ice_regs_dump_list[i]);
   189	}
   190	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
