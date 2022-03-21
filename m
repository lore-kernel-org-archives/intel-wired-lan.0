From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 21 Mar 2022 08:05:10 +0200
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove igc_set_spd_dplx method
Message-ID: <20220321060510.1862932-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

igc_set_spd_dplx method not in use. This patch comes to tidy up
the driver code.

Reported-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 -
 drivers/net/ethernet/intel/igc/igc_main.c | 50 -----------------------
 2 files changed, 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 3e386c38d016..1e7e7071f64d 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -264,7 +264,6 @@ int igc_reinit_queues(struct igc_adapter *adapter);
 void igc_write_rss_indir_tbl(struct igc_adapter *adapter);
 bool igc_has_link(struct igc_adapter *adapter);
 void igc_reset(struct igc_adapter *adapter);
-int igc_set_spd_dplx(struct igc_adapter *adapter, u32 spd, u8 dplx);
 void igc_update_stats(struct igc_adapter *adapter);
 void igc_disable_rx_ring(struct igc_ring *ring);
 void igc_enable_rx_ring(struct igc_ring *ring);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 3f193a33d1a9..d0ab915bb31b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6190,56 +6190,6 @@ u32 igc_rd32(struct igc_hw *hw, u32 reg)
 	return value;
 }
 
-int igc_set_spd_dplx(struct igc_adapter *adapter, u32 spd, u8 dplx)
-{
-	struct igc_mac_info *mac = &adapter->hw.mac;
-
-	mac->autoneg = false;
-
-	/* Make sure dplx is at most 1 bit and lsb of speed is not set
-	 * for the switch() below to work
-	 */
-	if ((spd & 1) || (dplx & ~1))
-		goto err_inval;
-
-	switch (spd + dplx) {
-	case SPEED_10 + DUPLEX_HALF:
-		mac->forced_speed_duplex = ADVERTISE_10_HALF;
-		break;
-	case SPEED_10 + DUPLEX_FULL:
-		mac->forced_speed_duplex = ADVERTISE_10_FULL;
-		break;
-	case SPEED_100 + DUPLEX_HALF:
-		mac->forced_speed_duplex = ADVERTISE_100_HALF;
-		break;
-	case SPEED_100 + DUPLEX_FULL:
-		mac->forced_speed_duplex = ADVERTISE_100_FULL;
-		break;
-	case SPEED_1000 + DUPLEX_FULL:
-		mac->autoneg = true;
-		adapter->hw.phy.autoneg_advertised = ADVERTISE_1000_FULL;
-		break;
-	case SPEED_1000 + DUPLEX_HALF: /* not supported */
-		goto err_inval;
-	case SPEED_2500 + DUPLEX_FULL:
-		mac->autoneg = true;
-		adapter->hw.phy.autoneg_advertised = ADVERTISE_2500_FULL;
-		break;
-	case SPEED_2500 + DUPLEX_HALF: /* not supported */
-	default:
-		goto err_inval;
-	}
-
-	/* clear MDI, MDI(-X) override is only allowed when autoneg enabled */
-	adapter->hw.phy.mdix = AUTO_ALL_MODES;
-
-	return 0;
-
-err_inval:
-	netdev_err(adapter->netdev, "Unsupported Speed/Duplex configuration\n");
-	return -EINVAL;
-}
-
 /**
  * igc_probe - Device Initialization Routine
  * @pdev: PCI device information struct
-- 
2.30.2

