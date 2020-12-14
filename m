From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 14 Dec 2020 16:13:07 +0100
Subject: [Intel-wired-lan] [PATCH v2 net-next 7/8] ice: skip NULL check
 against XDP prog in ZC path
In-Reply-To: <20201214151308.15275-1-maciej.fijalkowski@intel.com>
References: <20201214151308.15275-1-maciej.fijalkowski@intel.com>
Message-ID: <20201214151308.15275-8-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Whole zero-copy variant of clean Rx irq is executed when xsk_pool is
attached to rx_ring and it can happen only when XDP program is present
on interface. Therefore it is safe to assume that program is always
!NULL and there is no need for checking it in ice_run_xdp_zc.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 797886524054..9aea97ca4a04 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -514,11 +514,10 @@ ice_run_xdp_zc(struct ice_ring *rx_ring, struct xdp_buff *xdp)
 	u32 act;
 
 	rcu_read_lock();
+	/* ZC patch is enabled only when XDP program is set,
+	 * so here it can not be NULL
+	 */
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
-	if (!xdp_prog) {
-		rcu_read_unlock();
-		return ICE_XDP_PASS;
-	}
 
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
 	switch (act) {
-- 
2.20.1

