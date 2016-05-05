From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 5 May 2016 11:10:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 28/49]
 drivers/net/ethernet/intel/ixgbevf/vf.c:969:42: error: redefinition of
 'ixgbevf_hv_mac_ops'
Message-ID: <201605051156.EblFSvp6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   fbc47542b53d4d5f43b5fc22f0ddc348c20d1ef8
commit: 6e91188892aa40fe7d52df75c934cae7a02a4ee0 [28/49] intel: ixgbevf: Support Windows hosts (Hyper-V)
config: x86_64-rhel (attached as .config)
compiler: gcc-4.9 (Debian 4.9.3-14) 4.9.3
reproduce:
        git checkout 6e91188892aa40fe7d52df75c934cae7a02a4ee0
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the jkirsher-next-queue/dev-queue HEAD fbc47542b53d4d5f43b5fc22f0ddc348c20d1ef8 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ixgbevf/vf.c:969:42: error: redefinition of 'ixgbevf_hv_mac_ops'
    static const struct ixgbe_mac_operations ixgbevf_hv_mac_ops = {
                                             ^
   drivers/net/ethernet/intel/ixgbevf/vf.c:952:42: note: previous definition of 'ixgbevf_hv_mac_ops' was here
    static const struct ixgbe_mac_operations ixgbevf_hv_mac_ops = {
                                             ^

vim +/ixgbevf_hv_mac_ops +969 drivers/net/ethernet/intel/ixgbevf/vf.c

   963		.update_xcast_mode	= ixgbevf_hv_update_xcast_mode,
   964		.set_uc_addr		= ixgbevf_hv_set_uc_addr_vf,
   965		.set_vfta		= ixgbevf_hv_set_vfta_vf,
   966		.set_rlpml		= ixgbevf_hv_set_rlpml_vf,
   967	};
   968	
 > 969	static const struct ixgbe_mac_operations ixgbevf_hv_mac_ops = {
   970		.init_hw		= ixgbevf_init_hw_vf,
   971		.reset_hw		= ixgbevf_hv_reset_hw_vf,
   972		.start_hw		= ixgbevf_start_hw_vf,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36453 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160505/f1d5ac59/attachment-0001.obj>
