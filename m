From: Alice Michael <alice.michael@intel.com>
Date: Fri, 14 Jul 2017 09:10:15 -0400
Subject: [Intel-wired-lan] [next PATCH S76-V2 09/13] i40e: Fix unqualified
	module message while bringing link up
In-Reply-To: <20170714131019.52530-1-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
Message-ID: <20170714131019.52530-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

In current driver, when ifconfig ethx up is done, the link state
doesn't transition to UP inside i40e_open(). It changes after AQ
command response is handled in i40e_handle_link_event().

When pf->hw.phy.link_info.link_info is DOWN inside i40e_open(),
The state is transient and invalid. So log message gets printed
based on incorrect info (i.e link_info and an_info).

This commit removes check for unqualified module inside
i40e_up_complete(). The existing check in i40e_handle_link_event()
logs the error message based on correct link state information.

Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index abf4025..beeeeeb 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5457,15 +5457,6 @@ static int i40e_up_complete(struct i40e_vsi *vsi)
 		i40e_print_link_message(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-	} else if (vsi->netdev) {
-		i40e_print_link_message(vsi, false);
-		/* need to check for qualified module here*/
-		if ((pf->hw.phy.link_info.link_info &
-			I40E_AQ_MEDIA_AVAILABLE) &&
-		    (!(pf->hw.phy.link_info.an_info &
-			I40E_AQ_QUALIFIED_MODULE)))
-			netdev_err(vsi->netdev,
-				   "the driver failed to link because an unqualified module was detected.");
 	}
 
 	/* replay FDIR SB filters */
-- 
2.9.3

