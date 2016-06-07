From: Usha Ketineni <usha.k.ketineni@intel.com>
Date: Tue, 07 Jun 2016 09:14:55 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Don't notify client(s) for DCB
	changes on all VSIs
Message-ID: <20160607161455.4203.31219.stgit@ukketine.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Neerav Parikh <neerav.parikh@intel.com>

When LLDP/DCBX change happens the i40e driver code flow tried to
notify the client(s) for each of the PF VSIs. This resulted into
kernel panic on the first VSI that didn't have any netdev
associated to it.

The DCB change notification to the client(s) should be done only
once for the PF/LAN VSI where the client(s) instances have been
added to. Also, move the notification call after the PF driver has
made changes related to the updated DCB configuration.

Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>
Tested-by: Ronald J Bynoe <ronald.j.bynoe@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5ea2200..8b54894 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4958,7 +4958,6 @@ static void i40e_dcb_reconfigure(struct i40e_pf *pf)
 			if (pf->vsi[v]->netdev)
 				i40e_dcbnl_set_all(pf->vsi[v]);
 		}
-		i40e_notify_client_of_l2_param_changes(pf->vsi[v]);
 	}
 }
 
@@ -5716,6 +5715,8 @@ static int i40e_handle_lldp_event(struct i40e_pf *pf,
 		i40e_service_event_schedule(pf);
 	} else {
 		i40e_pf_unquiesce_all_vsi(pf);
+		/* Notify the client for the DCB changes */
+		i40e_notify_client_of_l2_param_changes(pf->vsi[pf->lan_vsi]);
 	}
 
 exit:

