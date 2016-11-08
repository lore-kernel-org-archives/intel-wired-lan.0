From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  8 Nov 2016 13:05:13 -0800
Subject: [Intel-wired-lan] [next PATCH S52-V2 09/15] i40e: Driver prints log
	message on link speed change
In-Reply-To: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478639119-14656-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Filip Sadowski <filip.sadowski@intel.com>

This patch makes the driver log link speed change. Before applying the
patch link messages were printed only on state change. Now message is
printed when link is brought up or down and when speed changes.

Signed-off-by: Filip Sadowski <filip.sadowski@intel.com>
Change-ID: Ifbee14b4b16c24967450b3cecac6e8351dcc8f74
---
Testing-hints:
  Check that link message is logged in system log when link speed
  changes. Use lanconf and a device with backplane NVM image.

 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 4cb8fb3..06e3c23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -596,6 +596,7 @@ struct i40e_vsi {
 	u16 veb_idx;		/* index of VEB parent */
 	struct kobject *kobj;	/* sysfs object */
 	bool current_isup;	/* Sync 'link up' logging */
+	enum i40e_aq_link_speed current_speed;	/* Sync link speed logging */
 
 	void *priv;	/* client driver data reference. */
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 548cbe0..161f512 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5213,12 +5213,16 @@ static int i40e_init_pf_dcb(struct i40e_pf *pf)
  */
 void i40e_print_link_message(struct i40e_vsi *vsi, bool isup)
 {
+	enum i40e_aq_link_speed new_speed;
 	char *speed = "Unknown";
 	char *fc = "Unknown";
 
-	if (vsi->current_isup == isup)
+	new_speed = vsi->back->hw.phy.link_info.link_speed;
+
+	if ((vsi->current_isup == isup) && (vsi->current_speed == new_speed))
 		return;
 	vsi->current_isup = isup;
+	vsi->current_speed = new_speed;
 	if (!isup) {
 		netdev_info(vsi->netdev, "NIC Link is Down\n");
 		return;
-- 
2.4.11

