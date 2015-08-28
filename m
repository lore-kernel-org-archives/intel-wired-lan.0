From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 28 Aug 2015 17:55:55 -0400
Subject: [Intel-wired-lan] [next PATCH S13 09/15] i40evf: Fix check_tx_hang
In-Reply-To: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
References: <1440798961-17326-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440798961-17326-10-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We were missing an else so add it back in.

Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 45260c2..7b20f53 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -191,6 +191,8 @@ static bool i40e_check_tx_hang(struct i40e_ring *tx_ring)
 				       &tx_ring->state);
 	} else if (tx_done_old == tx_done &&
 		   (tx_pending < I40E_MIN_DESC_PENDING) && (tx_pending > 0)) {
+		/* do nothing */
+	} else {
 		/* update completed stats and disarm the hang check */
 		tx_ring->tx_stats.tx_done_old = tx_done;
 		clear_bit(__I40E_HANG_CHECK_ARMED, &tx_ring->state);
-- 
1.9.3

