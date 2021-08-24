From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 23 Aug 2021 17:01:48 -0700
Subject: [Intel-wired-lan] [next-queue v4 03/13] ice: add lock around Tx
 timestamp tracker flush
In-Reply-To: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
Message-ID: <20210824000158.1928482-4-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The driver didn't take the lock while flushing the Tx tracker, which
could cause a race where one thread is trying to read timestamps out
while another thread is trying to read the tracker to check the
timestamps.

Avoid this by ensuring that flushing is locked against read accesses.

Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 09d74e94feae..ae0980f14c80 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1267,6 +1267,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 {
 	u8 idx;
 
+	spin_lock(&tx->lock);
+
 	for (idx = 0; idx < tx->len; idx++) {
 		u8 phy_idx = idx + tx->quad_offset;
 
@@ -1279,6 +1281,8 @@ ice_ptp_flush_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 			tx->tstamps[idx].skb = NULL;
 		}
 	}
+
+	spin_unlock(&tx->lock);
 }
 
 /**
-- 
2.26.2

