From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 22 Jan 2020 07:21:36 -0800
Subject: [Intel-wired-lan] [PATCH S38 13/15] ice: use proper format for
 function pointer as a function parameter
In-Reply-To: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
Message-ID: <20200122152138.41585-13-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Compiling with gcc-9.2.1 with W=1 points out warnings about the improper
function parameter list.  Fix it.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 4adb8a3ba06e..b6b0f1180b13 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -609,7 +609,7 @@ ice_alloc_buf_slow_zc(struct ice_ring *rx_ring, struct ice_rx_buf *rx_buf)
  */
 static bool
 ice_alloc_rx_bufs_zc(struct ice_ring *rx_ring, int count,
-		     bool alloc(struct ice_ring *, struct ice_rx_buf *))
+		     bool (*alloc)(struct ice_ring *, struct ice_rx_buf *))
 {
 	union ice_32b_rx_flex_desc *rx_desc;
 	u16 ntu = rx_ring->next_to_use;
-- 
2.20.1

