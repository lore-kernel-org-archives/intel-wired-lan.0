From: Alice Michael <alice.michael@intel.com>
Date: Thu,  7 Sep 2017 08:05:50 -0400
Subject: [Intel-wired-lan] [next PATCH S80-V3 05/11] i40e: reduce lrxqthresh
	from 2 to 1
In-Reply-To: <20170907120556.45699-1-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
Message-ID: <20170907120556.45699-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The lrxq thresh value tells hardware to immediately interrupt when there
are fewer than N*64 packets left in the ring.

Counter intuitively, empirical testing has shown that decreasing this
value from 2 to 1, and thus changing from an immediate interrupt at
fewer than 128 descriptors down to 64 descriptors causes a small
increase in the maximum total packets per second we can receive. This
increase occurs even when we're polling with interrupts masked, as the
hardware must still handle interrupts internally even if we've disabled
them in software.

Also reduce the value for any VFs we allocate.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3d9b65f..a47f4ed 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3030,7 +3030,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	if (hw->revision_id == 0)
 		rx_ctx.lrxqthresh = 0;
 	else
-		rx_ctx.lrxqthresh = 2;
+		rx_ctx.lrxqthresh = 1;
 	rx_ctx.crcstrip = 1;
 	rx_ctx.l2tsel = 1;
 	/* this controls whether VLAN is stripped from inner headers */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index c7f0a72..7dc042b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -636,7 +636,7 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 	rx_ctx.dsize = 1;
 
 	/* default values */
-	rx_ctx.lrxqthresh = 2;
+	rx_ctx.lrxqthresh = 1;
 	rx_ctx.crcstrip = 1;
 	rx_ctx.prefena = 1;
 	rx_ctx.l2tsel = 1;
-- 
2.9.4

