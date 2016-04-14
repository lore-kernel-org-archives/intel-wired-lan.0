From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Thu, 14 Apr 2016 06:19:34 -0700
Subject: [Intel-wired-lan] [next PATCH S35 14/14] i40e: Test memory before
	ethtool alloc succeeds
In-Reply-To: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460639974-2556-15-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

When testing on systems with very limited amounts of RAM, a bug was
found where, while changing the number of descriptors using ethtool,
the driver didn't test the limits of system memory before permanently
assuming it would be able to get receive buffer memory.

Work around this issue by pre-allocation of the receive buffer
memory, in the "ghost" ring, which is then used during reinit
using the new ring length.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-Id: I92d7a5fb59a6c884b2efdd1ec652845f101c3359
---
Testing Hints : see original report in
bugzilla https://bugzilla.redhat.com/show_bug.cgi?id=1312502,
generally do ethtool -G changes on i686 RHEL6.7

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 34 +++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index feb370b..deb8762 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1274,6 +1274,13 @@ static int i40e_set_ringparam(struct net_device *netdev,
 		}
 
 		for (i = 0; i < vsi->num_queue_pairs; i++) {
+			/* this is to allow wr32 to have something to write to
+			 * during early allocation of rx buffers
+			 */
+			u32 __iomem faketail = 0;
+			struct i40e_ring *ring;
+			u16 unused;
+
 			/* clone ring and setup updated count */
 			rx_rings[i] = *vsi->rx_rings[i];
 			rx_rings[i].count = new_rx_count;
@@ -1282,12 +1289,22 @@ static int i40e_set_ringparam(struct net_device *netdev,
 			 */
 			rx_rings[i].desc = NULL;
 			rx_rings[i].rx_bi = NULL;
+			rx_rings[i].tail = (u8 __iomem *)&faketail;
 			err = i40e_setup_rx_descriptors(&rx_rings[i]);
+			if (err)
+				goto rx_unwind;
+
+			/* now allocate the rx buffers to make sure the OS
+			 * has enough memory, any failure here means abort
+			 */
+			ring = &rx_rings[i];
+			unused = I40E_DESC_UNUSED(ring);
+			err = i40e_alloc_rx_buffers(ring, unused);
+rx_unwind:
 			if (err) {
-				while (i) {
-					i--;
+				do {
 					i40e_free_rx_resources(&rx_rings[i]);
-				}
+				} while (i--);
 				kfree(rx_rings);
 				rx_rings = NULL;
 
@@ -1313,6 +1330,17 @@ static int i40e_set_ringparam(struct net_device *netdev,
 	if (rx_rings) {
 		for (i = 0; i < vsi->num_queue_pairs; i++) {
 			i40e_free_rx_resources(vsi->rx_rings[i]);
+			/* get the real tail offset */
+			rx_rings[i].tail = vsi->rx_rings[i]->tail;
+			/* this is to fake out the allocation routine
+			 * into thinking it has to realloc everything
+			 * but the recycling logic will let us re-use
+			 * the buffers allocated above
+			 */
+			rx_rings[i].next_to_use = 0;
+			rx_rings[i].next_to_clean = 0;
+			rx_rings[i].next_to_alloc = 0;
+			/* do a struct copy */
 			*vsi->rx_rings[i] = rx_rings[i];
 		}
 		kfree(rx_rings);
-- 
2.4.3

