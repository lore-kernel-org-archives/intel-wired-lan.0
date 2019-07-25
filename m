From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 25 Jul 2019 01:55:28 -0700
Subject: [Intel-wired-lan] [PATCH S23 v4 02/15] ice: Use the software based
 tail when checking for hung Tx ring
In-Reply-To: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
Message-ID: <20190725085541.55104-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently in ice_get_tx_pending we try to read a Tx ring's tail. This is
then compared with the software based head (next_to_clean) to determine
if we have pending work. This will never work because reading of the Tx
ring's tail is no longer supported. Fix this by using the software based
tail (next_to_use) to determine if there is pending work.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index eb3ee6ca9ecc..6f02c29d7830 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -41,12 +41,12 @@ static void ice_update_pf_stats(struct ice_pf *pf);
  * ice_get_tx_pending - returns number of Tx descriptors not processed
  * @ring: the ring of descriptors
  */
-static u32 ice_get_tx_pending(struct ice_ring *ring)
+static u16 ice_get_tx_pending(struct ice_ring *ring)
 {
-	u32 head, tail;
+	u16 head, tail;
 
 	head = ring->next_to_clean;
-	tail = readl(ring->tail);
+	tail = ring->next_to_use;
 
 	if (head != tail)
 		return (head < tail) ?
-- 
2.20.1

