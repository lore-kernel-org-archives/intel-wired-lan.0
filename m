From: Alice Michael <alice.michael@intel.com>
Date: Thu, 10 May 2018 05:59:47 -0700
Subject: [Intel-wired-lan] [next PATCH S91 09/11] i40e: cleanup wording in a
 header comment
In-Reply-To: <20180510125949.79823-1-alice.michael@intel.com>
References: <20180510125949.79823-1-alice.michael@intel.com>
Message-ID: <20180510125949.79823-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Fix up the English in the header comment for i40e_ptp_tx_hang.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 4cc8522..8f30cd5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -317,7 +317,7 @@ void i40e_ptp_rx_hang(struct i40e_pf *pf)
  * This watchdog task is run periodically to make sure that we clear the Tx
  * timestamp logic if we don't obtain a timestamp in a reasonable amount of
  * time. It is unexpected in the normal case but if it occurs it results in
- * permanently prevent timestamps of future packets
+ * permanently preventing timestamps of future packets.
  **/
 void i40e_ptp_tx_hang(struct i40e_pf *pf)
 {
-- 
2.9.5

