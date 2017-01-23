From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 23 Jan 2017 10:11:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 62/82]
 drivers/net/ethernet/marvell/skge.c:323:2: error: implicit declaration of
 function 'ethtool_convert_legacy_u32_to_link_mode'
Message-ID: <201701231009.8W0W3EdK%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   b5c90f3b454d813f16a3c4abe4df9ea0b60e7947
commit: b3a8d73a299c5fa60b7acf61cc1079b1f1c0893c [62/82] ethtool: stop the line wrapping madness
config: x86_64-allyesdebian (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout b3a8d73a299c5fa60b7acf61cc1079b1f1c0893c
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/marvell/skge.c: In function 'skge_get_link_ksettings':
>> drivers/net/ethernet/marvell/skge.c:323:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/skge.c: In function 'skge_set_link_ksettings':
>> drivers/net/ethernet/marvell/skge.c:340:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
     ethtool_convert_link_mode_to_legacy_u32(&advertising,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/marvell/sky2.c: In function 'sky2_get_link_ksettings':
>> drivers/net/ethernet/marvell/sky2.c:3616:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/sky2.c: In function 'sky2_set_link_ksettings':
>> drivers/net/ethernet/marvell/sky2.c:3632:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
     ethtool_convert_link_mode_to_legacy_u32(&new_advertising,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ethtool_convert_legacy_u32_to_link_mode +323 drivers/net/ethernet/marvell/skge.c

0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  317  
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  318  	advertising = skge->advertising;
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  319  	cmd->base.autoneg = skge->autoneg;
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  320  	cmd->base.speed = skge->speed;
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  321  	cmd->base.duplex = skge->duplex;
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  322  
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16 @323  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  324  						supported);
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  325  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  326  						advertising);
baef58b1 drivers/net/skge.c                  Stephen Hemminger 2005-05-12  327  
baef58b1 drivers/net/skge.c                  Stephen Hemminger 2005-05-12  328  	return 0;
baef58b1 drivers/net/skge.c                  Stephen Hemminger 2005-05-12  329  }
baef58b1 drivers/net/skge.c                  Stephen Hemminger 2005-05-12  330  
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  331  static int skge_set_link_ksettings(struct net_device *dev,
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  332  				   const struct ethtool_link_ksettings *cmd)
baef58b1 drivers/net/skge.c                  Stephen Hemminger 2005-05-12  333  {
baef58b1 drivers/net/skge.c                  Stephen Hemminger 2005-05-12  334  	struct skge_port *skge = netdev_priv(dev);
baef58b1 drivers/net/skge.c                  Stephen Hemminger 2005-05-12  335  	const struct skge_hw *hw = skge->hw;
31b619c5 drivers/net/skge.c                  Stephen Hemminger 2005-06-27  336  	u32 supported = skge_supported_modes(hw);
9ac1353f drivers/net/skge.c                  Xiaoming.Zhang    2008-09-25  337  	int err = 0;
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  338  	u32 advertising;
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  339  
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16 @340  	ethtool_convert_link_mode_to_legacy_u32(&advertising,
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  341  						cmd->link_modes.advertising);
baef58b1 drivers/net/skge.c                  Stephen Hemminger 2005-05-12  342  
0f826385 drivers/net/ethernet/marvell/skge.c Philippe Reynes   2017-01-16  343  	if (cmd->base.autoneg == AUTONEG_ENABLE) {

:::::: The code at line 323 was first introduced by commit
:::::: 0f826385a6fa699d31fc1f835fb9ef9a724b523e net: marvell: skge: use new api ethtool_{get|set}_link_ksettings

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38056 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170123/76af47df/attachment-0001.bin>
