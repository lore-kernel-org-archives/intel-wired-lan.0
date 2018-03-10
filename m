From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 10 Mar 2018 00:40:24 +0000
Subject: [Intel-wired-lan] [PATCH v2] intel: add SPDX identifiers to all
 the Intel drivers
In-Reply-To: <20180228231411.13304-1-jeffrey.t.kirsher@intel.com>
References: <20180228231411.13304-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C8019D0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, February 28, 2018 3:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] intel: add SPDX identifiers to all the
> Intel drivers
> 
> Add the SPDX identifiers to all the Intel wired LAN driver files, as
> outlined in Documentation/process/license-rules.rst.
> 
> v2: Since "GPL-2.0" and "GPL-2.0+" is deprecated, updated the patch to
>     use "GPL-2.0-only" and "GPL-2.0-or-later" respectively.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/e100.c                   | 1 +
>  drivers/net/ethernet/intel/e1000/Makefile           | 1 +
>  drivers/net/ethernet/intel/e1000/e1000.h            | 1 +
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c    | 1 +
>  drivers/net/ethernet/intel/e1000/e1000_hw.c         | 1 +
>  drivers/net/ethernet/intel/e1000/e1000_hw.h         | 1 +
>  drivers/net/ethernet/intel/e1000/e1000_main.c       | 1 +
>  drivers/net/ethernet/intel/e1000/e1000_osdep.h      | 1 +
>  drivers/net/ethernet/intel/e1000/e1000_param.c      | 1 +
>  drivers/net/ethernet/intel/e1000e/80003es2lan.c     | 1 +
>  drivers/net/ethernet/intel/e1000e/80003es2lan.h     | 1 +
>  drivers/net/ethernet/intel/e1000e/82571.c           | 1 +
>  drivers/net/ethernet/intel/e1000e/82571.h           | 1 +
>  drivers/net/ethernet/intel/e1000e/Makefile          | 1 +
>  drivers/net/ethernet/intel/e1000e/defines.h         | 1 +
>  drivers/net/ethernet/intel/e1000e/e1000.h           | 1 +
>  drivers/net/ethernet/intel/e1000e/ethtool.c         | 1 +
>  drivers/net/ethernet/intel/e1000e/hw.h              | 1 +
>  drivers/net/ethernet/intel/e1000e/ich8lan.c         | 1 +
>  drivers/net/ethernet/intel/e1000e/ich8lan.h         | 1 +
>  drivers/net/ethernet/intel/e1000e/mac.c             | 1 +
>  drivers/net/ethernet/intel/e1000e/mac.h             | 1 +
>  drivers/net/ethernet/intel/e1000e/manage.c          | 1 +
>  drivers/net/ethernet/intel/e1000e/manage.h          | 1 +
>  drivers/net/ethernet/intel/e1000e/netdev.c          | 1 +
>  drivers/net/ethernet/intel/e1000e/nvm.c             | 1 +
>  drivers/net/ethernet/intel/e1000e/nvm.h             | 1 +
>  drivers/net/ethernet/intel/e1000e/param.c           | 1 +
>  drivers/net/ethernet/intel/e1000e/phy.c             | 1 +
>  drivers/net/ethernet/intel/e1000e/phy.h             | 1 +
>  drivers/net/ethernet/intel/e1000e/ptp.c             | 1 +
>  drivers/net/ethernet/intel/e1000e/regs.h            | 1 +
>  drivers/net/ethernet/intel/fm10k/Makefile           | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k.h            | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_common.c     | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_common.h     | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_dcbnl.c      | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c    | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c    | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_iov.c        | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c       | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.c        | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_mbx.h        | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c     | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c        | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c         | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.h         | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_tlv.c        | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_tlv.h        | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_type.h       | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c         | 1 +
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.h         | 1 +
>  drivers/net/ethernet/intel/i40e/Makefile            | 1 +
>  drivers/net/ethernet/intel/i40e/i40e.h              | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c       | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h       | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_alloc.h        | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_client.c       | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_client.h       | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_common.c       | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c          | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_dcb.h          | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c       | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_devids.h       | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_diag.c         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_diag.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_hmc.c          | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_hmc.h          | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.h      | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c          | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h        | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h    | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c          | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_register.h     | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_status.h       | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_trace.h        | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c  | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h  | 1 +
>  drivers/net/ethernet/intel/i40evf/Makefile          | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.h     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_alloc.h      | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_common.c     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_devids.h     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_hmc.h        | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_lan_hmc.h    | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_osdep.h      | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h  | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_register.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_status.h     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_trace.h      | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c       | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h       | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h       | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf.h          | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c  | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c | 1 +
>  drivers/net/ethernet/intel/igb/Makefile             | 1 +
>  drivers/net/ethernet/intel/igb/e1000_82575.c        | 1 +
>  drivers/net/ethernet/intel/igb/e1000_82575.h        | 1 +
>  drivers/net/ethernet/intel/igb/e1000_defines.h      | 1 +
>  drivers/net/ethernet/intel/igb/e1000_hw.h           | 1 +
>  drivers/net/ethernet/intel/igb/e1000_i210.c         | 1 +
>  drivers/net/ethernet/intel/igb/e1000_i210.h         | 1 +
>  drivers/net/ethernet/intel/igb/e1000_mac.c          | 1 +
>  drivers/net/ethernet/intel/igb/e1000_mac.h          | 1 +
>  drivers/net/ethernet/intel/igb/e1000_mbx.c          | 1 +
>  drivers/net/ethernet/intel/igb/e1000_mbx.h          | 1 +
>  drivers/net/ethernet/intel/igb/e1000_nvm.c          | 1 +
>  drivers/net/ethernet/intel/igb/e1000_nvm.h          | 1 +
>  drivers/net/ethernet/intel/igb/e1000_phy.c          | 1 +
>  drivers/net/ethernet/intel/igb/e1000_phy.h          | 1 +
>  drivers/net/ethernet/intel/igb/e1000_regs.h         | 1 +
>  drivers/net/ethernet/intel/igb/igb.h                | 1 +
>  drivers/net/ethernet/intel/igb/igb_ethtool.c        | 1 +
>  drivers/net/ethernet/intel/igb/igb_hwmon.c          | 1 +
>  drivers/net/ethernet/intel/igb/igb_main.c           | 1 +
>  drivers/net/ethernet/intel/igb/igb_ptp.c            | 1 +
>  drivers/net/ethernet/intel/igbvf/Makefile           | 1 +
>  drivers/net/ethernet/intel/igbvf/defines.h          | 1 +
>  drivers/net/ethernet/intel/igbvf/ethtool.c          | 1 +
>  drivers/net/ethernet/intel/igbvf/igbvf.h            | 1 +
>  drivers/net/ethernet/intel/igbvf/mbx.c              | 1 +
>  drivers/net/ethernet/intel/igbvf/mbx.h              | 1 +
>  drivers/net/ethernet/intel/igbvf/netdev.c           | 1 +
>  drivers/net/ethernet/intel/igbvf/regs.h             | 1 +
>  drivers/net/ethernet/intel/igbvf/vf.c               | 1 +
>  drivers/net/ethernet/intel/igbvf/vf.h               | 1 +
>  drivers/net/ethernet/intel/ixgb/Makefile            | 1 +
>  drivers/net/ethernet/intel/ixgb/ixgb.h              | 1 +
>  drivers/net/ethernet/intel/ixgb/ixgb_ee.h           | 1 +
>  drivers/net/ethernet/intel/ixgb/ixgb_hw.h           | 1 +
>  drivers/net/ethernet/intel/ixgb/ixgb_ids.h          | 1 +
>  drivers/net/ethernet/intel/ixgb/ixgb_osdep.h        | 1 +
>  drivers/net/ethernet/intel/ixgbe/Makefile           | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h            | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c      | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c      | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c     | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h     | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.h        | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.c  | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82598.h  | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_82599.h  | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.h       | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h      | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h        | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_model.h      | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h        | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h      | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h       | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h       | 1 +
>  drivers/net/ethernet/intel/ixgbevf/Makefile         | 1 +
>  drivers/net/ethernet/intel/ixgbevf/defines.h        | 1 +
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h        | 1 +
>  drivers/net/ethernet/intel/ixgbevf/mbx.h            | 1 +
>  drivers/net/ethernet/intel/ixgbevf/regs.h           | 1 +
>  drivers/net/ethernet/intel/ixgbevf/vf.h             | 1 +
>  168 files changed, 168 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
