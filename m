From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri,  6 Nov 2015 15:26:11 -0800
Subject: [Intel-wired-lan] [next PATCH S21 13/14] i40e/i40evf: use logical
	operator
In-Reply-To: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1446852372-25480-14-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

We shouldn't be using a bitwise operator here; it's not a bitwise
operation. Use a logical operator instead. Why doesn't c have a
logical-or-and-assign operator?

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: Id84f3ca884910bed7073c84b1e16a102e958d0de
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index a22efca..d67ac85 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1908,7 +1908,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 	 */
 	i40e_for_each_ring(ring, q_vector->tx) {
 		clean_complete &= i40e_clean_tx_irq(ring, vsi->work_limit);
-		arm_wb |= ring->arm_wb;
+		arm_wb = arm_wb || ring->arm_wb;
 		ring->arm_wb = false;
 	}
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 4e6aacb..9a51ec1 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1332,7 +1332,7 @@ int i40evf_napi_poll(struct napi_struct *napi, int budget)
 	 */
 	i40e_for_each_ring(ring, q_vector->tx) {
 		clean_complete &= i40e_clean_tx_irq(ring, vsi->work_limit);
-		arm_wb |= ring->arm_wb;
+		arm_wb = arm_wb || ring->arm_wb;
 		ring->arm_wb = false;
 	}
 
-- 
2.1.0

