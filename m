From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 11 Oct 2021 14:54:26 -0700
Subject: [Intel-wired-lan] [net-next PATCH 2/9] ice: PTP: move setting of
 tstamp_config
In-Reply-To: <20211011215433.1525457-1-jacob.e.keller@intel.com>
References: <20211011215433.1525457-1-jacob.e.keller@intel.com>
Message-ID: <20211011215433.1525457-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The tstamp_config structure is being set inside of
ice_ptp_cfg_timestamp, which is the function used to set Tx and
Rx timestamping during initialization.

This function is also used in order to set the PHY port timestamping
status. However, it makes sense to always set the tstamp_config directly
whenever the ice_set_tx_tstamp or ice_set_rx_tstamp functions are
called.

Move assignment of tstamp_config into the related functions and out of
ice_ptp_cfg_timestamp.

Now that we assign the timestamp mode in the relevant functions, we no
longer modify the config valuie in ice_set_timestamp_mode. In turn, we
no longer want to copy that config value into the PF cached structure.
Instead, this is now the source of truth for actual configuration. On
success of ice_set_timestamp_mode, copy the real configured mode back to
report it out to userspace.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 71e715c7be4f..155842447ebe 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -285,6 +285,11 @@ static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
 	else
 		val &= ~PFINT_OICR_TSYN_TX_M;
 	wr32(&pf->hw, PFINT_OICR_ENA, val);
+
+	if (on)
+		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_ON;
+	else
+		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_OFF;
 }
 
 /**
@@ -307,6 +312,11 @@ static void ice_set_rx_tstamp(struct ice_pf *pf, bool on)
 			continue;
 		vsi->rx_rings[i]->ptp_rx = on;
 	}
+
+	if (on)
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
+	else
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 }
 
 /**
@@ -321,14 +331,6 @@ static void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena)
 {
 	ice_set_tx_tstamp(pf, ena);
 	ice_set_rx_tstamp(pf, ena);
-
-	if (ena) {
-		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
-		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_ON;
-	} else {
-		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
-		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_OFF;
-	}
 }
 
 /**
@@ -1256,7 +1258,6 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
 	case HWTSTAMP_FILTER_ALL:
-		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		ice_set_rx_tstamp(pf, true);
 		break;
 	default:
@@ -1288,8 +1289,8 @@ int ice_ptp_set_ts_config(struct ice_pf *pf, struct ifreq *ifr)
 	if (err)
 		return err;
 
-	/* Save these settings for future reference */
-	pf->ptp.tstamp_config = config;
+	/* Return the actual configuration set */
+	config = pf->ptp.tstamp_config;
 
 	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
 		-EFAULT : 0;
-- 
2.31.1.331.gb0c09ab8796f

