From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 27 Apr 2015 14:57:09 -0400
Subject: [Intel-wired-lan] [net-next S5 02/15] i40evf: Allow for an
	abundance of vectors
In-Reply-To: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1430161042-28494-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The driver currently only maps TX and RX queues to a single MSI-X vector
per queue pair if there are exactly enough vectors for this.
Unfortunately, if we have too many vectors it will fail and allocate
queues to vectors in a suboptimal manner. Change the condition check to
allow for excess vectors. In this case, the extras just won't be used.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I23e1e2955c64739c86612db88a25583e6a7e0b17
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 37e66ec..23a81da 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -405,7 +405,7 @@ static int i40evf_map_rings_to_vectors(struct i40evf_adapter *adapter)
 	/* The ideal configuration...
 	 * We have enough vectors to map one per queue.
 	 */
-	if (q_vectors == (rxr_remaining * 2)) {
+	if (q_vectors >= (rxr_remaining * 2)) {
 		for (; rxr_idx < rxr_remaining; v_start++, rxr_idx++)
 			i40evf_map_vector_to_rxq(adapter, v_start, rxr_idx);
 
-- 
1.9.3

