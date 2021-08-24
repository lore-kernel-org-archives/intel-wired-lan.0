From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 23 Aug 2021 17:01:51 -0700
Subject: [Intel-wired-lan] [next-queue v4 06/13] ice: PTP: move setting of
 tstamp_config
In-Reply-To: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
Message-ID: <20210824000158.1928482-7-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The tstamp_config structure is being set inside of
ice_ptp_cfg_timestamp, which is the function used to set Tx and
Rx timestamping during initialization.

This function is also used in order to set the PHY port timestamping
status. However, it makes sense to always set the tstamp_config directly
whenever the ice_set_tx_tstamp or ice_set_rx_tstamp functions are
called.

Move assignment of tstamp_config into the related functions and out of
ice_ptp_cfg_timestamp.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 904ad94dd9db..803237152fc7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -35,6 +35,11 @@ static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
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
@@ -57,6 +62,11 @@ static void ice_set_rx_tstamp(struct ice_pf *pf, bool on)
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
@@ -71,14 +81,6 @@ static void ice_ptp_cfg_timestamp(struct ice_pf *pf, bool ena)
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
@@ -977,7 +979,6 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 	case HWTSTAMP_FILTER_NTP_ALL:
 	case HWTSTAMP_FILTER_ALL:
-		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		ice_set_rx_tstamp(pf, true);
 		break;
 	default:
-- 
2.26.2

