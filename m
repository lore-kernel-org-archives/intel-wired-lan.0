From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  7 Jul 2021 16:40:56 -0700
Subject: [Intel-wired-lan] [net-next v3 01/13] ice: fix Tx queue iteration
 for Tx timestamp enablement
In-Reply-To: <20210707234108.4071506-1-jacob.e.keller@intel.com>
References: <20210707234108.4071506-1-jacob.e.keller@intel.com>
Message-ID: <20210707234108.4071506-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The driver accidentally copied the ice_for_each_rxq iterator when
implementing enablement of the ptp_tx bit for the Tx rings. We still
load the Tx rings and set the ptp_tx field, but we iterate over the
count of the num_rxq.

If the number of Tx and Rx queues differ, this could either cause
a buffer overrun when accessing the tx_rings list if num_txq is greater
than num_rxq, or it could cause us to fail to enable Tx timestamps for
some rings.

This was not noticed originally as we generally have the same number of
Tx and Rx queues.

Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 5d5207b56ca9..e176c7484484 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -22,7 +22,7 @@ static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
 		return;
 
 	/* Set the timestamp enable flag for all the Tx rings */
-	ice_for_each_rxq(vsi, i) {
+	ice_for_each_txq(vsi, i) {
 		if (!vsi->tx_rings[i])
 			continue;
 		vsi->tx_rings[i]->ptp_tx = on;
-- 
2.31.1.331.gb0c09ab8796f

