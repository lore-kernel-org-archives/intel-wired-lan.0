From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 4 Jan 2017 11:48:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 96/97]
 drivers/net/mdio.c:496:2: error: implicit declaration of function
 'ethtool_convert_legacy_u32_to_link_mode'
Message-ID: <201701041153.Avne0KVy%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   6b07d327da8258671ea0bff784d884c4d30949d9
commit: 565e36240fcde4e513e9cec26ee9e8e1ba53ca9e [96/97] ethtool: stop the line wrapping madness
config: x86_64-lkp (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 565e36240fcde4e513e9cec26ee9e8e1ba53ca9e
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/mdio.c: In function 'mdio45_ethtool_ksettings_get_npage':
>> drivers/net/mdio.c:496:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/dec/tulip/uli526x.c: In function 'ULi_ethtool_get_link_ksettings':
>> drivers/net/ethernet/dec/tulip/uli526x.c:948:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/dlink/dl2k.c: In function 'rio_get_link_ksettings':
>> drivers/net/ethernet/dlink/dl2k.c:1296:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ethtool_convert_legacy_u32_to_link_mode +496 drivers/net/mdio.c

8e4881aa Philippe Reynes 2017-01-01  490  		cmd->base.duplex = (reg & MDIO_CTRL1_FULLDPLX ||
8e4881aa Philippe Reynes 2017-01-01  491  				    speed == SPEED_10000);
8e4881aa Philippe Reynes 2017-01-01  492  	}
8e4881aa Philippe Reynes 2017-01-01  493  
8e4881aa Philippe Reynes 2017-01-01  494  	cmd->base.speed = speed;
8e4881aa Philippe Reynes 2017-01-01  495  
8e4881aa Philippe Reynes 2017-01-01 @496  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
8e4881aa Philippe Reynes 2017-01-01  497  						supported);
8e4881aa Philippe Reynes 2017-01-01  498  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
8e4881aa Philippe Reynes 2017-01-01  499  						advertising);

:::::: The code at line 496 was first introduced by commit
:::::: 8e4881aa1d5d2f9c7ebfd0fe5e138f0cc345832c net: mdio: add mdio45_ethtool_ksettings_get

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24666 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170104/c44c3050/attachment-0001.bin>
