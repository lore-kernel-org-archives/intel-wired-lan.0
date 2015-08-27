From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:39 -0400
Subject: [Intel-wired-lan] [next PATCH S12 11/15] i40e: Fix multiple link up
	messages
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-12-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Matt Jared <matthew.a.jared@intel.com>

This patch addresses an issue where multiple link up messages can be logged
resulting from aq link status timing when link properties are changed (fc,
speed, etc.); solved by using a single function to handle status printing
and adding a mechanism to track whether link state (up or down) has
actually changed.

Signed-off-by: Matt Jared <matthew.a.jared@intel.com>
Change-ID: Ied6ed6e49dc397c77d992adc0bc9ed3767152b9d
---
 drivers/net/ethernet/intel/i40e/i40e.h         | 2 ++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 ++++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 877fab3..672ca75 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -539,6 +539,7 @@ struct i40e_vsi {
 	u16 idx;               /* index in pf->vsi[] */
 	u16 veb_idx;           /* index of VEB parent */
 	struct kobject *kobj;  /* sysfs object */
+	bool current_isup;     /* Sync 'link up' logging */
 
 	/* VSI specific handlers */
 	irqreturn_t (*irq_handler)(int irq, void *data);
@@ -793,4 +794,5 @@ int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
 i40e_status i40e_get_npar_bw_setting(struct i40e_pf *pf);
 i40e_status i40e_set_npar_bw_setting(struct i40e_pf *pf);
 i40e_status i40e_commit_npar_bw_setting(struct i40e_pf *pf);
+void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index ef471fc..f2b4f8b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -690,7 +690,7 @@ static int i40e_set_settings(struct net_device *netdev,
 			/* Tell the OS link is going down, the link will go
 			 * back up when fw says it is ready asynchronously
 			 */
-			netdev_info(netdev, "PHY settings change requested, NIC Link is going down.\n");
+			i40e_print_link_message(vsi, false);
 			netif_carrier_off(netdev);
 			netif_tx_stop_all_queues(netdev);
 		}
@@ -834,7 +834,7 @@ static int i40e_set_pauseparam(struct net_device *netdev,
 	/* Tell the OS link is going down, the link will go back up when fw
 	 * says it is ready asynchronously
 	 */
-	netdev_info(netdev, "Flow control settings change requested, NIC Link is going down.\n");
+	i40e_print_link_message(vsi, false);
 	netif_carrier_off(netdev);
 	netif_tx_stop_all_queues(netdev);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6cc0fa0..73c6d37 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4627,11 +4627,14 @@ out:
  * i40e_print_link_message - print link up or down
  * @vsi: the VSI for which link needs a message
  */
-static void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
+void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 {
 	char speed[SPEED_SIZE] = "Unknown";
 	char fc[FC_SIZE] = "RX/TX";
 
+	if (vsi->current_isup == isup)
+		return;
+	vsi->current_isup = isup;
 	if (!isup) {
 		netdev_info(vsi->netdev, "NIC Link is Down\n");
 		return;
-- 
1.9.3

