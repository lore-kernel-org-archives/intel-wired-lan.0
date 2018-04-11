From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 11 Apr 2018 20:55:43 +0000
Subject: [Intel-wired-lan] [PATCH v2] intel: Cleanup the
 copyright/license headers
In-Reply-To: <20180411182527.29395-1-jeffrey.t.kirsher@intel.com>
References: <20180411182527.29395-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A965816@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, April 11, 2018 11:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: richardcochran at gmail.com
> Subject: [Intel-wired-lan] [PATCH v2] intel: Cleanup the copyright/license
> headers
> 
> After many years of having a ~30 line copyright and license header to our
> source files, we are finally able to reduce that to one line with the
> advent of the SPDX identifier.
> 
> Also caught a few files missing the SPDX license identifier, so fixed
> them up.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v2: updated the license & copyright headers for igb_ptp.c,
>     ixgbe_ipsec.c/h based on feedback/permission from the copyright
>     owners of those files.
> 
> ---
>  drivers/net/ethernet/intel/e100.c                  | 28 +-------------------
>  drivers/net/ethernet/intel/e1000/Makefile          | 26 -------------------
>  drivers/net/ethernet/intel/e1000/e1000.h           | 29 +--------------------
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c   | 23 +----------------
>  drivers/net/ethernet/intel/e1000/e1000_hw.c        | 28 +-------------------
>  drivers/net/ethernet/intel/e1000/e1000_hw.h        | 28 +-------------------
>  drivers/net/ethernet/intel/e1000/e1000_main.c      | 28 +-------------------
>  drivers/net/ethernet/intel/e1000/e1000_osdep.h     | 29 +--------------------
>  drivers/net/ethernet/intel/e1000/e1000_param.c     | 28 +-------------------
>  drivers/net/ethernet/intel/e1000e/80003es2lan.c    | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/80003es2lan.h    | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/82571.c          | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/82571.h          | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/Makefile         | 27 +------------------
>  drivers/net/ethernet/intel/e1000e/defines.h        | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/e1000.h          | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/ethtool.c        | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/hw.h             | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/ich8lan.c        | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/ich8lan.h        | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/mac.c            | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/mac.h            | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/manage.c         | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/manage.h         | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/netdev.c         | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/nvm.c            | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/nvm.h            | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/param.c          | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/phy.c            | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/phy.h            | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/ptp.c            | 21 +--------------
>  drivers/net/ethernet/intel/e1000e/regs.h           | 21 +--------------
>  drivers/net/ethernet/intel/fm10k/Makefile          | 23 +----------------
>  drivers/net/ethernet/intel/fm10k/fm10k.h           | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_common.c    | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_common.h    | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c     | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c   | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c   | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_iov.c       | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c      | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.c       | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.h       | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c    | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c       | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c        | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.h        | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_tlv.c       | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_tlv.h       | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_type.h      | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c        | 20 +--------------
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.h        | 20 +--------------
>  drivers/net/ethernet/intel/i40e/Makefile           | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e.h             | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c      | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h      | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_alloc.h       | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_client.c      | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_client.h      | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c         | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_dcb.h         | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c      | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_devids.h      | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_diag.c        | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_diag.h        | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c         | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_hmc.h         | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c     | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h     | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c         | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h       | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c         | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_register.h    | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_status.h      | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_trace.h       | 23 +----------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_type.h        | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 26 +------------------
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/Makefile         | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c    | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.h    | 26 +------------------
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_alloc.h     | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_devids.h    | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_hmc.h       | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h   | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_osdep.h     | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_register.h  | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_status.h    | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_trace.h     | 23 +----------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40e_type.h      | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40evf.h         | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40evf_client.c  |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40evf_client.h  |  2 ++
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 26 +------------------
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 26 +------------------
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 26 +------------------
>  drivers/net/ethernet/intel/igb/Makefile            | 28 +-------------------
>  drivers/net/ethernet/intel/igb/e1000_82575.c       | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_82575.h       | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_defines.h     | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_hw.h          | 22 +---------------
>  drivers/net/ethernet/intel/igb/e1000_i210.c        | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_i210.h        | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_mac.c         | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_mac.h         | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_mbx.c         | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_mbx.h         | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_nvm.c         | 22 +---------------
>  drivers/net/ethernet/intel/igb/e1000_nvm.h         | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_phy.c         | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_phy.h         | 23 +----------------
>  drivers/net/ethernet/intel/igb/e1000_regs.h        | 23 +----------------
>  drivers/net/ethernet/intel/igb/igb.h               | 23 +----------------
>  drivers/net/ethernet/intel/igb/igb_ethtool.c       | 23 +----------------
>  drivers/net/ethernet/intel/igb/igb_hwmon.c         | 23 +----------------
>  drivers/net/ethernet/intel/igb/igb_main.c          | 23 +----------------
>  drivers/net/ethernet/intel/igb/igb_ptp.c           | 19 ++------------
>  drivers/net/ethernet/intel/igbvf/Makefile          | 28 +-------------------
>  drivers/net/ethernet/intel/igbvf/defines.h         | 26 +------------------
>  drivers/net/ethernet/intel/igbvf/ethtool.c         | 26 +------------------
>  drivers/net/ethernet/intel/igbvf/igbvf.h           | 26 +------------------
>  drivers/net/ethernet/intel/igbvf/mbx.c             | 26 +------------------
>  drivers/net/ethernet/intel/igbvf/mbx.h             | 26 +------------------
>  drivers/net/ethernet/intel/igbvf/netdev.c          | 26 +------------------
>  drivers/net/ethernet/intel/igbvf/regs.h            | 26 +------------------
>  drivers/net/ethernet/intel/igbvf/vf.c              | 26 +------------------
>  drivers/net/ethernet/intel/igbvf/vf.h              | 26 +------------------
>  drivers/net/ethernet/intel/ixgb/Makefile           | 27 -------------------
>  drivers/net/ethernet/intel/ixgb/ixgb.h             | 28 +-------------------
>  drivers/net/ethernet/intel/ixgb/ixgb_ee.c          | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgb/ixgb_ee.h          | 28 +-------------------
>  drivers/net/ethernet/intel/ixgb/ixgb_ethtool.c     | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgb/ixgb_hw.c          | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgb/ixgb_hw.h          | 28 +-------------------
>  drivers/net/ethernet/intel/ixgb/ixgb_ids.h         | 28 +-------------------
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c        | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgb/ixgb_osdep.h       | 28 +-------------------
>  drivers/net/ethernet/intel/ixgb/ixgb_param.c       | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/Makefile          | 29 +--------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h           | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h    | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c       | 30 ++--------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h       | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.h | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.c | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.h | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c    | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c   | 28 ++------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c      | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h      | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c     | 28 ++------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h     | 27 +------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_model.h     | 26 +------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       | 28 ++------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h     | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c     | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      | 29 ++-------------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h      | 24 +----------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      | 26 +++----------------
>  drivers/net/ethernet/intel/ixgbevf/Makefile        | 28 +-------------------
>  drivers/net/ethernet/intel/ixgbevf/defines.h       | 26 +------------------
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c       | 27 ++-----------------
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h       | 26 +------------------
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  | 27 ++-----------------
>  drivers/net/ethernet/intel/ixgbevf/mbx.c           | 27 ++-----------------
>  drivers/net/ethernet/intel/ixgbevf/mbx.h           | 26 +------------------
>  drivers/net/ethernet/intel/ixgbevf/regs.h          | 26 +------------------
>  drivers/net/ethernet/intel/ixgbevf/vf.c            | 27 ++-----------------
>  drivers/net/ethernet/intel/ixgbevf/vf.h            | 26 +------------------
>  195 files changed, 222 insertions(+), 4624 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


