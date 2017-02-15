From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 15 Feb 2017 09:37:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 88/88]
 drivers/net/ethernet/amd/pcnet32.c:753:3: error: implicit declaration of
 function 'ethtool_convert_legacy_u32_to_link_mode'
Message-ID: <201702150958.Guwuta0X%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   39877a07fd355416a6f44dfe20832dfdd4b8bdbf
commit: 39877a07fd355416a6f44dfe20832dfdd4b8bdbf [88/88] ethtool: stop the line wrapping madness
config: x86_64-allyesdebian (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 39877a07fd355416a6f44dfe20832dfdd4b8bdbf
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/amd/pcnet32.c: In function 'pcnet32_get_link_ksettings':
>> drivers/net/ethernet/amd/pcnet32.c:753:3: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
      ethtool_convert_legacy_u32_to_link_mode(
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ethtool_convert_legacy_u32_to_link_mode +753 drivers/net/ethernet/amd/pcnet32.c

2be4cb97 drivers/net/ethernet/amd/pcnet32.c Ondrej Zary    2017-02-13  747  		} else {
2be4cb97 drivers/net/ethernet/amd/pcnet32.c Ondrej Zary    2017-02-13  748  			cmd->base.autoneg = AUTONEG_DISABLE;
2be4cb97 drivers/net/ethernet/amd/pcnet32.c Ondrej Zary    2017-02-13  749  			cmd->base.port = lp->port_tp ? PORT_TP : PORT_AUI;
2be4cb97 drivers/net/ethernet/amd/pcnet32.c Ondrej Zary    2017-02-13  750  		}
2be4cb97 drivers/net/ethernet/amd/pcnet32.c Ondrej Zary    2017-02-13  751  		cmd->base.duplex = lp->fdx ? DUPLEX_FULL : DUPLEX_HALF;
2be4cb97 drivers/net/ethernet/amd/pcnet32.c Ondrej Zary    2017-02-13  752  		cmd->base.speed = SPEED_10;
2be4cb97 drivers/net/ethernet/amd/pcnet32.c Ondrej Zary    2017-02-13 @753  		ethtool_convert_legacy_u32_to_link_mode(
2be4cb97 drivers/net/ethernet/amd/pcnet32.c Ondrej Zary    2017-02-13  754  						cmd->link_modes.supported,
2be4cb97 drivers/net/ethernet/amd/pcnet32.c Ondrej Zary    2017-02-13  755  						SUPPORTED_TP | SUPPORTED_AUI);
^1da177e drivers/net/pcnet32.c              Linus Torvalds 2005-04-16  756  		r = 0;

:::::: The code at line 753 was first introduced by commit
:::::: 2be4cb973f0cfaf051224fa5bc969c71c9fc3d5b pcnet32: fix BNC/AUI port on AM79C970A

:::::: TO: Ondrej Zary <linux@rainbow-software.org>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38088 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170215/5434c9ad/attachment-0001.bin>
