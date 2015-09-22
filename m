From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Tue, 22 Sep 2015 13:57:02 -0700
Subject: [Intel-wired-lan] [net PATCH V2] i40e: fix VLAN inside VXLAN
Message-ID: <1442955422-192436-1-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Previously to this patch, the hardware was removing
VLAN tags from the inner header of VXLAN packets.  The
hardware configuration can be changed to leave the
packet alone since that is what the linux stack
expects for this type of VLAN in VXLAN packet.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2 - capitalized acronyms in commit message
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 9295768..3410fb3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2613,7 +2613,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 		rx_ctx.lrxqthresh = 2;
 	rx_ctx.crcstrip = 1;
 	rx_ctx.l2tsel = 1;
-	rx_ctx.showiv = 1;
+	/* this controls whether VLAN is stripped from inner headers */
+	rx_ctx.showiv = 0;
 #ifdef I40E_FCOE
 	rx_ctx.fc_ena = (vsi->type == I40E_VSI_FCOE);
 #endif
-- 
2.4.3

