From: Alice Michael <alice.michael@intel.com>
Date: Mon,  5 Feb 2018 06:11:15 -0500
Subject: [Intel-wired-lan] [next PATCH S86 V3 2/8] i40e: broadcast filters
 can trigger overflow promiscuous
In-Reply-To: <20180205111121.59468-1-alice.michael@intel.com>
References: <20180205111121.59468-1-alice.michael@intel.com>
Message-ID: <20180205111121.59468-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

When adding a bunch of VLANs to all the ports on a device, it's possible
to run out of space for broadcast filters.  The driver should trigger
overflow promiscuous in this circumstance to prevent traffic from being
unexpectedly dropped.

Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fec1b94..5820c0f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2176,11 +2176,13 @@ i40e_aqc_broadcast_filter(struct i40e_vsi *vsi, const char *vsi_name,
 							    NULL);
 	}
 
-	if (aq_ret)
+	if (aq_ret) {
+		set_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
 		dev_warn(&vsi->back->pdev->dev,
-			 "Error %s setting broadcast promiscuous mode on %s\n",
+			 "Error %s, forcing overflow promiscuous on %s\n",
 			 i40e_aq_str(hw, hw->aq.asq_last_status),
 			 vsi_name);
+	}
 
 	return aq_ret;
 }
-- 
2.9.5

