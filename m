From: Alice Michael <alice.michael@intel.com>
Date: Tue, 31 Jul 2018 03:41:45 -0700
Subject: [Intel-wired-lan] [next PATCH S93 08/11] i40e: fix warning about
 shadowed ring parameter
In-Reply-To: <20180731104148.11896-1-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
Message-ID: <20180731104148.11896-8-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

In commit 147e81ec7568 ("i40e: Test memory before ethtool alloc succeeds")
code was added to handle ring allocation on systems with low memory.

It shadowed the ring parameter pointer by introducing a local ring
pointer inside the for loop. Most of the code in the loop already just
accessed the ring via &rx_rings[i]. Since most of the code already does
this, just remove the local variable.

If someone considers it worth keeping a local around, they should use it
for the whole section instead of just a couple of accesses.

This fixes a warning when -Wshadow is enabled

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 12d279a..cd23d1e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1589,7 +1589,6 @@ static int i40e_set_ringparam(struct net_device *netdev,
 		}
 
 		for (i = 0; i < vsi->num_queue_pairs; i++) {
-			struct i40e_ring *ring;
 			u16 unused;
 
 			/* clone ring and setup updated count */
@@ -1613,9 +1612,8 @@ static int i40e_set_ringparam(struct net_device *netdev,
 			/* now allocate the Rx buffers to make sure the OS
 			 * has enough memory, any failure here means abort
 			 */
-			ring = &rx_rings[i];
-			unused = I40E_DESC_UNUSED(ring);
-			err = i40e_alloc_rx_buffers(ring, unused);
+			unused = I40E_DESC_UNUSED(&rx_rings[i]);
+			err = i40e_alloc_rx_buffers(&rx_rings[i], unused);
 rx_unwind:
 			if (err) {
 				do {
-- 
2.9.5

