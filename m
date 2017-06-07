From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Jun 2017 05:43:10 -0400
Subject: [Intel-wired-lan] [next PATCH S72-V3 10/13] i40e: fix disabling
	overflow promiscuous mode
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <20170607094313.32060-10-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

There exists a bug in which the driver does not correctly exit overflow
promiscuous mode.  This can occur if "too many" mac filters are added,
putting the driver into overflow promiscuous mode, and the filters are
then removed.  When the failed filters are removed, the driver reports
exiting overflow promiscuous mode which is correct, however traffic
continues to be received as if in promiscuous mode still.

The bug occurs because the conditional for toggling promiscuous mode was
set to only execute when promiscuous mode was enabled and not when it
was disabled as well.  This patch fixes the conditional to correctly
execute when promiscuous mode is toggled and not just enabled.  Without
this patch, the driver is unable to correctly exit overflow promiscuous
mode.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5fd4d2f..b7b1f18 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2281,9 +2281,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				 i40e_aq_str(hw, hw->aq.asq_last_status));
 		}
 	}
-	if ((changed_flags & IFF_PROMISC) ||
-	    (promisc_changed &&
-	     test_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state))) {
+
+	if ((changed_flags & IFF_PROMISC) || promisc_changed) {
 		bool cur_promisc;
 
 		cur_promisc = (!!(vsi->current_netdev_flags & IFF_PROMISC) ||
-- 
2.9.3

