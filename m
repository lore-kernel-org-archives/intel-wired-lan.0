From: kbuild test robot <lkp@intel.com>
Date: Tue, 10 Jan 2017 16:37:45 +0800
Subject: [Intel-wired-lan] [next-queue v3 PATCH 6/7] i40e: Add support
 for exposing VF port statistics via VFPR netdev on the host.
In-Reply-To: <1484009990-3018-7-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <201701101611.9eGMCKsi%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sridhar,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v4.10-rc3 next-20170110]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sridhar-Samudrala/i40e-Introduce-devlink-interface/20170110-140906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1163:28: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .ndo_get_stats64        = i40e_vfpr_netdev_get_stats64,
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1163:28: note: (near initialization for 'i40e_vfpr_netdev_ops.ndo_get_stats64')
   cc1: some warnings being treated as errors

vim +1163 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

  1157	}
  1158	
  1159	static const struct net_device_ops i40e_vfpr_netdev_ops = {
  1160		.ndo_open		= i40e_vfpr_netdev_open,
  1161		.ndo_stop		= i40e_vfpr_netdev_stop,
  1162		.ndo_start_xmit         = i40e_vfpr_netdev_start_xmit,
> 1163		.ndo_get_stats64        = i40e_vfpr_netdev_get_stats64,
  1164		.ndo_has_offload_stats  = i40e_vfpr_netdev_has_offload_stats,
  1165		.ndo_get_offload_stats  = i40e_vfpr_netdev_get_offload_stats,
  1166	};

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38277 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170110/690bded5/attachment-0001.bin>
