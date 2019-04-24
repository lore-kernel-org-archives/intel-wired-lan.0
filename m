From: Alice Michael <alice.michael@intel.com>
Date: Wed, 24 Apr 2019 05:20:48 -0700
Subject: [Intel-wired-lan] [next PATCH S5 03/10] i40e: Use signed variable
In-Reply-To: <20190424122055.27896-1-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
Message-ID: <20190424122055.27896-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The counter variable in i40e_clean_tx_irq starts out negative and climbs
to 0. So it should not be defined as a u16. This was working by accident
due to the fact the u16 overflows and underflows predictably.

Replace the u16 with int, which is signed and can handle the negativity.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index edd6532c943f..ef41de9faa26 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -774,7 +774,7 @@ void i40e_detect_recover_hung(struct i40e_vsi *vsi)
 static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
 			      struct i40e_ring *tx_ring, int napi_budget)
 {
-	u16 i = tx_ring->next_to_clean;
+	int i = tx_ring->next_to_clean;
 	struct i40e_tx_buffer *tx_buf;
 	struct i40e_tx_desc *tx_head;
 	struct i40e_tx_desc *tx_desc;
-- 
2.19.2

