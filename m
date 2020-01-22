From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 22 Jan 2020 07:21:38 -0800
Subject: [Intel-wired-lan] [PATCH S38 15/15] ice: use true/false for bool
 types
In-Reply-To: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
Message-ID: <20200122152138.41585-15-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

Subject says it all.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index b6b0f1180b13..55d994f2d71e 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -841,8 +841,8 @@ int ice_clean_rx_irq_zc(struct ice_ring *rx_ring, int budget)
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 cleaned_count = ICE_DESC_UNUSED(rx_ring);
 	unsigned int xdp_xmit = 0;
+	bool failure = false;
 	struct xdp_buff xdp;
-	bool failure = 0;
 
 	xdp.rxq = &rx_ring->xdp_rxq;
 
-- 
2.20.1

