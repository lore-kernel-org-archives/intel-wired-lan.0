From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  9 Sep 2016 09:10:51 -0700
Subject: [Intel-wired-lan] [PATCH] igb: restore PPS signal on igb_ptp_reset
Message-ID: <20160909161051.8954-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When a reset occurs, the PPS SYS_WRAP interrupt was not re-enabled which
resulted in disabling of the PPS signaling. Fix this by recording when
the interrupt is on and ensuring that we re-enable it every time we
reset.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h     | 1 +
 drivers/net/ethernet/intel/igb/igb_ptp.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 20b9fa89c4c1..1da2d7d795a8 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -492,6 +492,7 @@ struct igb_adapter {
 	struct timecounter tc;
 	u32 tx_hwtstamp_timeouts;
 	u32 rx_hwtstamp_cleared;
+	bool pps_sys_wrap_on;
 
 	struct ptp_pin_desc sdp_config[IGB_N_SDP];
 	struct {
diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 66dfa2085cc7..f2f348079397 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -591,6 +591,7 @@ static int igb_ptp_feature_enable_i210(struct ptp_clock_info *ptp,
 			tsim |= TSINTR_SYS_WRAP;
 		else
 			tsim &= ~TSINTR_SYS_WRAP;
+		igb->pps_sys_wrap_on = !!on;
 		wr32(E1000_TSIM, tsim);
 		spin_unlock_irqrestore(&igb->tmreg_lock, flags);
 		return 0;
@@ -1235,7 +1236,9 @@ void igb_ptp_reset(struct igb_adapter *adapter)
 	case e1000_i211:
 		wr32(E1000_TSAUXC, 0x0);
 		wr32(E1000_TSSDP, 0x0);
-		wr32(E1000_TSIM, TSYNC_INTERRUPTS);
+		wr32(E1000_TSIM,
+		     TSYNC_INTERRUPTS |
+		     (adapter->pps_sys_wrap_on ? TSINTR_SYS_WRAP : 0));
 		wr32(E1000_IMS, E1000_IMS_TS);
 		break;
 	default:
-- 
2.10.0.443.g7d82ce0

