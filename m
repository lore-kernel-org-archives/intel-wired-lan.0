From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Tue, 25 Jul 2017 18:13:22 -0700
Subject: [Intel-wired-lan] [PATCH] [next-queue]net: i40e: Proper clean up
 when exiting from setup_tc
Message-ID: <150103160221.33986.12646981723333638260.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix cleaning up and exit from setup_tc on negative scenarios.
Set the tc configuration to default values where only TC0 is
enabled.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |   40 +++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 370ce9f..c367d8d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6608,6 +6608,33 @@ static int i40e_validate_mqprio_qopt(struct i40e_vsi *vsi,
 }
 
 /**
+ * i40e_vsi_set_default_tc_config - set default values for tc configuration
+ * @vsi: the VSI being configured
+ **/
+static void i40e_vsi_set_default_tc_config(struct i40e_vsi *vsi)
+{
+	u16 qcount;
+	int i;
+
+	/* Only TC0 is enabled */
+	vsi->tc_config.numtc = 1;
+	vsi->tc_config.enabled_tc = 1;
+	qcount = min_t(int, vsi->alloc_queue_pairs,
+		       i40e_pf_get_max_q_per_tc(vsi->back));
+	for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
+		/* For the TC that is not enabled set the offset to to default
+		 * queue and allocate one queue for the given TC.
+		 */
+		vsi->tc_config.tc_info[i].qoffset = 0;
+		if (i == 0)
+			vsi->tc_config.tc_info[i].qcount = qcount;
+		else
+			vsi->tc_config.tc_info[i].qcount = 1;
+		vsi->tc_config.tc_info[i].netdev_tc = 0;
+	}
+}
+
+/**
  * i40e_setup_tc - configure multiple traffic classes
  * @netdev: net device to configure
  * @tc: pointer to struct tc_to_netdev
@@ -6706,7 +6733,7 @@ static int i40e_setup_tc(struct net_device *netdev, struct tc_to_netdev *tc)
 	if (ret) {
 		netdev_info(netdev, "Failed configuring TC for VSI seid=%d\n",
 			    vsi->seid);
-		goto exit;
+		goto reset;
 	}
 
 	if (pf->flags & I40E_FLAG_TC_MQPRIO) {
@@ -6721,23 +6748,24 @@ static int i40e_setup_tc(struct net_device *netdev, struct tc_to_netdev *tc)
 					max_tx_rate / I40E_BW_CREDIT_DIVISOR,
 					vsi->seid);
 			else
-				goto exit;
+				goto reset;
 		}
 		ret = i40e_configure_queue_channels(vsi);
 		if (ret) {
 			netdev_info(netdev,
 				    "Failed configuring queue channels\n");
-			goto exit;
+			goto reset;
 		}
 	}
 
 	goto out;
-exit:
-	/* Reset the configuration data */
-	memset(&vsi->tc_config, 0, sizeof(vsi->tc_config));
+reset:
+	/* Reset the configuration data to defaults, only TC0 is enabled */
+	i40e_vsi_set_default_tc_config(vsi);
 out:
 	/* Unquiesce VSI */
 	i40e_unquiesce_vsi(vsi);
+exit:
 	return ret;
 }
 

