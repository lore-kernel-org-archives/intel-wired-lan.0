From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 29 Sep 2020 22:25:09 +0200
Subject: [Intel-wired-lan] [patch V2 00/36] net: in_interrupt() cleanup and
 fixes
Message-ID: <20200929202509.673358734@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Folks,

in the discussion about preempt count consistency accross kernel configurations:

  https://lore.kernel.org/r/20200914204209.256266093 at linutronix.de/

Linus clearly requested that code in drivers and libraries which changes
behaviour based on execution context should either be split up so that
e.g. task context invocations and BH invocations have different interfaces
or if that's not possible the context information has to be provided by the
caller which knows in which context it is executing.

This includes conditional locking, allocation mode (GFP_*) decisions and
avoidance of code paths which might sleep.

In the long run, usage of 'preemptible, in_*irq etc.' should be banned from
driver code completely.

This is the second version of the first batch of related changes. V1 can be
found here:

     https://lore.kernel.org/r/20200927194846.045411263 at linutronix.de

Changes vs. V1:

  - Rebased to net-next

  - Fixed the half done rename sillyness in the ENIC patch.

  - Fixed the IONIC driver fallout.

  - Picked up the SFC fix from Edward and adjusted the GFP_KERNEL change
    accordingly.

  - Addressed the review comments vs. BCRFMAC.

  - Collected Reviewed/Acked-by tags as appropriate.

The pile is also available from:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git net/cleanup

Thanks,

	tglx
---
 Documentation/networking/caif/spi_porting.rst                   |  229 --
 b/Documentation/networking/caif/index.rst                       |    1 
 b/drivers/net/caif/Kconfig                                      |   19 
 b/drivers/net/caif/Makefile                                     |    4 
 b/drivers/net/caif/caif_hsi.c                                   |   19 
 b/drivers/net/ethernet/amd/sun3lance.c                          |   11 
 b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c               |    1 
 b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c               |    2 
 b/drivers/net/ethernet/atheros/atlx/atl2.c                      |    1 
 b/drivers/net/ethernet/chelsio/cxgb3/adapter.h                  |    1 
 b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c               |    2 
 b/drivers/net/ethernet/chelsio/cxgb3/sge.c                      |   44 
 b/drivers/net/ethernet/chelsio/cxgb4/sge.c                      |    3 
 b/drivers/net/ethernet/cisco/enic/enic.h                        |    1 
 b/drivers/net/ethernet/cisco/enic/enic_api.c                    |    6 
 b/drivers/net/ethernet/cisco/enic/enic_main.c                   |   27 
 b/drivers/net/ethernet/freescale/fec_mpc52xx.c                  |   10 
 b/drivers/net/ethernet/intel/e100.c                             |    4 
 b/drivers/net/ethernet/intel/e1000/e1000_main.c                 |    1 
 b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c                  |    2 
 b/drivers/net/ethernet/intel/i40e/i40e_main.c                   |    4 
 b/drivers/net/ethernet/intel/ice/ice_main.c                     |    1 
 b/drivers/net/ethernet/intel/igb/igb_main.c                     |    1 
 b/drivers/net/ethernet/intel/igc/igc_main.c                     |    1 
 b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                 |    1 
 b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c             |    2 
 b/drivers/net/ethernet/natsemi/sonic.c                          |   24 
 b/drivers/net/ethernet/natsemi/sonic.h                          |    2 
 b/drivers/net/ethernet/neterion/vxge/vxge-config.c              |    9 
 b/drivers/net/ethernet/neterion/vxge/vxge-config.h              |    7 
 b/drivers/net/ethernet/pensando/ionic/ionic_dev.c               |    2 
 b/drivers/net/ethernet/pensando/ionic/ionic_lif.c               |   64 
 b/drivers/net/ethernet/pensando/ionic/ionic_lif.h               |    2 
 b/drivers/net/ethernet/pensando/ionic/ionic_main.c              |    4 
 b/drivers/net/ethernet/sfc/ef10.c                               |   24 
 b/drivers/net/ethernet/sfc/efx_common.c                         |    2 
 b/drivers/net/ethernet/sfc/net_driver.h                         |    5 
 b/drivers/net/ethernet/sfc/nic_common.h                         |    7 
 b/drivers/net/ethernet/sun/sunbmac.c                            |   18 
 b/drivers/net/phy/mdio_bus.c                                    |   15 
 b/drivers/net/usb/kaweth.c                                      |  261 --
 b/drivers/net/usb/net1080.c                                     |    1 
 b/drivers/net/wan/lmc/lmc_debug.c                               |   18 
 b/drivers/net/wan/lmc/lmc_debug.h                               |    1 
 b/drivers/net/wan/lmc/lmc_main.c                                |  105 -
 b/drivers/net/wan/lmc/lmc_media.c                               |    4 
 b/drivers/net/wan/lmc/lmc_proto.c                               |   16 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcdc.c       |    4 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c     |    4 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h        |    3 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c       |   26 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h       |    2 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c       |    8 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.h       |    7 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c   |   10 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.h   |    2 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/msgbuf.c     |    7 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/proto.h      |    6 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c       |    8 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.h       |    2 
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c        |    2 
 b/drivers/net/wireless/intel/ipw2x00/ipw2100.c                  |    3 
 b/drivers/net/wireless/intel/ipw2x00/ipw2200.h                  |    6 
 b/drivers/net/wireless/intel/ipw2x00/libipw.h                   |    3 
 b/drivers/net/wireless/intel/iwlegacy/common.h                  |    4 
 b/drivers/net/wireless/intel/iwlwifi/iwl-debug.c                |    5 
 b/drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h         |    6 
 b/drivers/net/wireless/intersil/hostap/hostap_hw.c              |   12 
 b/drivers/net/wireless/marvell/libertas/defs.h                  |    3 
 b/drivers/net/wireless/marvell/libertas/rx.c                    |   11 
 b/drivers/net/wireless/marvell/libertas_tf/deb_defs.h           |    3 
 b/drivers/net/wireless/marvell/mwifiex/uap_txrx.c               |    6 
 b/drivers/net/wireless/marvell/mwifiex/util.c                   |    6 
 b/drivers/net/wireless/realtek/rtlwifi/base.c                   |   47 
 b/drivers/net/wireless/realtek/rtlwifi/base.h                   |    3 
 b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c |   12 
 b/drivers/net/wireless/realtek/rtlwifi/core.c                   |    6 
 b/drivers/net/wireless/realtek/rtlwifi/debug.c                  |   20 
 b/drivers/net/wireless/realtek/rtlwifi/debug.h                  |    8 
 b/drivers/net/wireless/realtek/rtlwifi/pci.c                    |    4 
 b/drivers/net/wireless/realtek/rtlwifi/ps.c                     |   27 
 b/drivers/net/wireless/realtek/rtlwifi/ps.h                     |   10 
 b/drivers/net/wireless/realtek/rtlwifi/wifi.h                   |    3 
 b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c                  |    1 
 b/include/linux/netdevice.h                                     |    1 
 b/net/core/dev.c                                                |   15 
 drivers/net/caif/caif_spi.c                                     |  874 ----------
 drivers/net/caif/caif_spi_slave.c                               |  254 --
 include/net/caif/caif_spi.h                                     |  155 -
 89 files changed, 354 insertions(+), 2234 deletions(-)

