From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 23 Jan 2017 11:20:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 62/82]
 drivers/net/ethernet/ibm/ibmveth.c:747:2: error: implicit declaration of
 function 'ethtool_convert_legacy_u32_to_link_mode'
Message-ID: <201701231155.8BvhhDsa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   b5c90f3b454d813f16a3c4abe4df9ea0b60e7947
commit: b3a8d73a299c5fa60b7acf61cc1079b1f1c0893c [62/82] ethtool: stop the line wrapping madness
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout b3a8d73a299c5fa60b7acf61cc1079b1f1c0893c
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/ibm/ibmveth.c: In function 'netdev_get_link_ksettings':
>> drivers/net/ethernet/ibm/ibmveth.c:747:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/ibm/ehea/ehea_ethtool.c: In function 'ehea_get_link_ksettings':
>> drivers/net/ethernet/ibm/ehea/ehea_ethtool.c:90:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ethtool_convert_legacy_u32_to_link_mode +747 drivers/net/ethernet/ibm/ibmveth.c

9ce8c2df Philippe Reynes 2017-01-07  741  	cmd->base.speed = SPEED_1000;
9ce8c2df Philippe Reynes 2017-01-07  742  	cmd->base.duplex = DUPLEX_FULL;
9ce8c2df Philippe Reynes 2017-01-07  743  	cmd->base.port = PORT_FIBRE;
9ce8c2df Philippe Reynes 2017-01-07  744  	cmd->base.phy_address = 0;
9ce8c2df Philippe Reynes 2017-01-07  745  	cmd->base.autoneg = AUTONEG_ENABLE;
9ce8c2df Philippe Reynes 2017-01-07  746  
9ce8c2df Philippe Reynes 2017-01-07 @747  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
9ce8c2df Philippe Reynes 2017-01-07  748  						supported);
9ce8c2df Philippe Reynes 2017-01-07  749  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
9ce8c2df Philippe Reynes 2017-01-07  750  						advertising);

:::::: The code at line 747 was first introduced by commit
:::::: 9ce8c2dfceaec82e3cde57934b6cc69d24c42e95 net: ibm: ibmveth: use new api ethtool_{get|set}_link_ksettings

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 22510 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170123/ecd616f1/attachment-0001.bin>
