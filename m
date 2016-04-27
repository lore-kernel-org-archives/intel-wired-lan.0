From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 28 Apr 2016 05:17:50 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 74/74]
 drivers/net/ethernet/intel/ixgbevf/vf.c:966:23: error: initialization from
 incompatible pointer type
Message-ID: <201604280549.vRL13PUc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   abf735cd5344a7cd86e24fa5730bacdfef701e24
commit: abf735cd5344a7cd86e24fa5730bacdfef701e24 [74/74] ixgbevf: Remove unused parameter
config: powerpc-allyesconfig (attached as .config)
compiler: 
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout abf735cd5344a7cd86e24fa5730bacdfef701e24
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ixgbevf/vf.c:966:23: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .update_xcast_mode = ixgbevf_hv_update_xcast_mode,
                          ^
   drivers/net/ethernet/intel/ixgbevf/vf.c:966:23: note: (near initialization for 'ixgbevf_hv_mac_ops.update_xcast_mode')
   cc1: some warnings being treated as errors

vim +966 drivers/net/ethernet/intel/ixgbevf/vf.c

37573d78 KY Srinivasan   2016-04-27  960  	.stop_adapter		= ixgbevf_stop_hw_vf,
37573d78 KY Srinivasan   2016-04-27  961  	.setup_link		= ixgbevf_setup_mac_link_vf,
37573d78 KY Srinivasan   2016-04-27  962  	.check_link		= ixgbevf_hv_check_mac_link_vf,
5669e3b2 Alexander Duyck 2016-04-27  963  	.negotiate_api_version	= ixgbevf_hv_negotiate_api_version_vf,
37573d78 KY Srinivasan   2016-04-27  964  	.set_rar		= ixgbevf_hv_set_rar_vf,
37573d78 KY Srinivasan   2016-04-27  965  	.update_mc_addr_list	= ixgbevf_hv_update_mc_addr_list_vf,
37573d78 KY Srinivasan   2016-04-27 @966  	.update_xcast_mode	= ixgbevf_hv_update_xcast_mode,
37573d78 KY Srinivasan   2016-04-27  967  	.set_uc_addr		= ixgbevf_hv_set_uc_addr_vf,
37573d78 KY Srinivasan   2016-04-27  968  	.set_vfta		= ixgbevf_hv_set_vfta_vf,
5669e3b2 Alexander Duyck 2016-04-27  969  	.set_rlpml		= ixgbevf_hv_set_rlpml_vf,

:::::: The code at line 966 was first introduced by commit
:::::: 37573d789b32c0740f68815ea703b50cecb2e39a intel: ixgbevf: Support Windows hosts (Hyper-V)

:::::: TO: KY Srinivasan <kys@microsoft.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 48670 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160428/015561f5/attachment-0001.obj>
