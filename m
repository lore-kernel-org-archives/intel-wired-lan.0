From: kbuild test robot <lkp@intel.com>
Date: Tue, 12 Jun 2018 07:10:23 +0800
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 5/7] net: Add
 generic ndo_select_queue functions
In-Reply-To: <20180611174119.41352.28975.stgit@ahduyck-green-test.jf.intel.com>
References: <20180611174119.41352.28975.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <201806120507.3D5zIr3A%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alexander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net-next/master]
[also build test ERROR on next-20180608]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Add-support-for-L2-Fwd-Offload-w-o-ndo_select_queue/20180612-015220
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/net//ethernet/ti/netcp_core.c:1968:22: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .ndo_select_queue = dev_pick_tx_zero,
                         ^~~~~~~~~~~~~~~~
   drivers/net//ethernet/ti/netcp_core.c:1968:22: note: (near initialization for 'netcp_netdev_ops.ndo_select_queue')
   cc1: some warnings being treated as errors

vim +1968 drivers/net//ethernet/ti/netcp_core.c

  1955	
  1956	static const struct net_device_ops netcp_netdev_ops = {
  1957		.ndo_open		= netcp_ndo_open,
  1958		.ndo_stop		= netcp_ndo_stop,
  1959		.ndo_start_xmit		= netcp_ndo_start_xmit,
  1960		.ndo_set_rx_mode	= netcp_set_rx_mode,
  1961		.ndo_do_ioctl           = netcp_ndo_ioctl,
  1962		.ndo_get_stats64        = netcp_get_stats,
  1963		.ndo_set_mac_address	= eth_mac_addr,
  1964		.ndo_validate_addr	= eth_validate_addr,
  1965		.ndo_vlan_rx_add_vid	= netcp_rx_add_vid,
  1966		.ndo_vlan_rx_kill_vid	= netcp_rx_kill_vid,
  1967		.ndo_tx_timeout		= netcp_ndo_tx_timeout,
> 1968		.ndo_select_queue	= dev_pick_tx_zero,
  1969		.ndo_setup_tc		= netcp_setup_tc,
  1970	};
  1971	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65910 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180612/086fbe7a/attachment-0001.bin>
