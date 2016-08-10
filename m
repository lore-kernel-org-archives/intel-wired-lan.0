From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 11 Aug 2016 06:55:01 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 58/58]
 drivers/net/ethernet/intel/igb/igb_main.c:8457:20-24: ERROR: adapter is
 NULL but dereferenced.
Message-ID: <201608110659.Xm5kQeJz%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   2d927ed12252a811854a9545725ba46ebcdcfc4f
commit: 2d927ed12252a811854a9545725ba46ebcdcfc4f [58/58] igb: add function to set I210 transmit mode


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/igb/igb_main.c:8457:20-24: ERROR: adapter is NULL but dereferenced.

vim +8457 drivers/net/ethernet/intel/igb/igb_main.c

  8441	static void igb_setup_normal_mode(struct igb_adapter *adapter)
  8442	{
  8443		struct e1000_hw *hw = &adapter->hw;
  8444	
  8445		wr32(E1000_TXPBS, I210_TXPBSIZE_DEFAULT);
  8446		wr32(E1000_DTXMXPKT, E1000_DTXMXPKTSZ_DEFAULT);
  8447		wr32(E1000_TQAVCTRL, 0);
  8448	}
  8449	
  8450	static int igb_change_mode(struct igb_adapter *adapter, int request_mode)
  8451	{
  8452		struct net_device *netdev;
  8453		int err = 0;
  8454		int current_mode;
  8455	
  8456		if (!adapter) {
> 8457			dev_err(&adapter->pdev->dev, "map to unbound device!\n");
  8458			return -ENOENT;
  8459		}
  8460	
  8461		current_mode = adapter->qav_mode;
  8462	
  8463		if (request_mode == current_mode)
  8464			return 0;
  8465	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
