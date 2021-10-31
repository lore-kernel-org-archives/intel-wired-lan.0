From: kernel test robot <lkp@intel.com>
Date: Sun, 31 Oct 2021 21:19:06 +0800
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix handling of vlan
 strip virtual channel messages
In-Reply-To: <20211028104114.71879-1-michal.maloszewski@intel.com>
References: <20211028104114.71879-1-michal.maloszewski@intel.com>
Message-ID: <202110312151.U7sLbJej-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Michal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[also build test ERROR on v5.15-rc7 next-20211029]
[cannot apply to net/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michal-Maloszewski/iavf-Fix-handling-of-vlan-strip-virtual-channel-messages/20211028-190947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
config: x86_64-randconfig-a011-20211031 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d321548c3ce987f4f21350ba1c81fdb5d4354224)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a899b5944ecc501aa3c6075c2edfe0ec702802f7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michal-Maloszewski/iavf-Fix-handling-of-vlan-strip-virtual-channel-messages/20211028-190947
        git checkout a899b5944ecc501aa3c6075c2edfe0ec702802f7
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1471:30: error: use of undeclared identifier 'NETIF_F_HW_VLAN_RX'
                           NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_RX;
                                                     ^
   drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1474:32: error: use of undeclared identifier 'NETIF_F_HW_VLAN_RX'
                           ~NETIF_F_HW_VLAN_CTAG_RX & ~NETIF_F_HW_VLAN_RX;
                                                       ^
   2 errors generated.


vim +/NETIF_F_HW_VLAN_RX +1471 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

  1458	
  1459	/**
  1460	 * iavf_netdev_features_vlan_strip_set - update vlan strip status
  1461	 * @netdev: ptr to netdev being adjusted
  1462	 * @enable: enable or disable vlan strip
  1463	 *
  1464	 * Helper function to change vlan strip status in netdev->features.
  1465	 */
  1466	static void iavf_netdev_features_vlan_strip_set(struct net_device *netdev,
  1467							const bool enable)
  1468	{
  1469		if (enable)
  1470			netdev->features |=
> 1471				NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_RX;
  1472		else
  1473			netdev->features &=
  1474				~NETIF_F_HW_VLAN_CTAG_RX & ~NETIF_F_HW_VLAN_RX;
  1475	}
  1476	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34630 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211031/87d1b25c/attachment-0001.bin>
